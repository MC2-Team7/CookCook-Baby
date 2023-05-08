//
//  CentralViewModel.swift
//  CookCookBaby
//
//  Created by 김예림 on 2023/05/08.
//

import Foundation
import CoreBluetooth
import os

class CentralViewModel: NSObject, ObservableObject {
    
    @Published var message: String = ""
    var centralManager: CBCentralManager!
    var discoveredPeripheral: CBPeripheral?
    var transferCharacteristic: CBCharacteristic?
    var writeIterationsComplete = 0
    var connectionIterationsComplete = 0
    let defaultIterations = 5
    var data: Data = Data()
    
    //초기화
    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil, options: [CBCentralManagerOptionShowPowerAlertKey: true])
    }
    
    //view가 disappear 될 때, stop scanning..
    func stopAction() {
        centralManager.stopScan()
    }
    
    
    private func cleanup() {
        guard let discoveredPeripheral = discoveredPeripheral,
              case .connected = discoveredPeripheral.state else { return }
        
        for service in (discoveredPeripheral.services ?? [] as [CBService]) {
            for characteristic in (service.characteristics ?? [] as [CBCharacteristic]) {
                if characteristic.uuid == TransferService.characteristicUUID && characteristic.isNotifying {
                    self.discoveredPeripheral?.setNotifyValue(false, for: characteristic)
                }
            }
        }
        
        centralManager.cancelPeripheralConnection(discoveredPeripheral)
    }
    
    private func writeData() {
        guard let discoveredPeripheral = discoveredPeripheral, let transferCharacteristic = transferCharacteristic
        else {
            return
        }
        
        while writeIterationsComplete < defaultIterations && discoveredPeripheral.canSendWriteWithoutResponse {
            
//            let mtu = discoveredPeripheral.maximumWriteValueLength (for: .withoutResponse)
//            var rawPacket = [UInt8]()
//
//            let bytesToCopy: size_t = min(mtu, data.count)
//            data.copyBytes(to: &rawPacket, count: bytesToCopy)
//            let packetData = Data(bytes: &rawPacket, count: bytesToCopy)
//
//            let stringFromData = String(data: packetData, encoding: .utf8)
//            os_log("Writing %d bytes: %s", bytesToCopy, String(describing: stringFromData))
//
//            discoveredPeripheral.writeValue(packetData, for: transferCharacteristic, type: .withoutResponse)
//
            writeIterationsComplete += 1
        }
        
        if writeIterationsComplete == defaultIterations {
            discoveredPeripheral.setNotifyValue(false, for: transferCharacteristic)
        }
    }
    
    // 전송 받기 시작 - 연결 시도
    private func retrievePeripheral() {
        
        let connectedPeripherals: [CBPeripheral] = (centralManager.retrieveConnectedPeripherals(withServices: [TransferService.serviceUUID]))
        
        os_log("Found connected Peripherals with transfer service: %@", connectedPeripherals)
        
        if let connectedPeripheral = connectedPeripherals.last {
            os_log("Connecting to peripheral %@", connectedPeripheral)
            self.discoveredPeripheral = connectedPeripheral
            centralManager.connect(connectedPeripheral, options: nil)
        } else {
            centralManager.scanForPeripherals(withServices: [TransferService.serviceUUID], options: nil)
        }
    }
}


extension CentralViewModel: CBCentralManagerDelegate {
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOn:
            print(".powerOn")
            retrievePeripheral()
            return
            
        case .poweredOff :
            print(".powerOff")
            return
            
        case .resetting:
            print(".restting")
            return
            
        case .unauthorized:
            print(".unauthorized")
            return
            
        case .unknown:
            print(".unknown")
            return
            
        case .unsupported:
            print(".unsupported")
            return
            
        @unknown default:
            print("A previously unknown central manager state occurred")
            return
        }
    }
    
    // 신호가 가장 강한 기기 찾기
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        guard RSSI.intValue >= -50 else {
            return
        }
        
        if discoveredPeripheral != peripheral {
            discoveredPeripheral = peripheral
            centralManager.connect(peripheral, options: nil)
        }
    }
    
    // 연결이 완료됐을 때 - 1대의 기기와의 견결
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        centralManager.stopScan()
        
        connectionIterationsComplete += 1
        writeIterationsComplete = 0
        
        data.removeAll(keepingCapacity: false)
        
        peripheral.delegate = self
        peripheral.discoverServices([TransferService.serviceUUID])
    }
    
    // 연결 실패했을 때
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        cleanup()
    }
    
    // 연결 종료
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        discoveredPeripheral = nil
        
        if connectionIterationsComplete < defaultIterations {
            retrievePeripheral()
        } else {
            print("Connection iterations completed")
        }
    }
}


extension CentralViewModel: CBPeripheralDelegate {
    
    // Characteristic
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        if error != nil {
            cleanup()
            return
        }
        
        guard let peripheralServices = peripheral.services else {
            return
        }
        
        for service in peripheralServices {
            peripheral.discoverCharacteristics([TransferService.characteristicUUID], for: service)
        }
    }
    
    // 전송 문자 discovering
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        
        if let error = error {
            print("Error discovering characteristics: \(error.localizedDescription)")
            cleanup()
            return
        }
        
        guard let serviceCharacteristics = service.characteristics else {
            return
        }
        
        for characteristic in serviceCharacteristics where characteristic.uuid == TransferService.characteristicUUID {
            transferCharacteristic = characteristic
            peripheral.setNotifyValue(true, for: characteristic)
        }
    }
    
    // 전송 문자 값 update
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        if let error = error {
            print("Error discovering characteristics: \(error.localizedDescription)")
            cleanup()
            return
        }
        
        guard let characteristicData = characteristic.value,
            let stringFromData = String(data: characteristicData, encoding: .utf8) else {
            return
        }
        
        print("Received \(characteristicData.count) bytes: \(stringFromData)")
        
        if stringFromData == "EOM" {
            message = String(data: data, encoding: .utf8) ?? ""
            writeData()
            
        } else {
            data.append(characteristicData)
        }
    }

    // 주변 기기가 수신 혹은 정지 알림을 update 받았을 때
    func peripheral(_ peripheral: CBPeripheral, didUpdateNotificationStateFor characteristic: CBCharacteristic, error: Error?) {
        
        if let error = error {
            print("Error changing notification state: \(error.localizedDescription)")
            return
        }
       
        guard characteristic.uuid == TransferService.characteristicUUID else {
            return
        }
        
        if characteristic.isNotifying {
            // 알림 시작
            print("Notification began on \(characteristic)")
        } else {
            // 알림 종료
            print("Notification stopped on \(characteristic). Disconnecting")
            cleanup()
        }
    }
    
    // 전송 대기
    func peripheralIsReady(toSendWriteWithoutResponse peripheral: CBPeripheral) {
        print("Peripheral is ready, send data")
        writeData()
    }
}

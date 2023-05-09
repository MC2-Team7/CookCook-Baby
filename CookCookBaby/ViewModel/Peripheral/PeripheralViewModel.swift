//
//  PeripheralViewModel.swift
//  CookCookBaby
//
//  Created by 김예림 on 2023/05/08.
//

import Foundation
import CoreBluetooth
import os

class PeripheralViewModel: NSObject, ObservableObject {
    
    @Published var message: String = ""
    @Published var isPossibleToSend: Bool = false
    var peripheralManager: CBPeripheralManager!
    var transferCharacteristic: CBMutableCharacteristic?
    var connectedCentral: CBCentral?
    var dataToSend = Data()
    var sendDataIndex: Int = 0
    
    
    override init() {
        super.init()
        peripheralManager = CBPeripheralManager(delegate: self, queue: nil, options: [CBPeripheralManagerOptionShowPowerAlertKey: true])
    }
    
    func switchChanged() {
        if isPossibleToSend {
            peripheralManager.startAdvertising([CBAdvertisementDataServiceUUIDsKey: [TransferService.serviceUUID]])
            
        } else {
            stopAction()
        }
    }
    
    func stopAction() {
        peripheralManager.stopAdvertising()
    }
    
    private func setUpPeripheral() {
        let transferCharacteristic = CBMutableCharacteristic(type: TransferService.characteristicUUID,
                                                             properties: [.notify, .writeWithoutResponse],
                                                             value: nil,
                                                             permissions: [.readable, .writeable])

        let transferService = CBMutableService(type: TransferService.serviceUUID, primary: true)

        transferService.characteristics = [transferCharacteristic]

        peripheralManager.add(transferService)
        
        self.transferCharacteristic = transferCharacteristic
    }
    
    static var sendingEOM = false
    
    private func sendData() {
        
        guard let transferCharacteristic = transferCharacteristic else {
            return
        }
        

        if PeripheralViewModel.sendingEOM {
            let didSend = peripheralManager.updateValue("EOM".data(using: .utf8)!, for: transferCharacteristic, onSubscribedCentrals: nil)
            
            if didSend {
                PeripheralViewModel.sendingEOM = false
                print("Sent: EOM")
            }
            return
        }
        
        if sendDataIndex >= dataToSend.count {
            return
        }
        
        var didSend = true
        while didSend {
            
            var amountToSend = dataToSend.count - sendDataIndex
            if let mtu = connectedCentral?.maximumUpdateValueLength {
                amountToSend = min(amountToSend, mtu)
            }
            

            let chunk = dataToSend.subdata(in: sendDataIndex..<(sendDataIndex + amountToSend))
            
            didSend = peripheralManager.updateValue(chunk, for: transferCharacteristic, onSubscribedCentrals: nil)
            

            if !didSend {
                return
            }
            
            let stringFromData = String(data: chunk, encoding: .utf8)
            print("Sent \(chunk.count) bytes: \(String(describing: stringFromData))")
            

            sendDataIndex += amountToSend
           
            if sendDataIndex >= dataToSend.count {

                PeripheralViewModel.sendingEOM = true
                
       
                let eomSent = peripheralManager.updateValue("EOM".data(using: .utf8)!,
                                                            for: transferCharacteristic, onSubscribedCentrals: nil)
                if eomSent {
                  
                    PeripheralViewModel.sendingEOM = false
                    print("Sent: EOM")
                }
                return
            }
        }
    }
}


extension PeripheralViewModel: CBPeripheralManagerDelegate {
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        switch peripheral.state {
        case .poweredOn:
            print(".powerOn")
            setUpPeripheral()
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
            
        default:
            print("A previously unknown central manager state occurred")
            return
        }
    }
    

    func peripheralManager(_ peripheral: CBPeripheralManager, central: CBCentral, didSubscribeTo characteristic: CBCharacteristic) {
        print("Central subscribed to characteristic")
        
        if let message = message.data(using: .utf8) {
            dataToSend = message
        }
     
        sendDataIndex = 0
        
        connectedCentral = central
        

        sendData()
    }
    

    func peripheralManager(_ peripheral: CBPeripheralManager, central: CBCentral, didUnsubscribeFrom characteristic: CBCharacteristic) {
        print("Central unsubscribed from characteristic")
        connectedCentral = nil
    }
    
  
    func peripheralManagerIsReady(toUpdateSubscribers peripheral: CBPeripheralManager) {
        sendData()
    }
    

    func peripheralManager(_ peripheral: CBPeripheralManager, didReceiveWrite requests: [CBATTRequest]) {
        for aRequest in requests {
            guard let requestValue = aRequest.value,
                  let stringFromData = String(data: requestValue, encoding: .utf8) else {
                continue
            }
            
            print("Received write request of \(requestValue.count) bytes: \(stringFromData)")
            message = stringFromData
        }
    }
}


//
//  DeviceVC.swift
//  GrinChallenge
//
//  Created by Stephane Gardon on 2/19/19.
//  Copyright © 2019 Stephane Gardon. All rights reserved.
//

import UIKit
import CoreBluetooth

struct BluetoothServiceConstants{
    // Battery
    static let batteryLevel         = "2A19"
    // Device information
    static let systemID             = "2A23"
    static let modelNumber          = "2A24"
    static let serialNumber         = "2A25"
    static let firmwareRevision     = "2A26"
    static let hardwareRevision     = "2A27"
    static let manufacturerName     = "2A29"
    // Service
    static let batteryService       = "180F"
    static let deviceInformation    = "180A"
    static let genericAccess        = "1800"
}

class DeviceVC: UIViewController {
    
    var centralManager: CBCentralManager!
    var devicesPeripheral: [DeviceRecord] = []
    let pendingOperations = PendingOperations()
    
    @IBOutlet weak var btnReload: UIButton!
    @IBOutlet weak var tableViewDeviceArea: UITableView!
    
    var activityIndicatorViewDeviceArea: UIActivityIndicatorView!
    var activityIndicatorViewDeviceSaved: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.centralManager = CBCentralManager(delegate: self, queue: nil)
        
        self.tableViewDeviceArea.register( DeviceDetectedTVC.self, forCellReuseIdentifier: "DeviceDetectedTVC")
        self.tableViewDeviceArea.register( DeviceDetectedTVC.self, forCellReuseIdentifier: "CellIdentifier")
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.startScan()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        DispatchQueue.main.async { [weak self] in
            guard let selfCustom = self else {return }
            selfCustom.centralManager.stopScan()
            let operations =  selfCustom.pendingOperations.connectionInProgress
            
            for op in operations{
                op.value.cancel()
            }
            
//            if selfCustom.pendingOperations.connectionInProgress.count > 0 {
//                selfCustom.pendingOperations.connectionInProgress.removeAll()
//            }
//            if selfCustom.devicesPeripheral.count > 0{
//                selfCustom.devicesPeripheral.removeAll()
//                selfCustom.tableViewDeviceArea.reloadData()
//            }
//            selfCustom.devicesPeripheral.removeAll()
//            selfCustom.tableViewDeviceArea.reloadData()
            
        }

    }
    @IBAction func reloadAction(_ sender: Any) {
        self.startScan()
    }
    
    func startLoadDevicesAreaIndicator(){
        if activityIndicatorViewDeviceArea == nil {
            self.activityIndicatorViewDeviceArea = UIActivityIndicatorView(style: .gray)
        }
        self.tableViewDeviceArea.backgroundView = self.activityIndicatorViewDeviceArea
        self.activityIndicatorViewDeviceArea.startAnimating()
    }
    
    func stopLoadDevicesAreaIndicator(){
        if activityIndicatorViewDeviceArea != nil {
            activityIndicatorViewDeviceArea.stopAnimating()
        }
        
    }
    
}

// MARK: - WS
extension DeviceVC {

    func successAddDevices(device: DeviceRecord, index:IndexPath){
        DispatchQueue.main.async { [weak self] in
            guard let selfCustom = self else {return }
            device.state = .saved
            selfCustom.tableViewDeviceArea.reloadRows(at: [index], with: .automatic)
        }
    }
    
}
// MARK: - CBCentralManagerDelegate
extension DeviceVC : CBCentralManagerDelegate{
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        
        
        switch central.state {
            
        case .unknown:
            print("central.state is .unknown")
        case .resetting:
            print("central.state is .resetting")
        case .unsupported:
            print("central.state is .unsupported")
        case .unauthorized:
            print("central.state is .unauthorized")
        case .poweredOff:
            print("central.state is .poweredOff")
        case .poweredOn:
            print("central.state is .poweredOn")
            startScan()
        @unknown default:
            print("central.state is .default")
        }
        
    }
    
    
    func centralManager(_ central: CBCentralManager,
                        didDiscover peripheral: CBPeripheral,
                        advertisementData: [String : Any],
                        rssi RSSI: NSNumber) {
        print(peripheral)
        
        let d = self.devicesPeripheral.filter{ $0.deviceBluetooth.identifier == peripheral.identifier }
        if  d.count == 0 && peripheral.name != nil {
            DispatchQueue.main.async {[weak self] in
                guard let customSelf = self else { return }
                customSelf.devicesPeripheral.append(DeviceRecord(deviceBluetooth: peripheral))
                customSelf.stopLoadDevicesAreaIndicator()
                customSelf.tableViewDeviceArea.reloadData()
            }
        }

    }
    func startScan(){
        DispatchQueue.main.async { [weak self] in
            guard let customSelf = self else { return }
            let operations =  customSelf.pendingOperations.connectionInProgress
            for op in operations{
                op.value.cancel()
            }
            if customSelf.pendingOperations.connectionInProgress.count > 0 {
                customSelf.pendingOperations.connectionInProgress.removeAll()
            }
            if customSelf.devicesPeripheral.count > 0{
                customSelf.devicesPeripheral.removeAll()
                customSelf.tableViewDeviceArea.reloadData()
            }
            customSelf.startLoadDevicesAreaIndicator()
            customSelf.btnReload.isHidden = true
        }
        
        self.centralManager.scanForPeripherals(withServices: nil)

        DispatchQueue.main.asyncAfter(deadline: .now() + 10.0, execute: {[weak self] in
            guard let customSelf = self else { return }
            customSelf.stopScan()
        })
    }
    
    func stopScan(){
        self.centralManager.stopScan()
        DispatchQueue.main.async { [weak self] in
            guard let customSelf = self else { return }
            let operations =  customSelf.pendingOperations.connectionInProgress
            for op in operations{
                if customSelf.devicesPeripheral[op.key.row].deviceBluetooth.state == .connecting{
                    op.value.cancel()
                }
            }
            customSelf.tableViewDeviceArea.reloadData()
            customSelf.stopLoadDevicesAreaIndicator()
            customSelf.btnReload.isHidden = false
        }
    }
    
    func connect(device: CBPeripheral){
        centralManager.connect(device)
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("Connected!")
        let deviceRecord = self.devicesPeripheral.filter{$0.deviceBluetooth === peripheral}.first
        if deviceRecord != nil{
            deviceRecord!.state = .connected
        }
        self.tableViewDeviceArea.reloadData()
        
//        peripheral.discoverServices(nil)
//        peripheral.discoverServices([BluetoothServiceConstants.batteryService])
    }

}


extension DeviceVC:UITableViewDataSource, UITableViewDelegate, deviceSaveProtocol{
    
    func startOperations(for device: DeviceRecord, at indexPath: IndexPath) {
        
        switch (device.state) {
        case .new:
            if device.deviceBluetooth.state == .disconnected{
                print("startConnection")
                startConnection(for: device.deviceBluetooth, at: indexPath)
            }
        case .connected:
            print("startGetInformationDevice")
            startGetInformationDevice(for: device, at: indexPath)
        default:
            NSLog("do nothing")
        }
    }
    
    func startConnection(for device: CBPeripheral, at indexPath: IndexPath) {
        guard pendingOperations.connectionInProgress[indexPath] == nil else{ return }
        let connector = DeviceBluetoothConnector(device, self.centralManager)
        connector.completionBlock = {
            if connector.isCancelled { return}
            DispatchQueue.main.async {[weak self] in
                guard let customSelf = self else { return }
                customSelf.pendingOperations.connectionInProgress.removeValue(forKey: indexPath)
                customSelf.tableViewDeviceArea.reloadRows(at: [indexPath], with: .fade)
            }
        }
        pendingOperations.connectionInProgress[indexPath] = connector
        pendingOperations.connectingQueue.addOperation(connector)
    }
    
    func startGetInformationDevice(for device: DeviceRecord, at indexPath: IndexPath) {
        guard pendingOperations.getInformationInProgress[indexPath] == nil else{ return}
        let getter = InfoDeviceGetter(device, self.centralManager)
        getter.completionBlock = {
            if getter.isCancelled {return}
            DispatchQueue.main.async {[weak self] in
                guard let customSelf = self else { return }
                customSelf.pendingOperations.getInformationInProgress.removeValue(forKey: indexPath)
                customSelf.tableViewDeviceArea.reloadRows(at: [indexPath], with: .fade)
            }
        }
        pendingOperations.getInformationInProgress[indexPath] = getter
        pendingOperations.gettingInfoQueue.addOperation(getter)
    }
    
    func actionCell(index: IndexPath?) {
        if index != nil{
            let device = self.devicesPeripheral[index!.row]
            
            print("saving device \(device.deviceBluetooth.name ?? "No name")")
            
//            startConnection(for: device, at: index!)
            guard let dev = device.deviceWS else { return }
            GrinWebServicios.sharedInstance.addDevices(
                name: dev.name ?? "",
                address: dev.address ?? "",
                strength: dev.strength ?? "",
                verHud: true,
                viewController: self,
                Success: { [weak self] data in
                    guard let customSelf = self else { return }
                    print(data)
                    customSelf.successAddDevices(device:device, index: index!)
            },
                Error: {})
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.tableViewDeviceArea {
            return self.devicesPeripheral.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = Bundle.main.loadNibNamed("DeviceDetectedTVC", owner: self, options: nil)?.first as! DeviceDetectedTVC
        
        if cell.accessoryView == nil {
            let indicator = UIActivityIndicatorView(style: .gray)
            cell.accessoryView = indicator
        }
        let indicator = cell.accessoryView as! UIActivityIndicatorView
        
        let device = devicesPeripheral[indexPath.row]
        cell.title.text = device.deviceBluetooth.name ?? "No name"
        
        cell.subtitle2.text = device.deviceBluetooth.identifier.uuidString
        cell.bind(delegate: self, index: indexPath)
        cell.selectionStyle = .none

        switch (device.state) {
        case .new:
            cell.subtitle1.text = device.deviceBluetooth.state.description()
            indicator.startAnimating()
            print("startAnimating \(device.deviceBluetooth.name ?? "" )")
        case .infoGetted:
            cell.imageLeft!.tintColor = UIColor.blue
            cell.viewButton.isHidden = false
            indicator.stopAnimating()
            cell.subtitle1.text = "Ready to save"
        case .connected:
            
            cell.subtitle1.text = device.deviceBluetooth.state.description()
            indicator.startAnimating()
            print("stopAnimating \(device.deviceBluetooth.name ?? "" )")
        case .gettingInfo:
            
            cell.subtitle1.text = "Getting Information"
            indicator.startAnimating()
            break
        case .saved:
            cell.imageLeft!.tintColor = UIColor.green
            cell.viewButton.isHidden = true
            cell.imgActionBtn.image = UIImage(named: "baseline_check_circle_outline_black_48pt")
            indicator.stopAnimating()
            cell.subtitle1.text = "Saved"
            break
        }

        startOperations(for: device, at: indexPath)

        return cell

    }

    
    
}



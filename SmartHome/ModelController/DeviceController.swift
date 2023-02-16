//
//  DeviceController.swift
//  SmartHome
//
//  Created by Colton Brenneman on 2/15/23.
//

import Foundation

class DeviceController {
    
    //MARK: - Properties
    static let sharedInstance = DeviceController()
    var devices: [Device] = []
    
    init() {
        load()
    }
    //MARK: - CRUD Functions
    func create(name: String){
        let device = Device(name: name)
        devices.append(device)
        save()
    }
    func toggleButtonSwitched(whatDevice: Device){
        whatDevice.isOn.toggle()
        save()
    }
    private var fileURL: URL?{
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return nil}
        let finalURL = documentsDirectory.appendingPathComponent("devices.json")
        return finalURL
    }
    
    func save() {
        //1.Get the address to save the file to
        guard let url = fileURL else {return}
        //2. Convert the Swift struct or calss into JSON Data
        do {
            let jsonData = try JSONEncoder().encode(devices)
            //3. Save (write) the data to the address from step 1.
            try jsonData.write(to: url)
        }catch let error {
            print(error.localizedDescription)
        }
    }
    
    func load() {
        //1. Get the address the data is saved at
        guard let url = fileURL else {return}
        //2. Load that JSON data from the address
        do{
            let retrievedJSONData = try Data(contentsOf: url)
            //3. Convert from JSON to our Swift Model Object Type
            let devices = try JSONDecoder().decode([Device].self, from: retrievedJSONData)
            self.devices = devices
        } catch let error{
            print(error.localizedDescription)
        }
    }
}

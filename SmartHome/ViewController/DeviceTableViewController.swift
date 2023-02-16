//
//  DeviceTableViewController.swift
//  SmartHome
//
//  Created by Colton Brenneman on 2/15/23.
//

import UIKit

class DeviceTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Actions
    
    @IBAction func addDeviceButton(_ sender: Any) {
        presentNewDeviceAlertController()
    }
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return DeviceController.sharedInstance.devices.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let cell = tableView.dequeueReusableCell(withIdentifier: "deviceCell", for: indexPath) as? DeviceTableViewCell else {return UITableViewCell()}
        
        let device = DeviceController.sharedInstance.devices[indexPath.row]
        cell.updateViews(device: device)
    
        cell.delegate = self
        
        return cell
    }
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     
     }*/
    
    private func presentNewDeviceAlertController(){
        let alertController = UIAlertController(title: "New Device", message: "Enter the name fo your device below", preferredStyle: .alert)
        alertController.addTextField {textField in textField.placeholder = "New Device Name"}
        let dismissAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(dismissAction)
        let confirmAction = UIAlertAction(title: "Create", style: .default)
        { _ in guard let contentTextField = alertController.textFields?.first,
                  let name = contentTextField.text else {return}
            DeviceController.sharedInstance.create(name: name)
            self.tableView.reloadData()
        }
        alertController.addAction(confirmAction)
        present(alertController, animated: true)
        
    }
}


//MARK: - Extensions
extension DeviceTableViewController: DeviceTableViewCellDelegate {
    func isOnSwitchToggled(cell: DeviceTableViewCell) {
        guard let index = tableView.indexPath(for: cell) else {return}
        let device = DeviceController.sharedInstance.devices[index.row]
        DeviceController.sharedInstance.toggleButtonSwitched(whatDevice: device)
        cell.updateViews(device: device)
    }
}

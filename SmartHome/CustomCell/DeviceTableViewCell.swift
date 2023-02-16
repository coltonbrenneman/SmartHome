//
//  DeviceTableViewCell.swift
//  SmartHome
//
//  Created by Colton Brenneman on 2/15/23.
//

import UIKit

protocol DeviceTableViewCellDelegate: AnyObject {
    func isOnSwitchToggled(cell: DeviceTableViewCell)
}

class DeviceTableViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    //MARK: - Properties
    
    weak var delegate: DeviceTableViewCellDelegate?
    
    //MARK: - Outlets
    
    @IBOutlet weak var deviceNameLabel: UILabel!
    
    @IBOutlet weak var deviceToggleSwitch: UISwitch!
    
//MARK: - Helper Functions
    func updateViews(device: Device){
        deviceNameLabel.text = device.name
        deviceToggleSwitch.isOn = device.isOn
    }
    
//MARK: - Actions
    
    
    @IBAction func deviceToggled(_ sender: Any) {
        delegate?.isOnSwitchToggled(cell: self)
    }
}

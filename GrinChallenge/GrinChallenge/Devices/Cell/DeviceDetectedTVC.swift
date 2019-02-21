//
//  DeviceDetectedTVC.swift
//  GrinChallenge
//
//  Created by Stephane Gardon on 2/20/19.
//  Copyright © 2019 Stephane Gardon. All rights reserved.
//

import UIKit

protocol deviceSaveProtocol : class {
    func actionCell(index : IndexPath?)
}

class DeviceDetectedTVC: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subtitle1: UILabel!
    @IBOutlet weak var subtitle2: UILabel!
    @IBOutlet weak var imgViewLeft: UIView!
    @IBOutlet weak var imageLeft: UIImageView!
    @IBOutlet weak var viewButton: UIView!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var imgActionBtn: UIImageView!
    weak var delegate : deviceSaveProtocol?
    var index : IndexPath?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bind(delegate: deviceSaveProtocol, index: IndexPath) {
        self.delegate = delegate
        self.index = index
    }
    
    @IBAction func saveBtnAction(_ sender: Any) {
        self.delegate?.actionCell(index: index)
    }
    
}

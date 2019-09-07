//
//  SelfieViewController.swift
//  SwiftAdv
//
//  Created by Oxana Lobysheva on 31/08/2019.
//  Copyright © 2019 Oxana Lobysheva. All rights reserved.
//

import UIKit

class SelfieViewController: UIViewController {

    @IBOutlet weak var selfieImage: UIImageView!
    let fm = AvatarManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UIImage(contentsOfFile: fm.getAvatarPath()) != nil {
            selfieImage.image = UIImage(contentsOfFile: fm.getAvatarPath())
        } else {
            selfieImage.image = UIImage(named: Defaults.selfie.rawValue)
        }
    }

}

//
//  PhotoViewController.swift
//  Images viewer
//
//  Created by Vladimir on 29/08/2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {

    
    var photoViewModel: PhotoViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}


extension PhotoViewController {
    func configure(withConfiguration configuration: PhotoConfiguration) {
        photoViewModel = PhotoViewModel(configuration.photo)
    }
}

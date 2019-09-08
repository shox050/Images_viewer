//
//  PhotoViewController.swift
//  Images viewer
//
//  Created by Vladimir on 29/08/2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController, PhotoController {
    
    @IBOutlet private weak var ivPhoto: UIImageView!
    @IBOutlet private weak var lDownloadTime: UILabel!
    
    private var photoViewModel: PhotoViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
    }
}


extension PhotoViewController {
    func configure(withConfiguration configuration: PhotoConfiguration) {
        photoViewModel = PhotoViewModel(configuration.photo, image: configuration.image)
    }
    
    private func setUp() {
        guard photoViewModel != nil else {
            print("photoViewModel: PhotoViewModel! is nil")
            return
        }
        
        ivPhoto?.image = photoViewModel.image
        lDownloadTime?.text = photoViewModel.downloadDate
    }
}

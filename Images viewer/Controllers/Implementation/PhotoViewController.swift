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
        
        if let image = ImageCache.cache.object(forKey: NSString(string: photoViewModel.id)) {
            ivPhoto.image = image
        }
        
        lDownloadTime.text = photoViewModel.downloadDate
    }
}


extension PhotoViewController {
    func configure(withConfiguration configuration: PhotoConfiguration) {
        photoViewModel = PhotoViewModel(configuration.photo)
    }
}

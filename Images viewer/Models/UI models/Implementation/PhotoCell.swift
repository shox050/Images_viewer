//
//  PhotoCollectionViewCell.swift
//  Images viewer
//
//  Created by Vladimir on 29/08/2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell, Configurable {
    
    @IBOutlet private weak var ivPhoto: UIImageView!
    @IBOutlet private weak var lPhotoId: UILabel!
    @IBOutlet private weak var lDataCreated: UILabel!
    @IBOutlet private weak var lDataUpdated: UILabel!
    @IBOutlet private weak var lDescription: UILabel!
    
    
    func configure(byPhoto photo: Photo) {
        lDescription.sizeToFit()
        
        if let text = lDescription.text, text.isEmpty {
            lDescription.isHidden = true
        }
        
        ivPhoto.image = photo.image
        lPhotoId.text = "Photo id: \(photo.id)"
        lDataCreated.text = "Created: \(photo.created)"
        lDataUpdated.text = "Updated: \(photo.updated)"
        lDescription.text = createDescription(byPhoto: photo)
    }
    
    private func createDescription(byPhoto photo: Photo) -> String {
        
        var description = "Description:"
        
        if let photoDescription = photo.photoDescription {
            description += " \(photoDescription)"
        }
        
        if let alternativeDescription = photo.alternativeDescription {
            description += " \(alternativeDescription)"
        }
        
        return description
    }
}

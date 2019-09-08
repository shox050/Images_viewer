//
//  PhotoCollectionViewCell.swift
//  Images viewer
//
//  Created by Vladimir on 29/08/2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import UIKit

class PhotoCell: UITableViewCell, PhotoCellConfigurable {
        
    @IBOutlet private weak var ivPhoto: UIImageView!
    @IBOutlet private weak var lPhotoId: UILabel!
    @IBOutlet private weak var lDateCreated: UILabel!
    @IBOutlet private weak var lDateUpdated: UILabel!
    @IBOutlet private weak var lDescription: UILabel!
    
    
    func configure(byPhoto photo: Photo,with image: UIImage?) {

        if let text = lDescription.text, text.isEmpty {
            lDescription.isHidden = true
        }

        var description: String {
            var str = ""
            if let description = photo.photoDescription {
                str += description
            }

            if let alternativeDescription = photo.alternativeDescription {
                str += alternativeDescription
            }
            return str
        }

        ivPhoto.image = image
        lPhotoId.text = "Photo id: \(photo.id)"
        lDateCreated.text = "Created: \(photo.created)"
        lDateUpdated.text = "Updated: \(photo.updated)"
        lDescription.text = "Description: \(description)"
    }
}

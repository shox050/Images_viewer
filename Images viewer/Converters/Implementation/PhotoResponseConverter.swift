//
//  PhotoResponseConverter.swift
//  Images viewer
//
//  Created by Vladimir on 29/08/2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import UIKit

class PhotoResponseConverter: PhotoResponseConvertable {
    
    func convert(_ photoResponse: [PhotoResponse]) -> [Photo] {
        
        let photos = photoResponse.compactMap { photoResponse -> Photo in
            
            let id = photoResponse.id
            let created = photoResponse.created
            let updated = photoResponse.updated
            let photoDescription = photoResponse.photoDescription
            let alternativeDescription = photoResponse.alternativeDescription
            let photoUrl = photoResponse.photoUrl.regular
            var photo: UIImage?
            
            return Photo(id: id, created: created, updated: updated,
                         photoDescription: photoDescription,
                         alternativeDescription: alternativeDescription,
                         photoUrl: photoUrl, image: photo)
        }
        
        return photos
    }
}

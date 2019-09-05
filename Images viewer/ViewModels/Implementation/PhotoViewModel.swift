//
//  PhotoViewModel.swift
//  Images viewer
//
//  Created by Vladimir on 30/08/2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import UIKit

class PhotoViewModel: PhotoModel {
    private var photo: Photo
    
    var id: String {
        return photo.id
    }
//
//    var created: String {
//        return photo.created
//    }
//
//    var updated: String {
//        return photo.updated
//    }
//
//    var photoDescription: String {
//        return photo.photoDescription ?? ""
//    }
//
//    var alternativeDescription: String {
//        return photo.alternativeDescription ?? ""
//    }
//
//    var photoUrl: String {
//        return photo.photoUrl
//    }
    
    var downloadDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
        
        return "Download time: \(dateFormatter.string(from: photo.downloadDate))"
    }
    
    init(_ photo: Photo) {
        self.photo = photo
    }
}

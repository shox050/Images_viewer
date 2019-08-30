//
//  Photo.swift
//  Images viewer
//
//  Created by Vladimir on 29/08/2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import UIKit

struct Photo {
    let id: String
    let created: String
    let updated: String
    let photoDescription: String?
    let alternativeDescription: String?
    let photoUrl: String
    var image: UIImage?
}

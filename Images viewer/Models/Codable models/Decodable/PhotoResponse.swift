//
//  PhotoResponse.swift
//  Images viewer
//
//  Created by Vladimir on 29/08/2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import Foundation

struct PhotoResponse: Decodable {
    let id: String
    let created: String
    let updated: String
    let photoDescription: String?
    let alternativeDescription: String?
    let photoUrl: PhotoUrl
    
    private enum CodingKeys: String, CodingKey {
        case id
        case created = "created_at"
        case updated = "updated_at"
        case photoDescription = "description"
        case alternativeDescription = "alt_description"
        case photoUrl = "urls"
    }
}

struct PhotoUrl: Decodable {
    let regular: String
}

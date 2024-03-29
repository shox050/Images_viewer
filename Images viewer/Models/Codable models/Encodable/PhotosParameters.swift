//
//  PhotosParameters.swift
//  Images viewer
//
//  Created by Vladimir on 29/08/2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import Foundation

struct PhotosParameters: Encodable {
    let page: Int
    let itemsCount: Int
    let accessKey: String
    
    private enum CodingKeys: String, CodingKey {
        case page
        case itemsCount = "per_page"
        case accessKey = "client_id"
    }
}

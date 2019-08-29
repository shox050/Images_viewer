//
//  PhotoResponseConvertable.swift
//  Images viewer
//
//  Created by Vladimir on 29/08/2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import Foundation

protocol PhotoResponseConvertable {
    func convert(_ photoResponse: [PhotoResponse]) -> [Photo]
}

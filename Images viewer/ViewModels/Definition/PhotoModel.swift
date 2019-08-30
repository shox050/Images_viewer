//
//  PhotoModel.swift
//  Images viewer
//
//  Created by Vladimir on 30/08/2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import UIKit

protocol PhotoModel {
    var image: UIImage { get }
    var downloadDate: String { get }
}

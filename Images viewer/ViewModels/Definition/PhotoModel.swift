//
//  PhotoModel.swift
//  Images viewer
//
//  Created by Vladimir on 30/08/2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import UIKit

protocol PhotoModel {
//    var id: String { get }
    var image: UIImage { get set }
    var downloadDate: String { get }
}

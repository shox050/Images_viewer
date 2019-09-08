//
//  PhotoCellConfigurable.swift
//  Images viewer
//
//  Created by Vladimir on 29/08/2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import UIKit

protocol PhotoCellConfigurable {
//    func configure(byPhoto photo: Photo)
    
    func configure(byPhoto photo: Photo, with image: UIImage?)
}

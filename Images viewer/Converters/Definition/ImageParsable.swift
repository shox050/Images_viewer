//
//  ImageParsable.swift
//  Images viewer
//
//  Created by Vladimir on 29/08/2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import UIKit

protocol ImageParsable {
    func parse(fromData data: Data) -> UIImage?
}

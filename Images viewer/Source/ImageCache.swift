//
//  ImageCache.swift
//  Images viewer
//
//  Created by Vladimir on 05/09/2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import UIKit

final class ImageCache {
    static let cache = NSCache<NSString, UIImage>()
}

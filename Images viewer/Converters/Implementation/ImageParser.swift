//
//  ImageParser.swift
//  Images viewer
//
//  Created by Vladimir on 29/08/2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import UIKit

class ImageParser: ImageParsable {
    func parseImage(fromData data: Data) -> UIImage? {
        
        guard let image = UIImage(data: data) else {
            return nil
        }
        
        return image
    }
}

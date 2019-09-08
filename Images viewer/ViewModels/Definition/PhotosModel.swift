//
//  PhotosModel.swift
//  Images viewer
//
//  Created by Vladimir on 30/08/2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import UIKit

protocol PhotosModel {
    var selectedPhoto: Photo? { get set }
    var photos: [Photo] { get set }
    var newPhotos: [Photo] { get set }
    var numberPage: Int { get set }
    
    func downloadPhotos(_ completion: @escaping () -> Void)
    func downloadImage(_ completion: @escaping (Int) -> Void)
    func saveInCache(_ image: UIImage, byKey key: String)
    func getImageFromCache(byKey key: String) -> UIImage?
}

//
//  PhotosModel.swift
//  Images viewer
//
//  Created by Vladimir on 30/08/2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import Foundation

protocol PhotosModel {
    var photos: [Photo] { get set }
    var newPhotos: [Photo] { get set }
    var numberPage: Int { get set }
    
    func getPhotos(_ completion: @escaping () -> Void)
    func getImage(_ completion: @escaping (Int) -> Void)
    func preFetchingPhotos(byIndexPaths indexPaths: [IndexPath], _ completion: @escaping () -> Void)
    func photoDidEndDisplaying(byIndexPath indexPath: IndexPath)
}

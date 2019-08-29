//
//  PhotosViewModel.swift
//  Images viewer
//
//  Created by Vladimir on 29/08/2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import UIKit

class PhotosViewModel {
    var photos: [Photo] = []
    
    var numberPage = 1
    let perPage = Constants.ParametersRequest.photosPerPage
    
    let networkService: NetworkRequestable = NetworkService()
    let photoConverter: PhotoResponseConvertable = PhotoResponseConverter()
    
    
    func getPhotos() {
        networkService.getPhotos(forNumberPage: numberPage, perPage: perPage) { [weak self] response in
            
            guard let this = self else { return }
            switch response {
            case .success(let photosResponse):
                this.photos = this.photoConverter.convert(photosResponse)
            case .failure(let error):
                print("Error response ", error)
            }
        }
    }
    
}

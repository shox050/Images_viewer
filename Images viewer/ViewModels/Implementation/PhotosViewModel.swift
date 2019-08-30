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
    var newPhotos: [Photo] = []
    
    var numberPage = 1
    let perPage = Constants.ParametersRequest.photosPerPage
    
    private let networkService: NetworkRequestable = NetworkService()
    private let photoConverter: PhotoResponseConvertable = PhotoResponseConverter()
    private let imageParser: ImageParsable = ImageParser()
    private let photoQueue = DispatchQueue(label: Constants.Identifiers.photoQueue, qos: .background, attributes: .concurrent)
    
    
    func getPhotos(_ completion: @escaping () -> Void) {
        networkService.getPhotos(forNumberPage: numberPage, perPage: perPage) { [weak self] response in
            guard let this = self else { return }
            
            switch response {
            case .success(let photosResponse):
                let newPhotos = this.photoConverter.convert(photosResponse)
                this.photoQueue.async(flags: .barrier, execute: {
                    this.photos += newPhotos
                    this.numberPage += 1
                    this.newPhotos = newPhotos
                    completion()
                })
            case .failure(let error):
                print("Error response ", error)
            }
        }
    }
    
    // TODO: - Need refactoring.
    func getPhoto(_ completion: @escaping (Int) -> Void) {
        newPhotos.forEach { photo in
            // TODO: - rename downloadPhoto to downloadImage
            networkService.downloadPhoto(byPath: photo.photoUrl, { [weak self] response in
                guard let this = self else { return }
                
                switch response {
                case .success(let data):
                    guard let image = UIImage(data: data) else {
                        print("Parse image get nil")
                        return
                    }
                    

                    this.photoQueue.async(flags: .barrier, execute: {
                        guard let index = this.photos.firstIndex(where: {
                            $0.id == photo.id
                        }) else { return }
                        this.photos[index].photo = image
                        completion(index)
                    })
                    
                case .failure(let error):
                    print("Download photo get error ", error)
                }
            })
        }
        
//        networkService.downloadPhoto(byPath: path) { [weak self] response in
//            guard let this = self else { return }
//            switch response {
//            case .success(let data):
//                guard let image = this.imageParser.parseImage(fromData: data) else {
//                    print("Parse image get nil")
//                    return
//                }
//                completion(image)
//            case .failure(let error):
//                print("Download photo get error ", error)
//            }
//        }
    }
}

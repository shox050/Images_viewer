//
//  PhotosViewModel.swift
//  Images viewer
//
//  Created by Vladimir on 29/08/2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import UIKit

class PhotosViewModel: PhotosModel {
    
    var selectedPhoto: Photo?
    var photos: [Photo] = []
    var newPhotos: [Photo] = []
    var numberPage = 1
    
    private let perPage = Constants.ParametersRequest.photosPerPage
    private let offset = Constants.PrefetchingParameters.offset
    private let imageCache = NSCache<NSString, UIImage>()
    private let networkService: NetworkRequestable = NetworkService()
    private let photoConverter: PhotoResponseConvertable = PhotoResponseConverter()
    private let imageParser: ImageParsable = ImageParser()
    private let photoQueue = DispatchQueue(label: Constants.Identifiers.photoQueue,
                                           qos: .background,
                                           attributes: .concurrent)
    
    
    func downloadPhotos(_ completion: @escaping () -> Void) {
        photoQueue.async { [weak self] in
            guard let this = self else { return }
            
            this.networkService.getPhotos(forNumberPage: this.numberPage, perPage: this.perPage) { [weak self] response in
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
    }
    
    func downloadImage(_ completion: @escaping (Int) -> Void) {
        photoQueue.async { [weak self] in
            guard let this = self else { return }
            
            this.newPhotos.forEach { photo in
                this.networkService.downloadImage(byPath: photo.photoUrl, { response in
                    switch response {
                    case .success(let data):
                        guard let image = this.imageParser.parse(fromData: data) else {
                            print("Parse image get nil")
                            return
                        }
                        
                        this.saveInCache(image, byKey: photo.id)
                        
                        guard let index = this.photos.firstIndex(where: {
                            $0.id == photo.id
                        }) else { return }
                        
                        completion(index)
                        
                    case .failure(let error):
                        print("Download photo get error ", error)
                    }
                })
            }
        }
    }
    
    func saveInCache(_ image: UIImage, byKey key: String) {
        imageCache.setObject(image, forKey: NSString(string: key))
    }
    
    func getImageFromCache(byKey key: String) -> UIImage? {
        return imageCache.object(forKey: NSString(string: key))
    }
    
    
    func preFetchingPhotos(byIndexPaths indexPaths: [IndexPath], _ completion: @escaping () -> Void) {
        guard let index = indexPaths.first?.row else { return }
        if photos.count - index == offset {
            downloadPhotos { [weak self] in
                guard let this = self else { return }
                this.downloadImage({ _ in
                })
                completion()
            }
        }
    }
}

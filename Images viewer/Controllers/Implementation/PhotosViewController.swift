//
//  PhotosViewController.swift
//  Images viewer
//
//  Created by Vladimir on 29/08/2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {
    
    private let photosViewModel = PhotosViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        photosViewModel.networkService.getPhotos(forNumberPage: 1, perPage: 1) { response in
            print(response)
        }
    }
}

extension PhotosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosViewModel.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.Identifiers.collectionCell, for: indexPath) as? PhotoCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        
        return cell
    }
    
    
}


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
    
    @IBOutlet private weak var cvPhotos: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getPhotos()
    }
}

extension PhotosViewController {
    private func getPhotos() {
        DispatchQueue.global().async { [weak self] in
            
            guard let this = self else { return }
            
            this.photosViewModel.getPhotos {
                
                DispatchQueue.main.sync {
                    this.cvPhotos.reloadData()
                }
                
                this.photosViewModel.getPhoto { index in
                    
                    let indexPath = IndexPath(row: index, section: 0)
                    
                    DispatchQueue.main.async {
                        this.cvPhotos.performBatchUpdates({
                            this.cvPhotos.reloadItems(at: [indexPath])
                        }, completion: nil)
                    }
                }
            }
        }
    }
}

extension PhotosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosViewModel.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.Identifiers.collectionCell, for: indexPath) as? PhotoCell else {
            return UICollectionViewCell()
        }
        
        // TODO: - cell.configure
        cell.configure(byPhoto: photosViewModel.photos[indexPath.row])
        
        return cell
    }
}

extension PhotosViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        print("prefetchItemsAt indexPaths: \(indexPaths)")
        
        if photosViewModel.photos.count - indexPaths[0].row == 5 {
            getPhotos()
        }
    }
}


extension PhotoViewController: UICollectionViewDelegate {
    
}


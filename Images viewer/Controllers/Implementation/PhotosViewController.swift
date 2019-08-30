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
        
        photosViewModel.getPhotos { [weak self] _ in
            guard let this = self else { return }
            
            this.cvPhotos.reloadData()
            
            DispatchQueue.global().async {
                for (i, photo) in this.photosViewModel.photos.enumerated() {
                    
                    DispatchQueue.global().async {
                        this.photosViewModel.getPhoto(byPath: photo.photoUrl, { image in
                            
                            this.photosViewModel.photos[i].photo = image
                            
                            DispatchQueue.main.async {
                                this.cvPhotos.performBatchUpdates({
                                    let indexPath = IndexPath(row: i, section: 0)
                                    this.cvPhotos.reloadItems(at: [indexPath])
                                }, completion: nil)
                            }
                        })
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


extension PhotoViewController: UICollectionViewDelegate {
    
}


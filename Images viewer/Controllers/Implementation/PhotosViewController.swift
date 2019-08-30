//
//  PhotosViewController.swift
//  Images viewer
//
//  Created by Vladimir on 29/08/2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {
    
    private var selectPhoto: Photo?
    
    private let photosViewModel = PhotosViewModel()
    
    @IBOutlet private weak var cvPhotos: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photosViewModel.getPhotos { [weak self] in
            guard let this = self else { return }
            
            DispatchQueue.main.sync {
                this.cvPhotos.reloadData()
            }
            
            this.photosViewModel.getImage { index in
                let indexPath = IndexPath(row: index, section: Constants.ParametersCollectionView.numberOfSections)
                this.cvPhotos.reloadItems(at: [indexPath])
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVc = segue.destination as? PhotoViewController {
            
        }
    }
}


// MARK: - UICollectionViewDataSource
extension PhotosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosViewModel.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.Identifiers.collectionCell, for: indexPath) as? PhotoCell else {
            return UICollectionViewCell()
        }
        
        cell.configure(byPhoto: photosViewModel.photos[indexPath.row])
        
        return cell
    }
}

// MARK: - UICollectionViewDataSourcePrefetching
extension PhotosViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        print("prefetchItemsAt indexPaths: \(indexPaths)")
    
        photosViewModel.preFetchingPhotos(byIndexPaths: indexPaths) {
            collectionView.reloadData()
        }
    }
}


// MARK: - UICollectionViewDelegate
extension PhotosViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        photosViewModel.photoDidEndDisplaying(byIndexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        selectPhoto = photosViewModel.photos[indexPath.row]
        performSegue(withIdentifier: Constants.SegueIdentifiers.showPhotoVC, sender: self)
    }
}


//
//  PhotosTableViewController.swift
//  Images viewer
//
//  Created by Vladimir on 29/08/2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import UIKit

class PhotosTableViewController: UITableViewController, PhotosController {
    
    private let photosViewModel = PhotosViewModel()
    
    @IBOutlet var tvPhotos: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photosViewModel.downloadPhotos { [weak self] in
            guard let this = self else { return }
            
            DispatchQueue.main.async {
                print("this.cvPhotos.reloadData() getPhotos")
                this.tvPhotos.reloadData()
            }
            
            this.photosViewModel.downloadImage { index in
                let indexPath = IndexPath(row: index, section: Constants.ParametersCollectionView.numberOfSections)
                this.tvPhotos.reloadRows(at: [indexPath], with: .automatic)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let destinationVc = segue.destination as? PhotoController,
            let photo = photosViewModel.selectedPhoto,
            let image = photosViewModel.getImageFromCache(byKey: photo.id) else {
                
                print("prepare(for segue as PhotoController get error")
                return
        }
        
        destinationVc.configure(withConfiguration: PhotoConfiguration(photo: photo,
                                                                      image: image))
    }
}

// MARK: - UITableViewDataSource
extension PhotosTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photosViewModel.photos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifiers.photoCell) as? PhotoCell else {
            return UITableViewCell()
        }
        
        let photo = photosViewModel.photos[indexPath.row]
        let image = photosViewModel.getImageFromCache(byKey: photo.id)
        
        cell.configure(byPhoto: photo, with: image)
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension PhotosTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        photosViewModel.selectedPhoto = photosViewModel.photos[indexPath.row]
        performSegue(withIdentifier: Constants.SegueIdentifiers.showPhotoVC, sender: self)
    }
}

// MARK: - UITableViewDataSourcePrefetching
extension PhotosTableViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        photosViewModel.preFetchingPhotos(byIndexPaths: indexPaths) {
            print("this.cvPhotos.reloadData() preFetchingPhotos")
            
            DispatchQueue.main.sync {
                tableView.reloadData()
            }
        }
    }
}




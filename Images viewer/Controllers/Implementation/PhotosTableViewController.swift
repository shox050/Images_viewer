//
//  PhotosViewController.swift
//  Images viewer
//
//  Created by Vladimir on 29/08/2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import UIKit

class PhotosTableViewController: UITableViewController, PhotosController {
    
    private var selectedPhoto: Photo?
    
    private let photosViewModel = PhotosViewModel()
    
    @IBOutlet var tvPhotos: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photosViewModel.getPhotos { [weak self] in
            guard let this = self else { return }
            
            DispatchQueue.main.sync {
                print("this.cvPhotos.reloadData() getPhotos")
                this.tvPhotos.reloadData()
            }
            
            this.photosViewModel.getImage { index in
                let indexPath = IndexPath(row: index, section: Constants.ParametersCollectionView.numberOfSections)
                this.tvPhotos.reloadRows(at: [indexPath], with: .automatic)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVc = segue.destination as? PhotoViewController, let photo = selectedPhoto {
            destinationVc.configure(withConfiguration: PhotoConfiguration(photo: photo))
        }
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
        
        cell.configure(byPhoto: photosViewModel.photos[indexPath.row])
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension PhotosTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        selectedPhoto = photosViewModel.photos[indexPath.row]
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




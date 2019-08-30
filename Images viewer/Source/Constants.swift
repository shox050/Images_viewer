//
//  Constants.swift
//  Images viewer
//
//  Created by Vladimir on 29/08/2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import Foundation

struct Constants {
    struct Identifiers {
        static let networkQueue = "NetworkExecutionQueue"
        static let photoQueue = "PhotoExecutionQueue"
        static let collectionCell = "PhotoCell"
        static let noImage =  "noImage.png"
    }
    
    struct SegueIdentifiers {
        static let showPhotoVC = "ShowPhotoViewController"
    }
    
    struct ParametersRequest {
        static let photosPerPage = 20
        static let prefetchingOffset = 5
    }
    
    struct PrefetchingParameters {
        static let offset = 5
    }
    
    struct ParametersCollectionView {
        static let numberOfSections = 0
    }
}

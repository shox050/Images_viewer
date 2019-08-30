//
//  NetworkRequestable.swift
//  Images viewer
//
//  Created by Vladimir on 29/08/2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import Foundation

protocol NetworkRequestable {
    func getPhotos(forNumberPage page: Int, perPage count: Int, _ completion: @escaping (Result<[PhotoResponse], Error>) -> Void)
    
    func downloadImage(byPath path: String, _ completion: @escaping (Result<Data, Error>) -> Void)
}

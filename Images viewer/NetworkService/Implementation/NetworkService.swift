//
//  NetworkService.swift
//  Images viewer
//
//  Created by Vladimir on 29/08/2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import Foundation
import Alamofire

class NetworkService: NetworkRequestable {
    private let executionQueue = DispatchQueue(label: Constants.Identifiers.networkQueue, qos: .background, attributes: .concurrent)
    private let networkServiceConfiguration = NetworkServiceConfiguration()
    private let dictionaryEncoder = DictionaryEncoder()
    
    private func request(_ endpoint: Endpoint,
                         method: HTTPMethod = .get,
                         parameters: [String: Any]? = nil,
                         _ completion: @escaping (DataResponse<Data>) -> Void) {
        AF.request(endpoint,
                   method: method,
                   parameters: parameters)
            .validate()
            .responseData { response in
                completion(response)
        }
    }
    
    func getPhotos(forNumberPage page: Int, perPage count: Int, _ completion: @escaping (Result<[PhotoResponse], Error>) -> Void) {
        let parameters = PhotosParameters(page: page, itemsCount: count, accessKey: networkServiceConfiguration.accessKey)
        let parametersEncoded = dictionaryEncoder.encode(entity: parameters)
        
        request(.photos, parameters: parametersEncoded) { response in
            guard let responseData = response.data else {
                print("Response not have a data")
                return
            }
            let decoder = JSONDecoder()
            do {
                let photos = try decoder.decode([PhotoResponse].self, from: responseData)
                print("PhotoResponse parsing completed")
                completion(.success(photos))
            } catch let error {
                print("Decoding error: ", error)
                completion(.failure(error))
            }
        }
    }
    
    func downloadPhoto(byPath path: String, _ completion: @escaping (UIImage?) -> Void) {

        guard let url = URL(string: path) else { return }

        AF.request(url)
            .validate()
            .responseData { response in
                guard let dataResponse = response.data else {
                    completion(nil)
                    print("downloadPhoto not have a data")
                    return
                }

                guard let photo = UIImage(data: dataResponse) else {
                    print("Cant get UIImage from data")
                    completion(nil)
                    return
                }

                completion(photo)
        }
    }
    
//    func downloadPhoto(byPath path: String, _ completion: @escaping (Result<UIImage, Error>) -> Void) {
//
//        guard let url = URL(string: path) else { return }
//
//        AF.request(url)
//            .validate()
//            .responseData { response in
//                guard let dataResponse = response.data else {
//                    if let error = response.error {
//                        completion(.failure(error))
//                    }
//                    return
//                }
//
//                guard let photo = UIImage(data: dataResponse) else {
//                    return
//                }
//
//                completion(.success(photo))
//        }
//    }
}

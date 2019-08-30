//
//  Endpoint.swift
//  Images viewer
//
//  Created by Vladimir on 29/08/2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import Foundation
import Alamofire

enum Endpoint: URLRequestConvertible {
    static let basePath = "https://api.unsplash.com/"
    
    case photos
    
    var path: String {
        switch self {
        case .photos:
            return "photos"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let baseUrl = try Endpoint.basePath.asURL()
        let url = baseUrl.appendingPathComponent(path)
        
        return URLRequest(url: url)
    }
}


// MARK: - URLConvertible
extension Endpoint: URLConvertible {
    func asURL() throws -> URL {
        return try asURLRequest().url!
    }
}

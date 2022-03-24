//
//  NetworkManager.swift
//  VK News
///Users/valentinalucinovic/Desktop/Swift/VKNews
//  Created by Валентина Лучинович on 23.03.2022.
//

import Foundation

protocol Networking {
    func request(path: String, with params: [String : String], completion: @escaping (Data?, Error?) -> Void)
}

final class NetworkManager: Networking {
  
    private var authService: AuthService
    
    init(authService: AuthService = SceneDelegate.shared().authService) {
        self.authService = authService
    }
    
    func request(path: String, with params: [String : String], completion: @escaping (Data?, Error?) -> Void) {
        guard let token = authService.token else { return }
        
        var allParams = params
        allParams["access_token"] = token
        allParams["v"] = API.version
        let url = url(from: path, params: allParams)
        let request = URLRequest(url: url)
        createDataTask(from: request, completion: completion).resume()
        print(url)
    }
    
    private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
    }
    
    private func url(from path: String, params: [String : String]) -> URL {
        var components = URLComponents()
        
        components.scheme = API.scheme
        components.host = API.host
        components.path = path
        components.queryItems = params.map { URLQueryItem(name: $0, value: $1) }
        
        return components.url!
    }
}

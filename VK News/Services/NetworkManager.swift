//
//  NetworkManager.swift
//  VK News
///Users/valentinalucinovic/Desktop/Swift/VKNews
//  Created by Валентина Лучинович on 23.03.2022.
//

import Foundation

protocol Networking {
    func request(path: String, params: [String: String], complition: @escaping (Data?, Error?) -> ())
}

final class NetworkManager: Networking {
  
    private let authService: AuthService
    
    init(authService: AuthService = SceneDelegate.shared().authService) {
        self.authService = authService
    }
    
    func request(path: String, params: [String : String], complition: @escaping (Data?, Error?) -> ()) {
        guard let token = authService.token else { return }
        var allParams = params
        allParams["access_token"] = token
        allParams["v"] = API.version
        let url = self.url(from: path, params: allParams)
        let session = URLSession.init(configuration: .default)
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                complition(data,error)
            }
        }
        task.resume()
        print(url)
    }
    
    
    
    private func url(from path: String, params: [String:String]) -> URL {
        var components = URLComponents()
        
        components.scheme = API.scheme
        components.host = API.host
        components.path = API.newsfeed
        components.queryItems = params.map{ URLQueryItem(name: $0, value: $1)}
        
        return components.url!
    }
}

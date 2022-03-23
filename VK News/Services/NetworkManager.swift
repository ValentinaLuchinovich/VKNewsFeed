//
//  NetworkManager.swift
//  VK News
///Users/valentinalucinovic/Desktop/Swift/VKNews
//  Created by Валентина Лучинович on 23.03.2022.
//

import Foundation

final class NetworkManager {
    
    private let authService: AuthService
    
    init(authService: AuthService = SceneDelegate.shared().authService) {
        self.authService = authService
    }
    
    func getFeed() {
      
        // https://api.vk.com/method/users.get?user_ids=210700286&fields=bdate&access_token=533bacf01e11f55b536a565b57531ac114461ae8736d6506a3&v=5.131
        
        guard let token = authService.token else { return }
        let params = ["filters": "post, photo"]
        var allParams = params
        allParams["access_token"] = token
        allParams["v"] = API.version
        let url = self.url(from: API.newsfeed, params: allParams)
        
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

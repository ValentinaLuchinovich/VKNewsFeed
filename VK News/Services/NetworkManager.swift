//
//  NetworkManager.swift
//  VK News
///Users/valentinalucinovic/Desktop/Swift/VKNews
//  Created by Валентина Лучинович on 23.03.2022.
//

import Foundation

final class NetworkManager {
    
    func getFeed() {
        var components = URLComponents()
        
        // https://api.vk.com/method/users.get?user_ids=210700286&fields=bdate&access_token=533bacf01e11f55b536a565b57531ac114461ae8736d6506a3&v=5.131
        
        let params = ["filters": "post, photo"]
        let allParams = params
        allParams["access_token"]
        
        components.scheme = API.scheme
        components.host = API.host
        components.path = API.newsfeed
        components.queryItems
        
        components.url
    }
}

//
//  NetworkDataFetcher.swift
//  VK News
//
//  Created by Валентина Лучинович on 24.03.2022.
//

import Foundation

protocol DataFetcher {
    func getFeed(response: @escaping (FeedResponse?) -> ())
//    func getUser(response: @escaping (UserResponse?) -> Void)
//    func searchFeed(by query: String, nextBatchFrom: String?, response: @escaping (FeedResponse?) -> Void)
}

struct NetworkDataFetcher: DataFetcher {
    
    let networking: Networking
    
    init(networking: Networking) {
        self.networking = networking
    }
    
    func getFeed(response: @escaping (FeedResponse?) -> ()) {
        let params = ["filters": "post, photo"]
        networking.request(path: API.newsFeed, with: params) { data, error in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription) ")
                response(nil)
            }
            let decoded = self.decodeJSON(type: FeedRespounseWrapped.self, from: data)
            response(decoded?.response)
        }
    }
    private func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let data = from, let response = try? decoder.decode(type.self, from: data) else { return nil }
        return response
    }
    
}

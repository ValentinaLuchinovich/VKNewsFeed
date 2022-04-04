//
//  NetworkDataFetcher.swift
//  VK News
//
//  Created by Валентина Лучинович on 24.03.2022.
//

import Foundation

protocol DataFetcher {
    func getFeed(nextBatchFrom: String?, response: @escaping (FeedResponse?) -> ())
    func getUser(response: @escaping (UserRespounse?) -> Void)
//    func searchFeed(by query: String, nextBatchFrom: String?, response: @escaping (FeedResponse?) -> Void)
}

struct NetworkDataFetcher: DataFetcher {

    private var authService: AuthService
    let networking: Networking
    
    init(networking: Networking, authService: AuthService = SceneDelegate.shared().authService) {
        self.networking = networking
        self.authService = authService
    }
    
    func getUser(response: @escaping (UserRespounse?) -> Void) {
        guard let userId = authService.userId else { return }
        let params = ["fields": "photo_100", "user_ids": userId]
        networking.request(path: API.user, with: params) { data, error in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription) ")
                response(nil)
            }
            let decoded = self.decodeJSON(type: UserResponseWrapped.self, from: data)
            response(decoded?.response.first)
        }
    }
    
    func getFeed(nextBatchFrom: String?, response: @escaping (FeedResponse?) -> ()) {
        var params = ["filters": "post, photo"]
        params["start_from"] = nextBatchFrom
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

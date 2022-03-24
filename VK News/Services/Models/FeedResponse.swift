//
//  FeedResponse.swift
//  VK News
//
//  Created by Валентина Лучинович on 24.03.2022.
//

import Foundation

struct FeedRespounseWrapped: Decodable {
    let response: FeedResponse
}

struct FeedResponse: Decodable {
    var items: [FeedItem]
}

struct FeedItem: Decodable {
    // only feed
    var postId: Int?
    let sourceId: Int?
    
    // only search
    let id: Int?
    let ownerId: Int?
    
    // all
    var postUid: Int { return postId ?? id! }
    var sourceUid: Int { return sourceId ?? ownerId! }
    let text: String?
    let date: Double
    let comments: CountableItem?
    let likes: CountableItem?
    let reposts: CountableItem?
    let views: CountableItem?
}

struct CountableItem: Decodable {
    let count: Int
}

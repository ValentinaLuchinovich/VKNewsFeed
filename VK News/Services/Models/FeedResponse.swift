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
    var profiles: [Profile]
    var groups: [Group]
    var nextFrom: String?
}

struct FeedItem: Decodable {
    // only feed
    var postId: Int
    let sourceId: Int
    
    // only search
    let id: Int?
    let ownerId: Int?
    
    // all
//    var postUid: Int { return postId ?? id! }
//    var sourceUId: Int { return sourceId ?? ownerId! }
    let text: String?
    let date: Double
    let comments: CountableItem?
    let likes: CountableItem?
    let reposts: CountableItem?
    let views: CountableItem?
    let attachments: [Attachment]?
}

struct Attachment: Decodable {
    let photo: Photo?
}

struct Photo: Decodable {
    let sizes: [PhotoSize]
    
    var hight: Int {
        return getPropperSize().height
    }
    
    var wight: Int {
        return getPropperSize().width
    }
    
    var srcBig: String {
        return getPropperSize().url
    }
    
    // Поиск нужного размера изображения
    private func getPropperSize() -> PhotoSize {
        if let sizeX = sizes.first(where: { $0.type == "x"}) {
            return sizeX
        } else if let fallBackSize = sizes.last {
            return fallBackSize
        } else {
            return PhotoSize(type: "wrong image", url: "wrong image", width: 0, height: 0)
        }
    }
}

struct PhotoSize: Decodable {
    let type: String
    let url: String
    let width: Int
    let height: Int
}

struct CountableItem: Decodable {
    let count: Int
}

protocol ProfileRepresentable {
    var id: Int { get }
    var name: String { get }
    var photo: String { get }
}

struct Profile: Decodable, ProfileRepresentable {
    let id: Int
    let firstName: String
    let lastName: String
    let photo100: String
    
    var name: String { return firstName + " " + lastName}
    var photo: String { return photo100 }
    
}

struct Group: Decodable, ProfileRepresentable {
    let id: Int
    let name: String
    let photo100: String
    
    var photo: String { return photo100 }
}

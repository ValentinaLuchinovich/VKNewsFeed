//
//  NewsfeedModels.swift
//  VK News
//
//  Created by Валентина Лучинович on 24.03.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum Newsfeed {
    
    enum Model {
        struct Request {
            enum RequestType {
                case getNewsFeed
                case getUser
                case revealPostIds(postId: Int)
                case getNextBatch
            }
        }
        struct Response {
            enum ResponseType {
                case presentNewsFeed(feed: FeedResponse, revealPostIds: [Int])
                case presentUserInfo(user: UserRespounse?)
            }
        }
        struct ViewModel {
            enum ViewModelData {
                case displayNewsFeed(feedViewModel: FeedViewModel)
                case displayUser(userViewModel: UserViewModel)
            }
        }
    }
}

struct UserViewModel: TitleViewViewModel {
    var photoUrlString: String?
}

struct FeedViewModel {
    struct Cell: FeedCellViewModel {
        var postId: Int
        var iconUrlString: String
        var name: String
        var date: String
        var text: String?
        var likes: String?
        var comment: String?
        var shares: String?
        var views: String?
        var photoAttachments: [FeedCellphotoAttachmentViewModel]
        var sizes: FeedCellSizes
    }
    struct FeedCellPhotoAttachment: FeedCellphotoAttachmentViewModel {
        var photoUrlString: String?
        var wight: Int
        var height: Int
    }
    let cells: [Cell]
}

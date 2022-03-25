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
                
            }
        }
        struct Response {
            enum ResponseType {
                case presentNewsFeed(feed: FeedResponse)
            }
        }
        struct ViewModel {
            enum ViewModelData {
                case displayNewsFeed(feedViewModel: FeedViewModel)
            }
        }
    }
    
}

struct FeedViewModel {
    struct Cell: FeedCellViewModel {
        var iconUrlString: String
        var name: String
        var date: String
        var text: String?
        var likes: String?
        var comment: String?
        var shares: String?
        var views: String?
        var photoAttachment: FeedCellphotoAttachmentViewModel?
        var sizes: FeedCellSizes
    }
    struct FeedCellPhotoAttachment: FeedCellphotoAttachmentViewModel {
        var photoUrlString: String?
        var wight: Int
        var height: Int
    }
    let cells: [Cell]
}

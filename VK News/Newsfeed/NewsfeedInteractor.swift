//
//  NewsfeedInteractor.swift
//  VK News
//
//  Created by Валентина Лучинович on 24.03.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol NewsfeedBusinessLogic {
    func makeRequest(request: Newsfeed.Model.Request.RequestType)
}

class NewsfeedInteractor: NewsfeedBusinessLogic {
    
    var presenter: NewsfeedPresentationLogic?
    var service: NewsfeedService?
    
    private var revealedPostIds = [Int]()
    private var feedRespounse: FeedResponse?
    
    private var fetcher: DataFetcher = NetworkDataFetcher(networking: NetworkManager())
    
    func makeRequest(request: Newsfeed.Model.Request.RequestType) {
        if service == nil {
            service = NewsfeedService()
        }
        switch request {
        case .getNewsFeed:
            fetcher.getFeed { feedResponse in
                self.feedRespounse = feedResponse
                self.presentFeed()
            }
        case .revealPostIds(postId: let postId):
            revealedPostIds.append(postId)
            presentFeed()
            print("111")
        case .getUser:
            fetcher.getUser { userRespounse in
                self.presenter?.presentData(response: Newsfeed.Model.Response.ResponseType.presentUserInfo(user: userRespounse))
            }
        }
    }
    private func presentFeed() {
        guard let feedRespounse = self.feedRespounse else { return }
        presenter?.presentData(response: Newsfeed.Model.Response.ResponseType.presentNewsFeed(feed: feedRespounse, revealPostIds: revealedPostIds))
    }
}

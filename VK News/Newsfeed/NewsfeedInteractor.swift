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
    
    func makeRequest(request: Newsfeed.Model.Request.RequestType) {
        if service == nil {
            service = NewsfeedService()
        }
        switch request {
        case .getNewsFeed:
            service?.getFeed(completion: { [weak self] revealPostIds, feed in
                self?.presenter?.presentData(response: Newsfeed.Model.Response.ResponseType.presentNewsFeed(feed: feed, revealPostIds: revealPostIds))
            })
        case .getUser:
            service?.getUser(completion: { [weak self] user in
                self?.presenter?.presentData(response: Newsfeed.Model.Response.ResponseType.presentUserInfo(user: user))
            })
        case .revealPostIds(postId: let postId):
            service?.revealPostIds(forPostId: postId, completion: { [weak self] revealPostId, feed in
                self?.presenter?.presentData(response: Newsfeed.Model.Response.ResponseType.presentNewsFeed(feed: feed, revealPostIds: revealPostId))
            })
        case .getNextBatch:
            self.presenter?.presentData(response: .presentFooterLoader)
            service?.getNextBatch(completion: { revealPostId, feed in
                self.presenter?.presentData(response: .presentNewsFeed(feed: feed, revealPostIds: revealPostId))
            })
        }
    }
}

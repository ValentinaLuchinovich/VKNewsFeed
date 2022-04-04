//
//  NewsfeedWorker.swift
//  VK News
//
//  Created by Валентина Лучинович on 24.03.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class NewsfeedService {
    
    var authService: AuthService
    var networking: Networking
    var fetcher: DataFetcher
    
    private var revealedPostIds = [Int]()
    private var feedRespounse: FeedResponse?
    private var newFromInProcess: String?
    
    init() {
        self.authService = SceneDelegate.shared().authService
        self.networking = NetworkManager(authService: authService)
        self.fetcher = NetworkDataFetcher(networking: networking)
    }
    
    func getUser(completion: @escaping (UserRespounse?) -> ()) {
        fetcher.getUser { userRespounse in
            completion(userRespounse)
        }
    }
    
    func getFeed(completion: @escaping ([Int], FeedResponse) -> ()) {
        fetcher.getFeed(nextBatchFrom: nil) { [weak self] feed in
            self?.feedRespounse = feed
            guard let feedRespounse = self?.feedRespounse else { return }
            completion(self!.revealedPostIds, feedRespounse)
        }
    }
    
    func revealPostIds (forPostId postId: Int, completion: @escaping ([Int], FeedResponse) -> ()) {
        revealedPostIds.append(postId)
        guard let feedRespounse = self.feedRespounse else { return }
        completion(revealedPostIds, feedRespounse)
    }
    
    func getNextBatch(completion: @escaping([Int], FeedResponse) -> Void) {
        newFromInProcess = feedRespounse?.nextFrom
        fetcher.getFeed(nextBatchFrom: newFromInProcess) { [weak self] feed in
            guard let feed = feed else { return }
            guard self?.feedRespounse?.nextFrom != feed.nextFrom else { return }
            
            if self?.feedRespounse == nil {
                self?.feedRespounse = feed
            } else {
                self?.feedRespounse?.items.append(contentsOf: feed.items)
                
                var profiles = feed.profiles
                if let oldProfiles = self?.feedRespounse?.profiles {
                    let oldProfilesFiltered = oldProfiles.filter  { oldProfile in
                        !feed.profiles.contains(where: { $0.id == oldProfile.id })
                    }
                    profiles.append(contentsOf: oldProfilesFiltered)
                }
                self?.feedRespounse?.profiles = profiles
                
                var grups = feed.groups
                if let oldGroups = self?.feedRespounse?.groups  {
                    let oldGroupsFiltered = oldGroups.filter  { oldGroup in
                        !feed.groups.contains(where: { $0.id == oldGroup.id })
                    }
                    grups.append(contentsOf: oldGroupsFiltered)
                }
                self?.feedRespounse?.groups = grups
                
                self?.feedRespounse?.nextFrom = feed.nextFrom
            }
            guard let feedRespounse = self?.feedRespounse else { return }

            completion(self!.revealedPostIds, feedRespounse)
        }
    }
}

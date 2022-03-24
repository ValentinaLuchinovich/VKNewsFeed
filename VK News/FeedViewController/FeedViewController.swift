//
//  FeedViewController.swift
//  VK News
//
//  Created by Валентина Лучинович on 23.03.2022.
//

import UIKit

class FeedViewController: UIViewController {
    
    private var fetcher: DataFetcher = NetworkDataFetcher(networking: NetworkManager())

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = #colorLiteral(red: 0.3730105758, green: 0.6846097112, blue: 1, alpha: 1)
        fetcher.getFeed { (feedResponse) in
            guard let feedResponse = feedResponse else { return }
            feedResponse.items.map({ (feedItem) in
                print(feedItem.date)
            })
        }
    }
    
}

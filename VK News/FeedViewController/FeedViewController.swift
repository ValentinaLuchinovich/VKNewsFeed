//
//  FeedViewController.swift
//  VK News
//
//  Created by Валентина Лучинович on 23.03.2022.
//

import UIKit

class FeedViewController: UIViewController {
    
    private let networkManager = NetworkManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = #colorLiteral(red: 0.3730105758, green: 0.6846097112, blue: 1, alpha: 1)
        networkManager.getFeed()
    }
    
}

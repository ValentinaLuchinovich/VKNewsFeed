//
//  Constans.swift
//  VK News
//
//  Created by Валентина Лучинович on 29.03.2022.
//

import Foundation
import UIKit

struct Constants {
    static let cardInserts = UIEdgeInsets(top: 0, left: 8, bottom: 8, right: 12)
    static let topViewHight: CGFloat = 50
    static let postLabelInserts = UIEdgeInsets(top: 8 + Constants.topViewHight + 8, left: 8, bottom: 8, right: 8)
    static let postLabelFont = UIFont.systemFont(ofSize: 15)
    static let bottomViewHeight: CGFloat = 44
    
    static let bottoViewViewHeight: CGFloat = 44
    static let bottoViewViewWidth: CGFloat = 80
    static let bottomViewViewsIconSize: CGFloat = 24
    
    static let minifiedPostLimitLined: CGFloat = 8
    static let minifiedPostLines: CGFloat = 6
    
    static let moreTextButtonInserts = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
    static let moreTextButtonSize = CGSize(width: 170, height: 30)
}

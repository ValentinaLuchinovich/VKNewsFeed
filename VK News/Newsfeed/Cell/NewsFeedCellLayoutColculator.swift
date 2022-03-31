//
//  NewsFeedCellLayoutColculator.swift
//  VK News
//
//  Created by Валентина Лучинович on 25.03.2022.
//

import Foundation
import UIKit

protocol FeedCellLayoutColculaterProtocol {
    func sizes(postText: String?, photoAttachments: [FeedCellphotoAttachmentViewModel], isFullSizedPost: Bool) -> FeedCellSizes
}

struct Sizes: FeedCellSizes {
    var postLabelFrame: CGRect
    var moreTextButtonFrame: CGRect
    var attachmentFrame: CGRect
    var buttomViewFrame: CGRect
    var totalHight: CGFloat
}

final class FeedCellLayoutCalculator: FeedCellLayoutColculaterProtocol {

    private let screenWidth: CGFloat
    
    init(screenWidth: CGFloat = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)) {
        self.screenWidth = screenWidth
    }
  
    func sizes(postText: String?, photoAttachments: [FeedCellphotoAttachmentViewModel], isFullSizedPost: Bool) -> FeedCellSizes {
        
        var showMoreTextButton = false
        
        let cardViewWidth = screenWidth - Constants.cardInserts.left - Constants.cardInserts.right
        
        // MARK: -Работа с postLabelFrame
        
        var postLabelFrame = CGRect(origin: CGPoint(x: Constants.postLabelInserts.left, y: Constants.postLabelInserts.top),
                                    size: CGSize.zero)
        
        if let text = postText, !text.isEmpty {
            let width = cardViewWidth - Constants.postLabelInserts.left - Constants.postLabelInserts.right
            var height = text.height(width: width, font: Constants.postLabelFont)
            
            let limitHight = Constants.postLabelFont.lineHeight * Constants.minifiedPostLimitLined
            
            if !isFullSizedPost && height > limitHight {
                height = Constants.postLabelFont.lineHeight * Constants.minifiedPostLines
                showMoreTextButton = true
            }
            
            postLabelFrame.size = CGSize(width: width, height: height)
        }
        
        // MARK: -Работа с moreTextButtonFrame
        
        var moreTextButtonSize = CGSize.zero
        
        if showMoreTextButton {
            moreTextButtonSize = Constants.moreTextButtonSize
        }
        
        let moreTextButtonOrigin = CGPoint(x: Constants.moreTextButtonInserts.left, y: postLabelFrame.maxY + Constants.postLabelInserts.bottom)
        
        let moreTextButtonFrame = CGRect(origin: moreTextButtonOrigin, size: moreTextButtonSize)
        
        // MARK: -Работа с attachmentFrame
        let attachmentTop = postLabelFrame.size == CGSize.zero ? Constants.postLabelInserts.top : moreTextButtonFrame.maxY + Constants.postLabelInserts.bottom
        var attachmentFrame = CGRect(origin: CGPoint(x: 0, y: attachmentTop), size: CGSize.zero)
        
        if let attachment = photoAttachments.first {
            let photoHeight: Float = Float(attachment.height)
            let photoWight: Float = Float(attachment.wight)
            let ratio = CGFloat(photoHeight / photoWight)
            if photoAttachments.count == 1 {
                attachmentFrame.size = CGSize(width: cardViewWidth, height: cardViewWidth * ratio)
            } else if photoAttachments.count > 1 {
                print("Больше одного фото")
                attachmentFrame.size = CGSize(width: cardViewWidth, height: cardViewWidth * ratio)
            }
        }
        
        // MARK: -Работа с bottomViewFrame
        let bottomViewTop = max(postLabelFrame.maxY, attachmentFrame.maxY)
        
        let bottomViewFrame = CGRect(origin: CGPoint(x: 0, y: bottomViewTop),
                                     size: CGSize(width: cardViewWidth, height: Constants.bottomViewHeight))
        
        // MARK: -Работа с totalHight
        
        let totalHeight = bottomViewFrame.maxY + Constants.cardInserts.bottom
        
        return Sizes(postLabelFrame: postLabelFrame,
                     moreTextButtonFrame: moreTextButtonFrame,
                     attachmentFrame: attachmentFrame,
                     buttomViewFrame: bottomViewFrame,
                     totalHight: totalHeight)
    }
}

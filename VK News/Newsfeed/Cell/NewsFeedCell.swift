//
//  NewsFeedCell.swift
//  VK News
//
//  Created by Валентина Лучинович on 24.03.2022.
//

import Foundation
import UIKit

protocol FeedCellViewModel {
    var iconUrlString: String { get }
    var name: String { get }
    var date: String { get }
    var text: String? { get }
    var likes: String? { get }
    var comment: String? { get }
    var shares: String? { get }
    var views: String? { get }
    var photoAttachments: [FeedCellphotoAttachmentViewModel] { get }
    var sizes: FeedCellSizes { get }
}

protocol FeedCellSizes {
    var postLabelFrame: CGRect { get }
    var attachmentFrame: CGRect { get }
    var buttomViewFrame: CGRect { get }
    var totalHight: CGFloat { get }
    var moreTextButtonFrame: CGRect { get }
}

protocol FeedCellphotoAttachmentViewModel {
    var photoUrlString: String? { get }
    var wight: Int { get }
    var height: Int { get }
}


class NewsFeedCell: UITableViewCell {
    
    static let reuseID = "NewsFeedCell"
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var iconImageView: WebImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var postLabel: UILabel!
    @IBOutlet weak var postImageView: WebImageView!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var sharesLabel: UILabel!
    @IBOutlet weak var viewsLabel: UILabel!
    @IBOutlet weak var buttomView: UIView!
    
    override func prepareForReuse() {
        iconImageView.set(imageURL: nil)
        postImageView.set(imageURL: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Делаем иконку круглой
        iconImageView.layer.cornerRadius = iconImageView.frame.width / 2
        iconImageView.clipsToBounds = true
        
        // Закругляем края ячейки, куда помещены новости
        cardView.layer.cornerRadius = 10
        cardView.clipsToBounds = true
        
        backgroundColor = .clear
        selectionStyle = .none
    }
    
//    func set(viewModel: FeedCellViewModel) {
//        iconImageView.set(imageURL: viewModel.iconUrlString)
//        nameLabel.text = viewModel.name
//        dateLabel.text = viewModel.date
//        postLabel.text = viewModel.text
//        likesLabel.text = viewModel.likes
//        commentsLabel.text = viewModel.comment
//        sharesLabel.text = viewModel.shares
//        viewsLabel.text = viewModel.views
//        
//        postLabel.frame = viewModel.sizes.postLabelFrame
//        postImageView.frame = viewModel.sizes.attachmentFrame
//        buttomView.frame = viewModel.sizes.buttomViewFrame 
//        
//        if let photoAttachment = viewModel.photoAttachments {
//            postImageView.set(imageURL: photoAttachment.photoUrlString)
//            postImageView.isHidden = false
//        } else {
//            postImageView.isHidden = true
//        }
//    }
}

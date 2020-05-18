//
//  NewsTableViewCell.swift
//  NewsCap
//
//  Created by Chris on 13/05/2020.
//  Copyright © 2020 Chris78. All rights reserved.
//

import UIKit

class ListArticleTableViewCell: UITableViewCell {

    
    @IBOutlet weak var card: UIView!
    @IBOutlet weak var cardContent: UIView!
    @IBOutlet weak var imageArticle: UIImageView!
    @IBOutlet weak var titleText: UITextView!
    @IBOutlet weak var descriptionText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func setupUI() {
        
        selectionStyle = .none
        card.layer.cornerRadius = 20
        card.layer.shadowOpacity = 1
        card.layer.shadowOffset = CGSize(width: 2, height: 2)
        card.layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        cardContent.layer.cornerRadius = 20
        
        titleText.layer.shadowOpacity = 1.0
        titleText.layer.shadowOffset = CGSize(width: 0, height: 0)
        titleText.layer.shadowRadius = 10
        titleText.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)

    }
    
    func setupData(data: ListArticle.Fetch.ViewModel.DisplayArticle) {
        imageArticle.image = data.image
        titleText.text = data.title
        descriptionText.text = data.description
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

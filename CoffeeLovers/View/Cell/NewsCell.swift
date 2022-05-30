//
//  NewsCell.swift
//  CoffeeLovers
//
//  Created by Valeria Chub on 30.05.2022.
//  Copyright © 2022 Valeria. All rights reserved.
//

import UIKit

class NewsCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.layer.cornerRadius = 20.0
        contentView.layer.masksToBounds = true
    }

    func setup(with item: NewsItem) {
        titleLabel.text = item.title
        descriptionLabel.text = item.descripttion
        let date = getString(from: item.date)
        dateLabel.text = date
    }
    
    private func getString(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM, HH:mm"
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.string(from: date)
    }
}

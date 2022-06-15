//
//  EmojiTableViewCell.swift
//  EmojiDictionary
//
//  Created by 이형주 on 2022/06/11.
//

import UIKit

class EmojiTableViewCell: UITableViewCell {

    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func update(with emoji: Emoji){
        symbolLabel.text = emoji.symbol
        nameLabel.text = emoji.name
        descriptionLabel.text = emoji.description
    }
    
}


//
//  MainTableViewCell.swift
//  TestPlayo
//
//  Created by Sushmitha Bhat on 15/11/21.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    @IBOutlet var imageViewNews: UIImageView!
    @IBOutlet var authorLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    static let cellIdentifier = "MainTableViewCell"
    static let xibName = "MainTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}

//
//  NewsArticlesTableViewCell.swift
//  NewsArticleSampleApp
//
//  Created by Rakesh Medpalli on 01/07/22.
//

import UIKit

class NewsArticlesTableViewCell: UITableViewCell {
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var autherLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var abstractLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

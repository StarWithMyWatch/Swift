//
//  ListeMontreTableViewCell.swift
//  StarWithMyWatch
//
//  Created by Arthur BLANC on 16/10/2019.
//  Copyright © 2019 Vithursan Sivakumaran. All rights reserved.
//

import UIKit

class WatchListTableViewCell: UITableViewCell {

    
    @IBOutlet var watchImageView: UIImageView!
    @IBOutlet var watchPriceLabel: UILabel!
    @IBOutlet var watchNameLabel: UILabel!
    override func awakeFromNib() {
        
        watchImageView.layer.cornerRadius = watchImageView.frame.size.width / 2
        watchImageView.clipsToBounds = true
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

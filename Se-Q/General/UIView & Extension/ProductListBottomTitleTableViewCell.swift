//
//  ProductListBottomTitleTableViewCell.swift
//  Se-Q
//
//  Created by rahman fad on 07/05/20.
//  Copyright © 2020 rahman fad. All rights reserved.
//

import UIKit

class ProductListBottomTitleTableViewCell: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var titleImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

//
//  NewTableViewCell.swift
//  newsAPI
//
//  Created by Madala, Sarath Chandra on 11/20/18.
//  Copyright © 2018 Madala, Sarath Chandra. All rights reserved.
//

import UIKit

class NewTableViewCell: UITableViewCell {

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

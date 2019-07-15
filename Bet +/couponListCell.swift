//
//  couponListCell.swift
//  Bet +
//
//  Created by Murat on 13.12.2018.
//  Copyright © 2018 Murat. All rights reserved.
//

import UIKit

class couponListCell: UITableViewCell {

    @IBOutlet weak var couponTypeImage: UIImageView!
    @IBOutlet weak var couponTypeLabel: UILabel!
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var couponDateLabel: UILabel!
    @IBOutlet weak var totalOddsLabel: UILabel!
    @IBOutlet weak var systemLabel: UILabel!
    @IBOutlet weak var statusImage: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        
    }
    
 

}

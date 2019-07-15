//
//  couponDetailsCell.swift
//  Bet +
//
//  Created by Murat on 13.12.2018.
//  Copyright © 2018 Murat. All rights reserved.
//

import UIKit

class couponDetailsCell: UITableViewCell {

    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var matchNameLabel: UILabel!
    @IBOutlet weak var matchLeagueLabel: UILabel!
    @IBOutlet weak var matchDateLabel: UILabel!
    @IBOutlet weak var matchPredictLabel: UILabel!
    @IBOutlet weak var matchOddLabel: UILabel!
    @IBOutlet weak var matchStatusImage: UIImageView!
    @IBOutlet weak var matchStatusLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        cellView.layer.cornerRadius = 8
        cellView.layer.masksToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

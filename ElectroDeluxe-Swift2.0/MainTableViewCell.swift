//
//  MainTableViewCell.swift
//  ElectroDeluxe-Swift2.0
//
//  Created by c0d3r on 17/09/15.
//  Copyright © 2015 srmds. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    @IBOutlet weak var trackArtistLbl: UILabel!
    
    @IBOutlet weak var trackArtworkImgView: UIImageView!
    @IBOutlet weak var trackTitleLbl: UILabel!
    @IBOutlet weak var trackDurationLbl: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

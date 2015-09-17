//
//  SidebarTableViewCell.swift
//  ElectroDeluxe-Swift2.0
//
//  Created by c0d3r on 17/09/15.
//  Copyright © 2015 srmds. All rights reserved.
//

import UIKit

class SidebarTableViewCell: UITableViewCell {

    var sidebarMenuItemImageView: UIImageView!
    var sidebarMenuItemTitleLbl: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        //First Call Super
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //Initialize Text Field
        self.sidebarMenuItemImageView = UIImageView(frame: CGRectMake(15, 10, 10, 10))
        self.sidebarMenuItemImageView.contentMode = UIViewContentMode.ScaleAspectFit

        //Add TextField to SubView
        self.addSubview(self.sidebarMenuItemImageView)
        
        self.sidebarMenuItemTitleLbl = UILabel(frame: CGRectMake(35, 0, 100, 30))
        self.addSubview(self.sidebarMenuItemTitleLbl)
    }
 
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    

    
}

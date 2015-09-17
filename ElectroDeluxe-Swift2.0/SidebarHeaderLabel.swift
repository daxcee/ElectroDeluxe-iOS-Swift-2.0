//
//  SidebarHeaderLabel.swift
//  ElectroDeluxe-Swift2.0
//
//  Created by c0d3r on 17/09/15.
//  Copyright © 2015 srmds. All rights reserved.
//
import UIKit

class SidebarHeaderLabel: UILabel {
    
    override func drawTextInRect(rect: CGRect) {
        let insets: UIEdgeInsets = UIEdgeInsets(top: 0.0, left: 10.0, bottom: 0.0, right: 10.0)
        super.drawTextInRect(UIEdgeInsetsInsetRect(rect, insets))
    }
    
}

//
//  SideBarTableViewController.swift
//  SlideMenu
//
//  Created by c0d3r on 16/09/15.
//  Copyright © 2015 srmds. All rights reserved.
//

import UIKit

protocol SidebarTableViewControllerDelegate {
    func sidebarControlDidSelectRow(indexPath:NSIndexPath)
}

class SidebarTableViewController: UITableViewController {
    
    var delegate:SidebarTableViewControllerDelegate?
    var sections:Array<String> = []
    var tableData:Array<String> = []
    
    
    var sectionList:Array<String> = ["Overview","Playlists","Settings"]
    var playlists:Array<String> = ["Coding","Studying","Workout"]
    var overview:Array<String> = ["Streams","Favourites", "Discover"]
    var settings:Array<String> = ["Account", "Feedback"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return overview.count
        }
        
        if section == 1 {
            return playlists.count
        }
        
        if section == 2 {
            return settings.count
        }
        
        
        return tableData.count
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\(sectionList[section])"
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label : SidebarHeaderLabel = SidebarHeaderLabel()
         label.text = sectionList[section]
         label.textColor = RGBColorPicker.colorFromRGB(0x2DBDED)
     
        return label
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:SidebarTableViewCell? = tableView.dequeueReusableCellWithIdentifier("Cell") as? SidebarTableViewCell
        // var cell:UITableViewCell? = tableView.dequeueReusableCellWithIdentifier("Cell") as? UITableViewCell)
        
        if cell == nil {
            cell = SidebarTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
            
            // Configure the cell...
            cell!.backgroundColor = .clearColor()
            cell!.sidebarMenuItemTitleLbl.textColor = .whiteColor()
            
            
            let selectedView:UIView = UIView(frame: CGRect(x: 0, y: 0, width: cell!.frame.size.width, height: cell!.frame.size.height))
            selectedView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.2)
            
            cell!.selectedBackgroundView = selectedView
            
        }
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                print("stream item")
                cell!.sidebarMenuItemImageView.image = UIImage(named: "streamIcon.png")
            }
            
            if indexPath.row == 1 {
                cell!.sidebarMenuItemImageView.image = UIImage(named: "favouriteIcon.png")
            }

            if indexPath.row == 2 {
                cell!.sidebarMenuItemImageView.image = UIImage(named: "discoverIcon.png")
            }
            cell!.sidebarMenuItemTitleLbl.text = overview[indexPath.row]
        }
            
        else if indexPath.section == 1 {
            cell!.sidebarMenuItemImageView.image = UIImage(named: "menuItem.png")
            cell!.sidebarMenuItemTitleLbl.text = playlists[indexPath.row]
        }
        
        else if indexPath.section == 2{

            if indexPath.row == 0 {
                cell!.sidebarMenuItemImageView.image = UIImage(named: "accountIcon.png")
            }
            
            if indexPath.row == 1 {
                cell!.sidebarMenuItemImageView.image = UIImage(named: "feedbackIcon.png")
            }
            
            cell!.sidebarMenuItemTitleLbl.text = settings[indexPath.row]

        }
        
        return cell!
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 45.0
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        delegate?.sidebarControlDidSelectRow(indexPath)
    }
    
    
    
    
    
}

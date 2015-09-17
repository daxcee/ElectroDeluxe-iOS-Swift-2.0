//
//  MainViewController.swift
//  ElectroDeluxe-Swift2.0
//
//  Created by c0d3r on 16/09/15.
//  Copyright © 2015 srmds. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, SidebarDelegate {

    
    var user:User!
    var tracks:Array<String>!
    var sidebar:Sidebar = Sidebar()
    var mainTable:UITableView!
    
    @IBOutlet weak var mainTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tracks = ["Till The Sun Comes Up Mixtape ::: 3 Hours Shine by De Koperen Ploert","A mix to get you comfortable through the summer of 2015.","A mix to get you comfortable through the summer of 2015.", "A mix to get you comfortable through the summer of 2015.","A mix to get you comfortable through the summer of 2015.", "A mix to get you comfortable through the summer of 2015."]
    }
    
    override func viewWillAppear(animated: Bool) {
        self.setupMainView()
    }
    
    private func setupMainView(){
        mainTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        mainTableView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.6)
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "backgroundImg.png")?.drawInRect(self.view.bounds)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: image)
        
        let blurView:UIVisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.Light))
        blurView.frame = self.view.bounds
        
        mainTableView.insertSubview(blurView, atIndex: 0)
        sidebar = Sidebar(sourceView: self.view, menuItems: ["first item", "second item", "third item"])
        sidebar.delegate = self

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:MainTableViewCell = tableView.dequeueReusableCellWithIdentifier("mainCell", forIndexPath: indexPath) as! MainTableViewCell
        cell.backgroundColor = .clearColor()
        
        // Configure the cell...
        cell.trackTitleLbl.text = tracks[indexPath.row]

        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    }
    
    func sidebarDidSelectButtonAtIndex(index: Int) {
        print("clicked: \(index)")
    }
   
}
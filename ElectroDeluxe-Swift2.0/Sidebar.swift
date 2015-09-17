//
//  Sidebar.swift
//  ElectroDeluxe-Swift2.0
//
//  Created by c0d3r on 17/09/15.
//  Copyright © 2015 srmds. All rights reserved.
//

import UIKit

@objc protocol SidebarDelegate {
    func sidebarDidSelectButtonAtIndex(index:Int)
    optional func sidebarWillOpen()
    optional func sidebarWillClose()
}

class Sidebar: NSObject, SidebarTableViewControllerDelegate {
    
    private let barWidth:CGFloat = 250
    private let sidebarTableViewTopInset:CGFloat = 64.0
    private let sidebarContainerView:UIView = UIView()
    private let sidebarTableViewController:SidebarTableViewController = SidebarTableViewController()
    private var originView:UIView!
    private var animator:UIDynamicAnimator!
    private var isSidebarOpen:Bool = false
    private let xTranslationPathNamespace:String = "transform.translation.x"
    private let boundaryNamespace: String = "sidebarBoundary"
    
    var delegate:SidebarDelegate?
    
    private lazy var moveOriginViewOut: CABasicAnimation = {
        let animateOut = CABasicAnimation(keyPath: self.xTranslationPathNamespace)
        animateOut.delegate = self
        animateOut.duration = 0.3
        animateOut.repeatCount = 0
        animateOut.removedOnCompletion = false
        animateOut.fillMode = kCAFillModeForwards
        animateOut.autoreverses = false
        animateOut.fromValue = 0
        animateOut.toValue = self.barWidth

        return animateOut
    }()

    
    private lazy var moveOriginViewIn: CABasicAnimation = {
        let animateIn = CABasicAnimation(keyPath: self.xTranslationPathNamespace)
        animateIn.delegate = self
        animateIn.duration = 0.3
        animateIn.repeatCount = 0
        animateIn.removedOnCompletion = false
        animateIn.fillMode = kCAFillModeForwards
        animateIn.autoreverses = false
        animateIn.fromValue = self.barWidth

        animateIn.toValue = 0
        
        return animateIn
    }()

    override init() {
        super.init()
        
    }
    
    init(sourceView:UIView, menuItems:Array<String>) {
        super.init()
        originView = sourceView
        sidebarTableViewController.tableData = menuItems
        
        setupSidebar()
        
        animator = UIDynamicAnimator(referenceView: originView)

        let showGestureRecognizer:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "handleSwipe:")
        showGestureRecognizer.direction = .Right
        originView.addGestureRecognizer(showGestureRecognizer)
        
        let hideGestureRecognizer:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "handleSwipe:")
        hideGestureRecognizer.direction = .Left
        originView.addGestureRecognizer(hideGestureRecognizer)
    }
    
    private func setupSidebar(){
       
        sidebarContainerView.frame = CGRectMake(-barWidth-1, originView.frame.origin.y, barWidth-1, originView.frame.size.height)
        sidebarContainerView.backgroundColor = .clearColor()
        sidebarContainerView.clipsToBounds = false
        
        
        originView.addSubview(self.sidebarContainerView)
        
        let blurView:UIVisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.Dark))
        blurView.frame = sidebarContainerView.bounds
        sidebarContainerView.addSubview(blurView)
        
        sidebarTableViewController.delegate = self
        sidebarTableViewController.tableView.frame = self.sidebarContainerView.bounds
        sidebarTableViewController.tableView.clipsToBounds = false
        sidebarTableViewController.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        sidebarTableViewController.tableView.backgroundColor = .clearColor()
        
        sidebarTableViewController.tableView.scrollsToTop = false
        sidebarTableViewController.tableView.contentInset = UIEdgeInsetsMake(sidebarTableViewTopInset, 0, 0, 0)
        
        sidebarTableViewController.tableView.reloadData()
        
        sidebarContainerView.addSubview(sidebarTableViewController.tableView)
    }
    
    
    func handleSwipe(recognizer:UISwipeGestureRecognizer) {
        if recognizer.direction == .Left {
            showSidebar(false)
            delegate?.sidebarWillClose?()
        } else {
            showSidebar(true)
            delegate?.sidebarWillOpen?()
        }
    }
    
    private func showSidebar(shouldOpen:Bool) {
        animator.removeAllBehaviors()
        isSidebarOpen = shouldOpen
        
        let gravityX:CGFloat = (shouldOpen) ? 5.0 : -5.0
        let magnitude:CGFloat = (shouldOpen) ? 0.4 : 0.4
        let boundaryX:CGFloat = (shouldOpen) ? barWidth : -barWidth-2
        
        let gravityBehavior:UIGravityBehavior = UIGravityBehavior(items: [sidebarContainerView])
        gravityBehavior.gravityDirection = CGVectorMake(gravityX, 0)
        animator.addBehavior(gravityBehavior)
        
        let collisionBehavior: UICollisionBehavior = UICollisionBehavior(items: [sidebarContainerView])
        collisionBehavior.addBoundaryWithIdentifier(boundaryNamespace, fromPoint: CGPointMake(boundaryX, 10), toPoint: CGPointMake(boundaryX, originView.frame.size.height))
        animator.addBehavior(collisionBehavior)
        
        let pushBehavior:UIPushBehavior = UIPushBehavior(items: [sidebarContainerView], mode: .Instantaneous)
        pushBehavior.magnitude = magnitude
        animator.addBehavior(pushBehavior)
        
        let sidebarBehavior:UIDynamicItemBehavior = UIDynamicItemBehavior(items: [sidebarContainerView])
        sidebarBehavior.elasticity = 0.2
        animator.addBehavior(sidebarBehavior)
        
        let mainTable:UITableView = originView .viewWithTag(1) as! UITableView

        if shouldOpen {
            mainTable.userInteractionEnabled = false
        } else {
            mainTable.userInteractionEnabled = true
        }
        
        //moveOriginView(shouldOpen)
    }
    
    //Not used
    private func moveOriginView(shouldMove:Bool) {
        let mainTable:UITableView = originView .viewWithTag(1) as! UITableView

        if shouldMove {
            mainTable .layer .addAnimation(self.moveOriginViewOut, forKey: xTranslationPathNamespace)
        } else{
            mainTable .layer .addAnimation(self.moveOriginViewIn, forKey: xTranslationPathNamespace)
        }

    }
    
    func sidebarControlDidSelectRow(indexPath: NSIndexPath) {
        delegate?.sidebarDidSelectButtonAtIndex(indexPath.row)
    }
    
}
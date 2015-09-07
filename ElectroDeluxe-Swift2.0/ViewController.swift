//
//  ViewController.swift
//  ElectroDeluxe-Swift2.0
//
//  Created by c0d3r on 21/08/15.
//  Copyright © 2015 srmds. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        let replicator:RemoteReplicator = RemoteReplicator.sharedInstance
        replicator.pull(APIEndpoint.News)
        replicator.pull(APIEndpoint.Artists)
        replicator.pull(APIEndpoint.Events)
        //replicator.pull(APIEndpoint.Albums)
        //replicator.pull(APIEndpoint.Genres)
        //replicator.pull(APIEndpoint.Videos)
        //replicator.pull(APIEndpoint.Tracks)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


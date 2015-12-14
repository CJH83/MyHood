//
//  ViewController.swift
//  MyHood
//
//  Created by Chris Harrison on 11/12/2015.
//  Copyright © 2015 Chris Harrison. All rights reserved.
//

import UIKit



class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        DataService.instance.loadPosts()

       NSNotificationCenter.defaultCenter().addObserver(self, selector: "onPostsLoaded", name: "postsLoaded", object: nil)
    
                
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        tableView.reloadData()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataService.instance.loadedPosts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let post = DataService.instance.loadedPosts[indexPath.row]
        if let cell = tableView.dequeueReusableCellWithIdentifier("postCell") as? PostCell {
            cell.configureCell(post)
            
            return cell
        } else {
            let cell: PostCell = PostCell()
            cell.configureCell(post)
            return cell
        }
        
        
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 84.0
    }
    
    func onPostsLoaded(notif: AnyObject) {
        tableView.reloadData()
    }
    


}


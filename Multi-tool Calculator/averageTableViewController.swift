//
//  averageTableViewController.swift
//  Multi-tool Calculator
//
//  Created by Avram-Chaim Levy on 2015-12-29.
//  Copyright © 2015 Atrrition. All rights reserved.
//

import UIKit

class averageTableViewController: UITableViewController {
    
    var arrayFromSegue = NSMutableArray()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var Cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        
        Cell.textLabel?.text = String(arrayFromSegue[indexPath.row])
        return Cell
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayFromSegue.count
    }
}

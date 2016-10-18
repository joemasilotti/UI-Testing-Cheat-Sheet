//
//  ManageRosterTableViewController.swift
//  UI Testing Cheat Sheet
//
//  Created by Joe Masilotti on 9/10/15.
//  Copyright © 2015 Masilotti.com. All rights reserved.
//

import UIKit

class ManageRosterTableViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.editing = true

        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl)
        self.refreshControl = refreshControl
    }

    func refresh() {
        let alert = UIAlertController(title: "Roster Refreshed", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Cancel, handler: nil))
        presentViewController(alert, animated: true, completion: nil)

        refreshControl!.endRefreshing()
    }

    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    override func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.None
    }

    override func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) { }
}

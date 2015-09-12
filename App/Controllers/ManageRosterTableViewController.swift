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
    }

    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    override func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.None
    }

    override func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) { }
}

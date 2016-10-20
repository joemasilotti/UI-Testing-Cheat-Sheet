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

        tableView.isEditing = true

        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControlEvents.valueChanged)
        self.tableView.addSubview(refreshControl)
        self.refreshControl = refreshControl
    }

    func refresh() {
        let alert = UIAlertController(title: "Roster Refreshed", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.cancel, handler: nil))
        present(alert, animated: true, completion: nil)

        refreshControl!.endRefreshing()
    }

    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.none
    }

    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) { }
}

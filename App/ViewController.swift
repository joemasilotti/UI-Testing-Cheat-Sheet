//
//  ViewController.swift
//  UI Testing Cheat Sheet
//
//  Created by Joe Masilotti on 9/7/15.
//  Copyright © 2015 Masilotti.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var spikeLabel: UILabel!

    @IBAction func bumpSetButtonTepped(sender: UIButton) {
        spikeLabel.text = "Spike!"
    }

    @IBAction func endGameButtonTepped(sender: UIButton) {
        let alert = UIAlertController(title: "You won!",
            message: "Dig Newtons: 21\nSafety First: 18",
            preferredStyle: UIAlertControllerStyle.Alert)
        let dismissAction = UIAlertAction(title: "Awesome!",
            style: UIAlertActionStyle.Default,
            handler: nil)
        alert.addAction(dismissAction)

        self.presentViewController(alert, animated: true, completion: nil)
    }
}

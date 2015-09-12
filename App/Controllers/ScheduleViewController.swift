//
//  ScheduleViewController.swift
//  UI Testing Cheat Sheet
//
//  Created by Joe Masilotti on 9/12/15.
//  Copyright © 2015 Masilotti.com. All rights reserved.
//

import CoreLocation
import UIKit

class ScheduleViewController: UIViewController {
    let locationManager = CLLocationManager()

    @IBOutlet weak var nextGameLabel: UILabel!
    @IBOutlet weak var locationAuthorizationLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        updateLocationAuthorizationStatus()
    }

    @IBAction func finishGameButtonTapped(sender: UIButton) {
        let alert = UIAlertController(title: "You won!",
            message: "Final Score: 27 - 25",
            preferredStyle: UIAlertControllerStyle.Alert)

        let dismissAction = UIAlertAction(title: "Awesome!", style: UIAlertActionStyle.Default, handler: nil)
        alert.addAction(dismissAction)

        presentViewController(alert, animated: true, completion: nil)
    }

    @IBAction func loadMoreGamesButtonTapped(sender: UIButton) {
        sender.setTitle("Loading...", forState: UIControlState.Normal)

        sender.performSelector(Selector("setHidden:"), withObject: true, afterDelay: 2)
        nextGameLabel.performSelector(Selector("setText:"), withObject: "Game 4 - Tomorrow", afterDelay: 2)
    }

    @IBAction func locationButtonTapped(sender: UIButton) {
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
    }

    private func updateLocationAuthorizationStatus() {
        var authorizationStatus: String
        switch CLLocationManager.authorizationStatus() {
        case CLAuthorizationStatus.NotDetermined:
            authorizationStatus = "Not Determined"
        case CLAuthorizationStatus.Denied,
        CLAuthorizationStatus.Restricted:
            authorizationStatus = "Denied"
        default:
            authorizationStatus = "Authorized"
        }

        locationAuthorizationLabel.text = authorizationStatus
    }
}

extension ScheduleViewController: CLLocationManagerDelegate {
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        updateLocationAuthorizationStatus()
    }

    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print(error)
    }
}

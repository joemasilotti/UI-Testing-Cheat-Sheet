//
//  ViewController.swift
//  UI Testing Cheat Sheet
//
//  Created by Joe Masilotti on 9/7/15.
//  Copyright © 2015 Masilotti.com. All rights reserved.
//

import CoreLocation
import UIKit

class ViewController: UIViewController {
    let locationManager = CLLocationManager()

    @IBOutlet weak var spikeLabel: UILabel!
    @IBOutlet weak var locationAuthorizationLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateLocationAuthorizationStatus()
    }

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

extension ViewController: CLLocationManagerDelegate {
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        self.updateLocationAuthorizationStatus()
    }

    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print(error)
    }
}

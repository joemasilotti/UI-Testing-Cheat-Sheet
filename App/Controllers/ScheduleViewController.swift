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

    @IBAction func finishGameButtonTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "You won!", message: "Final Score: 27 - 25", preferredStyle: UIAlertController.Style.alert)

        let dismissAction = UIAlertAction(title: "Awesome!", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(dismissAction)

        present(alert, animated: true, completion: nil)
    }

    @IBAction func loadMoreGamesButtonTapped(_ sender: UIButton) {
        sender.setTitle("Loading...", for: UIControl.State.normal)

        sender.perform(#selector(setter: sender.isHidden), with: true, afterDelay: 2)
        nextGameLabel.perform(#selector(setter: nextGameLabel.text), with: "Game 4 - Tomorrow", afterDelay: 2)
    }

    @IBAction func locationButtonTapped(_ sender: UIButton) {
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
    }

    fileprivate func updateLocationAuthorizationStatus() {
        var authorizationStatus: String
        switch CLLocationManager.authorizationStatus() {
        case CLAuthorizationStatus.notDetermined:
            authorizationStatus = "Not Determined"
        case CLAuthorizationStatus.denied,
        CLAuthorizationStatus.restricted:
            authorizationStatus = "Denied"
        default:
            authorizationStatus = "Authorized"
        }

        locationAuthorizationLabel.text = authorizationStatus
    }
}

extension ScheduleViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        updateLocationAuthorizationStatus()
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

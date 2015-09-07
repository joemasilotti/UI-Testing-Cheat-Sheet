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
    let formations = [ "4-2 Formation", "5-1 Formation", "6-2 Formation" ]

    @IBOutlet weak var spikeLabel: UILabel!
    @IBOutlet weak var locationAuthorizationLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var sliderValueLabel: UILabel!
    @IBOutlet weak var formationsPicker: UIPickerView!
    @IBOutlet weak var selectedFormationLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.updateLocationAuthorizationStatus()
        self.updateSliderValue()
        self.updatePickerValue()
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

    @IBAction func sliderValueChanged(slider: UISlider) {
        updateSliderValue()
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

    private func updateSliderValue() {
        sliderValueLabel.text = String(format: "%.0f", slider.value)
    }

    private func updatePickerValue() {
        selectedFormationLabel.text = formations[formationsPicker.selectedRowInComponent(0)]
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

extension ViewController: UIPickerViewDataSource {
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return formations.count
    }
}

extension ViewController: UIPickerViewDelegate {
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return formations[row]
    }

    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        updatePickerValue()
    }
}

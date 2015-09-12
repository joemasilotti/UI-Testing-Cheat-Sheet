//
//  ManageTeamViewController.swift
//  UI Testing Cheat Sheet
//
//  Created by Joe Masilotti on 9/12/15.
//  Copyright © 2015 Masilotti.com. All rights reserved.
//

import UIKit

class ManageTeamViewController: UIViewController {
    let formations = [ "4-2 Formation", "5-1 Formation", "6-2 Formation" ]

    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var sliderValueLabel: UILabel!
    @IBOutlet weak var formationsPicker: UIPickerView!
    @IBOutlet weak var selectedFormationLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        updateSliderValue()
        updatePickerValue()
    }

    @IBAction func sliderValueChanged(slider: UISlider) {
        updateSliderValue()
    }

    private func updateSliderValue() {
        sliderValueLabel.text = String(format: "%.0f", slider.value)
    }

    private func updatePickerValue() {
        selectedFormationLabel.text = formations[formationsPicker.selectedRowInComponent(0)]
    }
}

extension ManageTeamViewController: UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}

extension ManageTeamViewController: UIPickerViewDataSource {
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return formations.count
    }
}

extension ManageTeamViewController: UIPickerViewDelegate {
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return formations[row]
    }

    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        updatePickerValue()
    }
}

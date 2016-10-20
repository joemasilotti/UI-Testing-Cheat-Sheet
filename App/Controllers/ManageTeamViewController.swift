//
//  ManageTeamViewController.swift
//  UI Testing Cheat Sheet
//
//  Created by Joe Masilotti on 9/12/15.
//  Copyright © 2015 Masilotti.com. All rights reserved.
//

import UIKit

class ManageTeamViewController: UIViewController {
    let attackers = [ "4 attackers", "5 attackers", "6 attackers" ]
    let setters = [ "2 setters", "1 setter" ]

    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var sliderValueLabel: UILabel!
    @IBOutlet weak var formationsPicker: UIPickerView!
    @IBOutlet weak var selectedFormationLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        updateSliderValue()
        updatePickerValue()
    }

    @IBAction func sliderValueChanged(_ slider: UISlider) {
        updateSliderValue()
    }

    private func updateSliderValue() {
        sliderValueLabel.text = String(format: "%.0f", slider.value)
    }

    fileprivate func updatePickerValue() {
        let attackersFormation = attackers[formationsPicker.selectedRow(inComponent: 0)]
        let settersFormation = setters[formationsPicker.selectedRow(inComponent: 1)]
        let formation = "\(attackersFormation), \(settersFormation)"
        selectedFormationLabel.text = formation
    }
}

extension ManageTeamViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}

extension ManageTeamViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return component == 0 ? attackers.count : setters.count
    }
}

extension ManageTeamViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return component == 0 ? attackers[row] : setters[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        updatePickerValue()
    }
}

extension ManageTeamViewController: UIPickerViewAccessibilityDelegate {
    func pickerView(_ pickerView: UIPickerView, accessibilityLabelForComponent component: Int) -> String? {
        return component == 0 ? "Attackers Formation" : "Setters Formation"
    }
}

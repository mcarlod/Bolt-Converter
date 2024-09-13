//
//  ViewController.swift
//  Bolt Converter
//
//  Created by Carlo Diesta on 9/11/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var unitSegmentedControl: UISegmentedControl!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var convertButton: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    
    let imperialSizes = ["1/64","1/32","3/64","1/16","5/64","3/32","7/64","1/8","9/64","5/32","11/64","3/16","13/64","7/32","15/64","1/4","17/64","9/32","19/64","5/16"]
    let metricSizes = ["M1","M2","M3","M4","M5","M6","M7","M8"]
    let imperialToMetric: [String: Double] = ["1/64": 0.40, "1/32": 0.79, "3/64": 1.19, "1/16": 1.59, "5/64": 1.98,"3/32": 2.38, "7/64": 2.78, "1/8": 3.18, "9/64": 3.57, "5/32": 3.97, "11/64": 4.37, "3/16": 4.76, "13/64": 5.16, "7/32": 5.56, "15/64": 5.95, "1/4": 6.35, "17/64": 6.75, "9/32": 7.14, "19/64": 7.54, "5/16": 7.94]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        unitSegmentedControl.selectedSegmentIndex = 0
        
        textField.keyboardType = .decimalPad
        textField.delegate = self
        
    }
    
    
    @IBAction func convertButtonPressed(_ sender: UIButton) {
        guard let inputText = textField.text, !inputText.isEmpty else {
            resultLabel.text = "Invalid Input"
            return
        }
        
        let selectedIndex = unitSegmentedControl.selectedSegmentIndex
        let selectedUnit = selectedIndex == 0 ? "Imperial (inch)" : "Metric (mm)"
        
        if selectedUnit == "Imperial (inch)" {
            if let metricValue = imperialToMetric[imperialSizes.first(where: { $0 == inputText }) ?? ""] {
                resultLabel.text = "\(inputText) inch = \(metricValue) mm"
            } else {
                resultLabel.text = "Size not found"
            }
        } else {
            if let value = Double(inputText) {
                let convertedValue = value / 2.54
                resultLabel.text = "\(inputText) mm = \(String(format: "%.2f", convertedValue)) inch"
            } else {
                resultLabel.text = "Invalid Input"
            }
        }
    }

    
}

extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = "0123456789./"
        let characterSet = CharacterSet(charactersIn: allowedCharacters)
        return string.rangeOfCharacter(from: characterSet.inverted) == nil
    }
}

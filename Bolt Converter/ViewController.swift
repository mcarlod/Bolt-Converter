//
//  ViewController.swift
//  Bolt Converter
//
//  Created by Carlo Diesta on 9/11/24.
//

import UIKit

class ViewController: UIViewController {
    
    // Outlets for UI components
    @IBOutlet weak var unitSegmentedControl: UISegmentedControl!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var convertButton: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    
    // Arrays to store available sizes in Imperial and Metric systems
    let imperialSizes = ["1/64","1/32","3/64","1/16","5/64","3/32","7/64","1/8","9/64","5/32","11/64","3/16","13/64","7/32","15/64","1/4","17/64","9/32","19/64","5/16"]
    let metricSizes = ["M1","M2","M3","M4","M5","M6","M7","M8"]
    
    // Dictionary to map Imperial sizes to their Metric value
    let imperialToMetric: [String: Double] = ["1/64": 0.40, "1/32": 0.79, "3/64": 1.19, "1/16": 1.59, "5/64": 1.98,"3/32": 2.38, "7/64": 2.78, "1/8": 3.18, "9/64": 3.57, "5/32": 3.97, "11/64": 4.37, "3/16": 4.76, "13/64": 5.16, "7/32": 5.56, "15/64": 5.95, "1/4": 6.35, "17/64": 6.75, "9/32": 7.14, "19/64": 7.54, "5/16": 7.94]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set default selected segment to the first (Imperial)
        unitSegmentedControl.selectedSegmentIndex = 0
        
        // Set the keyboard type of the text field to decimal pad for numeric input
        textField.keyboardType = .decimalPad
        
        // Set the text field's delegate to self to handle input validation
        textField.delegate = self
        
    }
    
    // Action triggered when the convert button is pressed
    @IBAction func convertButtonPressed(_ sender: UIButton) {
        // Ensure the text field is not empty
        guard let inputText = textField.text, !inputText.isEmpty else {
            resultLabel.text = "Invalid Input"
            return
        }
        
        // Determine which unit is selected from the segmented control
        let selectedIndex = unitSegmentedControl.selectedSegmentIndex
        let selectedUnit = selectedIndex == 0 ? "Imperial (inch)" : "Metric (mm)"
        
        // Perform conversion based on the selected unit
        if selectedUnit == "Imperial (inch)" {
            // Check if the input text matches an Imperial size
            if let metricValue = imperialToMetric[imperialSizes.first(where: { $0 == inputText }) ?? ""] {
                // If a match is found, display the converted value in mm
                resultLabel.text = "\(inputText) inch = \(metricValue) mm"
            } else {
                // Error message if size not found
                resultLabel.text = "Size not found"
            }
        } else {
            // For metric to imperial conversion; Attempt to convert the input text to a Double
            if let value = Double(inputText) {
                // Convert mm to inches using the conversion factor
                let convertedValue = value / 2.54
                
                // Display the converted value formatted to two decimal places
                resultLabel.text = "\(inputText) mm = \(String(format: "%.2f", convertedValue)) inch"
            } else {
                // Error message if input is invalid
                resultLabel.text = "Invalid Input"
            }
        }
    }

    
}

// Extension to handle UITextFieldDelegate methods
extension ViewController: UITextFieldDelegate {
    // Validate input to allow only certain characters to be typed
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = "0123456789./"
        let characterSet = CharacterSet(charactersIn: allowedCharacters)
        return string.rangeOfCharacter(from: characterSet.inverted) == nil
    }
}

//
//  ViewController.swift
//  ColorPicker
//
//  Created by Owen Pierce on 6/20/20.
//  Copyright © 2020 Curious Robot Labs. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var demoTextView: UITextView!
    
    var redValue: Int = 0 {
        didSet {
            redSlider.value = Float(redValue)
            redTextField.text = "\(redValue)"
            updateTextColors()
        }
    }
    
    var greenValue: Int = 0 {
        didSet {
            greenSlider.value = Float(greenValue)
            greenTextField.text = "\(greenValue)"
            updateTextColors()
        }
    }
    
    var blueValue: Int = 0 {
        didSet {
            blueSlider.value = Float(blueValue)
            blueTextField.text = "\(blueValue)"
            updateTextColors()
        }
    }
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var redTextField: UITextField!
    
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var greenTextField: UITextField!
    
    @IBOutlet var blueSlider: UISlider!
    @IBOutlet var blueTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let sliders: [UISlider] = [
            redSlider,
            greenSlider,
            blueSlider
        ]
        
        let textFields: [UITextField] = [
            redTextField,
            greenTextField,
            blueTextField
        ]
        
        sliders.forEach({
            $0.minimumValue = 0
            $0.maximumValue = 255
            $0.value = 0
        })
        
        textFields.forEach({
            $0.keyboardType = .numberPad
            $0.text = "0"
            $0.delegate = self
        })
    }
    
    func updateTextColors() {
        let newColor = UIColor(red: redValue,
                               green: greenValue,
                               blue: blueValue)
        demoTextView.textColor = newColor
    }
    
    @IBAction func sliderDidUpdate(sender: UISlider) {
        switch sender {
        case redSlider:
            redValue = Int(sender.value)
        case greenSlider:
            greenValue = Int(sender.value)
        case blueSlider:
            blueValue = Int(sender.value)
        default:
            fatalError("Unhandled case for slider update")
        }
    }
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        var newString = textField.text!
        let textRange = Range(range, in: newString)!
        newString =
            newString.replacingCharacters(in: textRange, with: string)
        if newString.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil {
            guard let convertedNumericValue = Int(newString) else {
                if textField == redTextField {
                    redValue = 0
                } else if textField == greenTextField {
                    greenValue = 0
                } else if textField == blueTextField {
                    blueValue = 0
                }
                return false
            }
            if convertedNumericValue < 0 {
                if textField == redTextField {
                    redValue = 0
                } else if textField == greenTextField {
                    greenValue = 0
                } else if textField == blueTextField {
                    blueValue = 0
                }
            } else if convertedNumericValue > 255 {
                if textField == redTextField {
                    redValue = 255
                } else if textField == greenTextField {
                    greenValue = 255
                } else if textField == blueTextField {
                    blueValue = 255
                }
            } else {
                if textField == redTextField {
                    redValue = convertedNumericValue
                } else if textField == greenTextField {
                    greenValue = convertedNumericValue
                } else if textField == blueTextField {
                    blueValue = convertedNumericValue
                }
            }
            return false
        } else {
            return false
        }
    }

}

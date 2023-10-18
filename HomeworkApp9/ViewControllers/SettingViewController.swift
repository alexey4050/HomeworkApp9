//
//  ViewController.swift
//  HomeworkApp9
//
//  Created by testing on 17.10.2023.
//

import UIKit

final class SettingViewController: UIViewController, ColorDelegate {
    
    func getColor(color: UIColor) {
        colorView.backgroundColor = color
    }
    
    @IBOutlet var colorView: UIView!
    
    @IBOutlet var redLabel: UILabel!
    @IBOutlet var greenLabel: UILabel!
    @IBOutlet var blueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var redTextField: UITextField!
    @IBOutlet var greenTextField: UITextField!
    @IBOutlet var blueTextField: UITextField!
    
    weak var delegate: ColorDelegate?
    var currentColor: UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let color = currentColor {
            colorView.backgroundColor = color
        }
        
        redTextField.keyboardType = .numberPad
        greenTextField.keyboardType = .numberPad
        blueTextField.keyboardType = .numberPad
        redTextField.delegate = self
        greenTextField.delegate = self
        blueTextField.delegate = self
        
        colorView.layer.cornerRadius = 15
        
        setupViewColor()
        addDoneButtonOnKeyboard()
    }
    
    @IBAction func sliderAction(_ sender: UISlider) {
        setupViewColor()
        
        switch sender {
        case redSlider:
            redLabel.text = string(from: redSlider)
            redTextField.text = string(from: redSlider)
        case greenSlider:
            greenLabel.text = string(from: greenSlider)
            greenTextField.text = string(from: greenSlider)
        default:
            blueLabel.text = string(from: blueSlider)
            blueTextField.text = string(from: blueSlider)
        }
    }
    
    @IBAction func pressedButtonAction(_ sender: UIButton) {
        if let color = colorView.backgroundColor { delegate?.getColor(color: color)
        }
        dismiss(animated: true, completion: nil)
    }
    
    private func setupViewColor() {
        colorView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }
    
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
    private func addDoneButtonOnKeyboard() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.hideKeyboard))
        toolbar.setItems([doneButton], animated: false)
        
        redTextField.inputAccessoryView = toolbar
        greenTextField.inputAccessoryView = toolbar
        blueTextField.inputAccessoryView = toolbar
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
}
    
    //MARK: -UITextFieldDelegate
    
extension SettingViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text, let value = Float(text) else {
            return
        }
        if textField == redTextField {
            redSlider.value = value
            redLabel.text = text
        } else if textField == greenTextField {
            greenSlider.value = value
            greenLabel.text = text
        } else if textField == blueTextField {
            blueSlider.value = value
            blueLabel.text = text
        }
        if value < 0 || value > 1 {
            showAlert()
        }
        setupViewColor()
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "Ошибка", message: "Некорректное значение", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ОК", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}



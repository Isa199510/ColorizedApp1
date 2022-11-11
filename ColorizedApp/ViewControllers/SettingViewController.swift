//
//  SettingViewController.swift
//  ColorizedApp
//
//  Created by Иса on 10.11.2022.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet var viewColor: UIView!
    
    @IBOutlet var redLabel: UILabel!
    @IBOutlet var greenLabel: UILabel!
    @IBOutlet var blueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    
    @IBOutlet var redTextField: UITextField!
    @IBOutlet var greenTextField: UITextField!
    @IBOutlet var blueTextField: UITextField!
    
    var delegate: SettingViewControllerDelegate!
    var backgroundColorMain: UIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        redTextField.delegate = self
        greenTextField.delegate = self
        blueTextField.delegate = self

        updateUI()
    }
    
// MARK: - IBActions
    
    @IBAction func doneButton() {
        let color = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1.0
        )
        delegate.setNewColorView(color: color)
        dismiss(animated: true)
    }
    
    @IBAction func rgbSlidersActions(_ sender: UISlider) {
        switch sender.tag {
        case 0:
            setValues(from: sender, toLabel: redLabel, toTextField: redTextField)
        case 1:
            setValues(from: sender, toLabel: greenLabel, toTextField: greenTextField)
        case 2:
            setValues(from: sender, toLabel: blueLabel, toTextField: blueTextField)
        default:
            break
        }
        setColorView()
    }
    
// MARK: - Private methods
    
    private func updateUI() {
        
        addToolBarDone(textField: redTextField)
        addToolBarDone(textField: greenTextField)
        addToolBarDone(textField: blueTextField)
        
        guard let colorsBackground = backgroundColorMain?.cgColor.components else { return }
        viewColor.backgroundColor = backgroundColorMain
        viewColor.layer.cornerRadius = 10
        
        let colors = [Float(colorsBackground[0]),
                      Float(colorsBackground[1]),
                      Float(colorsBackground[2])
        ]
        let sliders = [redSlider, greenSlider, blueSlider]
        let labels = [redLabel, greenLabel, blueLabel]
        let textFields = [redTextField, greenTextField, blueTextField]

        for (value, slider) in zip(colors, sliders) {
            slider?.value = value
        }
        for (value, label) in zip(colors, labels) {
            label?.text = String(format: "%1.2f", value )
        }
        for (value, textfield) in zip(colors, textFields) {
            textfield?.text = String(format: "%1.2f", value )
        }
    }
    
    // редактирование цвета View
    private func setColorView() {
        viewColor.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1.0
        )
    }
    // присвоение значений для label и textfield
    private func setValues(from slider: UISlider, toLabel: UILabel, toTextField: UITextField? = nil) {
        let text = String(format: "%1.2f", slider.value)
        guard let toTextField = toTextField else {
            toLabel.text = text
            return
        }
        toLabel.text = text
        toTextField.text = text
    }
}

extension SettingViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // если поле пустое, меняем на "0.00"
        textField.text = textField.text!.isEmpty ? "0.00" : textField.text
        guard let floatFromTextField = Float(textField.text ?? "0") else { return }
        
        if textField == redTextField {
            redSlider.setValue(floatFromTextField, animated: true)
            setValues(from: redSlider, toLabel: redLabel)
        } else if textField == greenTextField {
            greenSlider.setValue(floatFromTextField, animated: true)
            setValues(from: greenSlider, toLabel: greenLabel)
        } else if textField == blueTextField {
            blueSlider.setValue(floatFromTextField, animated: true)
            setValues(from: blueSlider, toLabel: blueLabel)
        }
        setColorView()
    }
    
    func addToolBarDone(textField: UITextField) {
        
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 50))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(donePressed))
        
        toolBar.items = [flexibleSpace ,doneButton]
        toolBar.sizeToFit()
        textField.inputAccessoryView = toolBar
    }
    
    @objc func donePressed() {
        view.endEditing(true)
    }
}

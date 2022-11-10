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
        
        viewColor.layer.cornerRadius = 10
        viewColor.backgroundColor = backgroundColorMain
    }
// MARK: - IBActions
    
    @IBAction func doneButton() {
        let color = UIColor(red: CGFloat(redSlider.value),
                            green: CGFloat(greenSlider.value),
                            blue: CGFloat(blueSlider.value),
                            alpha: 1.0)
        delegate.setNewColorView(color: color)
        
        dismiss(animated: true)
    }
    
    
    @IBAction func rgbSlidersActions(_ sender: UISlider) {
        switch sender.tag {
        case 0:
            setLabel(from: sender, to: redLabel, title: "R")
            setTextField(from: sender, to: redTextField)
            setColorView()
        case 1:
            setLabel(from: sender, to: greenLabel, title: "G")
            setTextField(from: sender, to: greenTextField)
            setColorView()
        case 2:
            setLabel(from: sender, to: blueLabel, title: "B")
            setTextField(from: sender, to: blueTextField)
            setColorView()
        default:
            break
        }
        
    }
    
// MARK: - Private methods
    
    private func setColorView() {
        viewColor.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1.0
        )
    }
    
    
    // при редактировании текстового поля, меняем значение слайдера
    private func setSlider(from textField: UITextField, to slider: UISlider) {
        guard let textFloat = Float(textField.text ?? "0") else { return }
        slider.value = textFloat
    }
    
    // при редактировании слайдера и текстового поля
    private func setLabel(from slider: UISlider, to label: UILabel, title: String? = nil) {
        guard let title = title else { return }
        label.text = String(format: "%@: %1.2f", title, slider.value)
    }
    
    private func setLabel(from textField: UITextField, to label: UILabel, title: String? = nil) {
        guard let text = textField.text else { return }
        guard let title = title else { return }
        label.text = String(format: "%@: %@", title, text)
    }
    
    private func setTextField(from slider: UISlider, to textField: UITextField) {
        textField.text = String(format: "%1.2f", slider.value)
    }
}

extension SettingViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        textField.text = textField.text!.isEmpty ? "0.00" : textField.text
        
        if textField == redTextField {
            setSlider(from: textField, to: redSlider)
            setLabel(from: textField, to: redLabel, title: "R")
            
        } else if textField == greenTextField {
            setSlider(from: textField, to: greenSlider)
            setLabel(from: textField, to: greenLabel, title: "G")
            
        } else if textField == blueTextField {
            setSlider(from: textField, to: blueSlider)
            setLabel(from: textField, to: blueLabel, title: "B")
        }
        setColorView()
    }
}

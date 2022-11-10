//
//  MainViewController.swift
//  ColorizedApp
//
//  Created by Иса on 10.11.2022.
//

import UIKit

protocol SettingViewControllerDelegate {
    var colorViewMain: UIColor { get }
    func setNewColorView(color: UIColor)
}

class MainViewController: UIViewController {
    
    var red: Float = 0.28
    var green: Float = 0.72
    var blue: Float = 0.43
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func settingButtonPressed(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let settingVC = storyboard.instantiateViewController(withIdentifier: "SettingID") as? SettingViewController else { return }
        settingVC.modalPresentationStyle = .fullScreen
        settingVC.delegate = self
//        settingVC.viewColorFromMain = UIColor(
//            red: CGFloat(red),
//            green: CGFloat(green),
//            blue: CGFloat(blue),
//            alpha: 1.0
//        )
        present(settingVC, animated: true)
    }
    
}

extension MainViewController: SettingViewControllerDelegate {
    var colorViewMain: UIColor {
        view.backgroundColor!
    }
    
    func setNewColorView(color: UIColor) {
        view.backgroundColor = color
    }
}

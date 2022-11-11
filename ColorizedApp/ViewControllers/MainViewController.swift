//
//  MainViewController.swift
//  ColorizedApp
//
//  Created by Иса on 10.11.2022.
//

import UIKit

protocol SettingViewControllerDelegate {
    func setNewColorView(color: UIColor)
}

class MainViewController: UIViewController {
    
    private var backgroundColorMain: UIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundColorMain = view.backgroundColor
    }
    
    @IBAction func settingButtonPressed(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let settingVC = storyboard.instantiateViewController(withIdentifier: "SettingID") as? SettingViewController else { return }
        settingVC.modalPresentationStyle = .fullScreen
        settingVC.delegate = self
        settingVC.backgroundColorMain = backgroundColorMain
        present(settingVC, animated: true)
    }
}

extension MainViewController: SettingViewControllerDelegate {
    func setNewColorView(color: UIColor) {
        view.backgroundColor = color
        self.backgroundColorMain = color
    }
}

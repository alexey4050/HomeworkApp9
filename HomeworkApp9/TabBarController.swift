//
//  TabBarController.swift
//  HomeworkApp9
//
//  Created by testing on 18.10.2023.
//

import UIKit

class TabBarController: UITabBarController, ColorDelegate {
    func setColor(_ color: UIColor) {}
    
    var settingViewController: SettingViewController?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let settingViewController = segue.destination as? SettingViewController {
            self.settingViewController = settingViewController
            settingViewController.delegate = self
        }
    }
}

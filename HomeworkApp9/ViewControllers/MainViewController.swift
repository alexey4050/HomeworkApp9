//
//  ColorViewController.swift
//  HomeworkApp9
//
//  Created by testing on 17.10.2023.
//

import UIKit

protocol ColorDelegate: AnyObject {
    func getColor(color: UIColor)
}

final class MainViewController: UIViewController, ColorDelegate{

    func getColor(color: UIColor) {
        colorView.backgroundColor = color
    }
    
    @IBOutlet var colorView: UIView!
    
    var colorDelegate: ColorDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sittingsSeque" {
            if let mainVC = segue.destination as? SettingViewController {
                mainVC.delegate = self
                mainVC.currentColor = colorView.backgroundColor
            }
        }
    }
    
    @IBAction func openSettings(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let settingsVC = storyboard.instantiateViewController(withIdentifier: "SettingsViewController") as? SettingViewController {
            settingsVC.delegate = self
            present(settingsVC, animated: true, completion: nil)
        }
    }
}


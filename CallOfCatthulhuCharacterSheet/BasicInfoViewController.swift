//
//  FirstViewController.swift
//  CallOfCatthulhuCharacterSheet
//
//  Created by Alex on 7/28/18.
//  Copyright © 2018 AlexDaigre. All rights reserved.
//

import UIKit

class BasicViewController: UIViewController {
    
    @IBOutlet weak var catNameField: UITextField!
    @IBOutlet weak var playerNameField: UITextField!
    @IBOutlet weak var roleField: UITextField!
    @IBOutlet weak var backgroundField: UITextField!
    @IBOutlet weak var descriptionField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionField.layer.cornerRadius = 5
        descriptionField.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        descriptionField.layer.borderWidth = 0.5
        descriptionField.clipsToBounds = true
        
        catNameField.delegate = self
        playerNameField.delegate = self
        roleField.delegate = self
        backgroundField.delegate = self
        descriptionField.delegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tappedBackground))
        view.addGestureRecognizer(tap)
        
        loadDataFromModel()
    }
    
    func loadDataFromModel(){
        if let tabBarController = self.tabBarController as? CustomTabController {
            catNameField.text = tabBarController.currentCat.catName
            playerNameField.text = tabBarController.currentCat.playerName
            roleField.text = tabBarController.currentCat.role
            backgroundField.text = tabBarController.currentCat.background
            descriptionField.text = tabBarController.currentCat.description
            print("Data loaded from model")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func tappedBackground() {
        self.view.endEditing(true)
    }
}

extension BasicViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if let tabBarController = self.tabBarController as? CustomTabController {
            switch textField.tag{
            case 1:
                tabBarController.currentCat.catName = catNameField.text ?? ""
            case 2:
                tabBarController.currentCat.playerName = playerNameField.text ?? ""
            case 3:
                tabBarController.currentCat.role = roleField.text ?? ""
            case 4:
                tabBarController.currentCat.background = backgroundField.text ?? ""
            default:
                break
            }
            print("textField edited", tabBarController.currentCat.catName, tabBarController.currentCat.playerName, tabBarController.currentCat.role, tabBarController.currentCat.background, tabBarController.currentCat.description, tabBarController.currentCat.story)
        }
        return true
    }
}

extension BasicViewController: UITextViewDelegate {
    func textViewShouldReturn(_ textView: UITextView) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        if let tabBarController = self.tabBarController as? CustomTabController {
                tabBarController.currentCat.description = descriptionField.text ?? ""
            print("textView edited", tabBarController.currentCat.catName, tabBarController.currentCat.playerName, tabBarController.currentCat.role, tabBarController.currentCat.background, tabBarController.currentCat.description, tabBarController.currentCat.story)
        }
        return true
    }
}


//
//  SecondViewController.swift
//  CallOfCatthulhuCharacterSheet
//
//  Created by Alex on 7/28/18.
//  Copyright © 2018 AlexDaigre. All rights reserved.
//

import UIKit

class StoryViewController: UIViewController {

    @IBOutlet weak var storyField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        storyField.layer.cornerRadius = 5
        storyField.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        storyField.layer.borderWidth = 0.5
        storyField.clipsToBounds = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tappedBackground))
        view.addGestureRecognizer(tap)
        
        storyField.delegate = self
        
        loadDataFromModel()
    }
    
    func loadDataFromModel(){
        if let tabBarController = self.tabBarController as? CustomTabController {
            storyField.text = tabBarController.currentCat.story
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

extension StoryViewController: UITextViewDelegate {
    func textViewShouldReturn(_ textView: UITextView) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        if let tabBarController = self.tabBarController as? CustomTabController {
                tabBarController.currentCat.description = storyField.text ?? ""
            print("textView edited", tabBarController.currentCat.catName, tabBarController.currentCat.playerName, tabBarController.currentCat.role, tabBarController.currentCat.background, tabBarController.currentCat.description, tabBarController.currentCat.story)
        }
        return true
    }
}


//
//  ConditionViewController.swift
//  CallOfCatthulhuCharacterSheet
//
//  Created by Alex on 7/30/18.
//  Copyright © 2018 AlexDaigre. All rights reserved.
//

import UIKit

class ConditionViewController: UIViewController {

    @IBOutlet weak var injurysLabel: UILabel!
    @IBOutlet weak var treatsLabel: UILabel!
    @IBOutlet weak var livesLabel: UILabel!
    
    @IBOutlet weak var injuriesStepper: UIStepper!
    @IBOutlet weak var treatsStepper: UIStepper!
    @IBOutlet weak var livesButton: UIButton!
    
    @IBOutlet weak var markedPlacesTable: UITableView!
    @IBOutlet weak var markedPlacesField: UITextField!
    @IBOutlet weak var markedPlacesButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        markedPlacesField.delegate = self
        
        markedPlacesTable.dataSource = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tappedBackground))
        view.addGestureRecognizer(tap)
        
        loadDataFromModel()
    }
    
    func loadDataFromModel(){
        if let tabBarController = self.tabBarController as? CustomTabController {
            injurysLabel.text = String(tabBarController.currentCat.getInjurys())
            treatsLabel.text = String(tabBarController.currentCat.getTreats())
            livesLabel.text = String(tabBarController.currentCat.getLives())
            print("Data loaded from model")
        }
    }
    
    @IBAction func addNewMarkedPlace(_ sender: UIButton) {
        if let tabBarController = self.tabBarController as? CustomTabController {
            tabBarController.currentCat.addMarkedPlace(place: markedPlacesField.text ?? "")
            markedPlacesTable.reloadData()
            markedPlacesField.text = ""
        }
    }
    
    @IBAction func injuriesChanged(_ sender: UIStepper) {
        if let tabBarController = self.tabBarController as? CustomTabController {
            if(tabBarController.currentCat.getInjurys() < Int(sender.value)) {
                tabBarController.currentCat.addInjurys()
            } else if(tabBarController.currentCat.getInjurys() > Int(sender.value)) {
                tabBarController.currentCat.subtractInjurys()
            }
            sender.value =  Double(tabBarController.currentCat.getInjurys())
            loadDataFromModel()
        }
    }
    
    @IBAction func treatsChanged(_ sender: UIStepper) {
        if let tabBarController = self.tabBarController as? CustomTabController {
            if(tabBarController.currentCat.getTreats() < Int(sender.value)) {
                tabBarController.currentCat.addTreats()
            } else if(tabBarController.currentCat.getTreats() > Int(sender.value)) {
                tabBarController.currentCat.subtractTreats()
            }
            sender.value =  Double(tabBarController.currentCat.getTreats())
            loadDataFromModel()
        }
    }
    
    @IBAction func loseLife(_ sender: UIButton) {
        if let tabBarController = self.tabBarController as? CustomTabController {
            tabBarController.currentCat.loseLives()
            loadDataFromModel()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func tappedBackground() {
        self.view.endEditing(true)
    }
}

extension ConditionViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if let tabBarController = self.tabBarController as? CustomTabController {
            if let newPlace = markedPlacesField.text{
                tabBarController.currentCat.addMarkedPlace(place: newPlace)
                print("markedPlaces edited", tabBarController.currentCat.catName, tabBarController.currentCat.playerName, tabBarController.currentCat.role, tabBarController.currentCat.background, tabBarController.currentCat.description, tabBarController.currentCat.story)
            }
            loadDataFromModel()
        }
        return true
    }
}

extension ConditionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tabBarController = self.tabBarController as? CustomTabController {
            return tabBarController.currentCat.getMarkedPlacesCount()
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "placeCell", for: indexPath)
        
        if let tabBarController = self.tabBarController as? CustomTabController {
            cell.textLabel?.text = tabBarController.currentCat.getMarkedPlaces(atIndex: indexPath.row)
            return cell
        }
        
        return cell
    }
}

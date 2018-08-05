//
//  CatModel.swift
//  CallOfCatthulhuCharacterSheet
//
//  Created by Alex on 7/30/18.
//  Copyright © 2018 AlexDaigre. All rights reserved.
//

import Foundation

class Cat {
    var catName: String
    var playerName: String
    var role: String
    var background: String
    var description: String
    var story: String
    
    private var injuries: Int
    private var treats: Int
    private var lives: Int
    private var markedPlaces: [String]
    
    init() {
        self.catName = ""
        self.playerName = ""
        self.role = ""
        self.background = ""
        self.description = ""
        self.story = ""
        self.injuries = 0
        self.treats = 3
        self.lives = 9
        self.markedPlaces = ["", "", ""]
    }
    
    func addMarkedPlace(place: String) {
        if(markedPlaces.count < 3){
            markedPlaces.append(place)
        }else{
            markedPlaces.removeFirst()
            markedPlaces.append(place)
        }
    }
    
    func getMarkedPlaces(atIndex: Int) -> String {
        return markedPlaces[atIndex]
    }
    
    func getMarkedPlacesCount() -> Int {
        return markedPlaces.count
    }
    
    func loseLives(){
        if (lives > 0){
            lives -= 1
        }
    }
    
    func getLives() -> Int {
        return lives
    }
    
    func addTreats(){
        if(treats <= 3){
            treats += 1
        }
    }
    
    func subtractTreats(){
        if(treats > 0){
            treats -= 1
        }
    }
    
    func getTreats() -> Int {
        return treats
    }
    
    func addInjurys(){
        if(injuries <= 3){
            injuries += 1
        }
    }
    
    func subtractInjurys(){
        if(injuries > 0){
            injuries -= 1
        }
    }
    
    func getInjurys() -> Int {
        return injuries
    }
}

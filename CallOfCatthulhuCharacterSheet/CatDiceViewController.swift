//
//  CatDiceViewController.swift
//  CallOfCatthulhuCharacterSheet
//
//  Created by Alex on 7/30/18.
//  Copyright © 2018 AlexDaigre. All rights reserved.
//

import UIKit
import AVFoundation

class CatDiceViewController: UIViewController {
    
    @IBOutlet weak var catDiceImageOne: UIImageView!
    @IBOutlet weak var catDiceImageTwo: UIImageView!
    
    @IBOutlet weak var rollButton: UIButton!
    
    var player: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupImageViewAnimation()
    }
    
    private func setupImageViewAnimation() {
        catDiceImageOne.animationImages = [UIImage(named: "happyCat"), UIImage(named: "sadCat")] as? [UIImage]
        catDiceImageOne.animationDuration = 0.6
        catDiceImageTwo.animationImages = [UIImage(named: "sadCat"), UIImage(named: "happyCat")] as? [UIImage]
        catDiceImageTwo.animationDuration = 0.4
    }
    
    private func getDiceResults() {
        let result1 = Int(arc4random_uniform(3))
        let result2 = Int(arc4random_uniform(3))
        
        if(result1 > 0){
            catDiceImageOne.image = UIImage(named: "happyCat")
        }else {
            catDiceImageOne.image = UIImage(named: "sadCat")
        }
        
        if(result2 > 0){
            catDiceImageTwo.image = UIImage(named: "happyCat")
        }else {
            catDiceImageTwo.image = UIImage(named: "sadCat")
        }
    }
    
    func playDieRollSound() {
        //guard let url = Bundle.main.url(forResource: "roll.mp3", withExtension: "mp3") else { return }
        guard let path = Bundle.main.path(forResource: "roll.mp3", ofType:nil) else { return }
        let url = URL(fileURLWithPath: path)
        print("playing Sound at", url)
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url)
            print("playing Sound")
            
            player.play()
            
        } catch let error {
            print("There was an error:", error.localizedDescription)
        }
    }

    @IBAction func rollButtonPressed(_ sender: UIButton) {
        rollButton.isEnabled = false
        catDiceImageOne.startAnimating()
        catDiceImageTwo.startAnimating()
        playDieRollSound()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.25) {
            self.catDiceImageOne.stopAnimating()
            self.catDiceImageTwo.stopAnimating()
            
            self.rollButton.isEnabled = true
            self.getDiceResults()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

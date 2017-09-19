//
//  ViewController.swift
//  Match
//
//  Created by chris  on 9/15/17.
//  Copyright © 2017 kuronuma studios. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    let model = CardModel()
    var cards = [Card]()
    var revealedCard:Card?
    var timer:Timer?
    var countDown = 40
    
    var cardFlipSoundPlayer:AVAudioPlayer?
    var correctSoundPlayer:AVAudioPlayer?
    var wrongSoundPlayer:AVAudioPlayer?
    var shuffleSoundPlayer:AVAudioPlayer?
    
    var stackViewArray = [UIStackView]()
    @IBOutlet weak var firstStackView: UIStackView!
    @IBOutlet weak var secondStackView: UIStackView!
    @IBOutlet weak var thirdStackView: UIStackView!
    @IBOutlet weak var fourthStackView: UIStackView!
    @IBOutlet weak var countDownLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //create and initialize the sound players
        do {
            let shuffleSoundPath = Bundle.main.path(forResource: "shuffle", ofType: "wav")
            let shuffleSoundUrl = URL(fileURLWithPath: shuffleSoundPath!)
            shuffleSoundPlayer = try AVAudioPlayer(contentsOf: shuffleSoundUrl)
        }
        catch {
            // Sound player couldn't be created
        }
        
        do {
            let cardFlipSoundPath = Bundle.main.path(forResource: "cardflip", ofType: "wav")
            let cardFlipSoundUrl = URL(fileURLWithPath: cardFlipSoundPath!)
            cardFlipSoundPlayer = try AVAudioPlayer(contentsOf: cardFlipSoundUrl)
        }
        catch {
            // Sound player couldn't be created
        }
        
        do {
            let correctSoundPath = Bundle.main.path(forResource: "dingcorrect", ofType: "wav")
            let correctSoundUrl = URL(fileURLWithPath: correctSoundPath!)
            correctSoundPlayer = try AVAudioPlayer(contentsOf: correctSoundUrl)
        }
        catch {
            // Sound player couldn't be created
        }
        
        do {
            let wrongSoundPath = Bundle.main.path(forResource: "dingwrong", ofType: "wav")
            let wrongSoundUrl = URL(fileURLWithPath: wrongSoundPath!)
            wrongSoundPlayer = try AVAudioPlayer(contentsOf: wrongSoundUrl)
        }
        catch {
            // Sound player couldn't be created
        }
        
        
        
        //put the 4 stackViews into an array
        stackViewArray += [firstStackView, secondStackView, thirdStackView, fourthStackView]
        
        //Get the cards
        cards = model.getCards()
        
        // Layout the cards
        layoutcards()
        
        //set the countDown label
        countDownLabel.text = String(countDown)
        
        //create and schedule a timer
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerUpdate), userInfo: nil, repeats: true)
    }
    
    @objc func timerUpdate() {
        countDown -= 1
        
        if countDown == 0 {
            // stop the timer
            timer?.invalidate()
            
            // stop the match game
            
            // check if the user has matched all of the cards
            var userHasMatchedAllCards = true
            for card in cards {
                if card.isDone == false {
                    userHasMatchedAllCards = false
                    break
                }
            }
            
            var popUpMessage = ""
            if userHasMatchedAllCards == true {
                //game is won
                popUpMessage = "Won"
            }
            else {
                // game is lost
               popUpMessage = "Lost"
            }
            
            //create alert
            let alert = UIAlertController(title: "Times up!", message: popUpMessage, preferredStyle: .alert)
            //create alert action
            let alertAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            
            //attach action alert
            alert.addAction(alertAction)
            
            //present the alert
            present(alert, animated: true, completion: nil)
        }
        else {
            
            //update the label in the UI
            countDownLabel.text = String(countDown)
        }
    }
    
    func layoutcards() {
        
        //play shuffle sound
        shuffleSoundPlayer?.play()
        
        //keeps track of which card we're at
        var cardIndex = 0
        
        // loop through the four stackviews and put four crads into each
        for stackview in stackViewArray {
            
            // put four card objects into the stackview
            for _ in 1...4{
                
                // check if card exists at index before adding
                if cardIndex < cards.count {
                    
                    // Set card that we're looking at
                    let card = cards[cardIndex]
                    card.translatesAutoresizingMaskIntoConstraints = false
                    
                    // create a gesture recognizer and attach it to the card
                    let recognizer = UITapGestureRecognizer(target: self, action: #selector(cardTapped(gestureRecognizer:)))
                    card.addGestureRecognizer(recognizer)
                    
                    // Set the size of the card object
                    let heightConstraint = NSLayoutConstraint(item: card, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 170)
                    
                    let widthContraint = NSLayoutConstraint(item: card, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 120)
                    
                    card.addConstraints([heightConstraint, widthContraint])
                    
//                    //set a color
//                    card.backgroundColor = UIColor.red
                
                    //put a card into the stackView
                    stackview.addArrangedSubview(cards[cardIndex])
                    cardIndex += 1
                }
            }
        }
    }
    
    @objc func cardTapped(gestureRecognizer:UITapGestureRecognizer) {
        
        // check if countdown is zero
        if countDown == 0 {
            return
        }
        
        //play sound
        cardFlipSoundPlayer?.play()
        
        
        // card is tapped
        let card = gestureRecognizer.view as! Card
        
        //check if the card is already flippedUp
        if card.flippedUp == false {
            
            //reveal card
            card.flipUp()
            
            if revealedCard == nil {
                //first card being flipped up
                
                //track this card as the first card being flipped up
                revealedCard = card
            }
            else {
                //second card being flipped up
                if card.cardValue == revealedCard?.cardValue {
                    
                    // cards match
                    correctSoundPlayer?.play()
                    
                    //remove both cards from the grid
                    card.isDone = true
                    revealedCard?.isDone = true
                    
                    //reset the tracking of the first card
                    revealedCard = nil
                }
                else {
                    //cards dont match
                    wrongSoundPlayer?.play()
                    
                    //flip both of them down again
                    let _ = Timer.scheduledTimer(timeInterval: 1, target: card, selector: #selector(Card.flipDown), userInfo: nil, repeats: false)
                    
                    let _ = Timer.scheduledTimer(timeInterval: 1, target: revealedCard!, selector: #selector(Card.flipDown), userInfo: nil, repeats: false)
                    revealedCard?.flipDown()
                    
                    //reset the tracking of the first card
                    revealedCard = nil
                }
            }
        }
        
        // reveal card
        card.flipUp()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        //TEST
    }


}


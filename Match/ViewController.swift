//
//  ViewController.swift
//  Match
//
//  Created by chris  on 9/15/17.
//  Copyright © 2017 kuronuma studios. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let model = CardModel()
    var cards = [Card]()
    
    var stackViewArray = [UIStackView]()
    @IBOutlet weak var firstStackView: UIStackView!
    @IBOutlet weak var secondStackView: UIStackView!
    @IBOutlet weak var thirdStackView: UIStackView!
    @IBOutlet weak var fourthStackView: UIStackView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //put the 4 stackViews into an array
        stackViewArray += [firstStackView, secondStackView, thirdStackView, fourthStackView]
        
        //Get the cards
        cards = model.getCards()
        
        // Layout the cards
        layoutcards()
    }
    
    func layoutcards() {
        
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        //TEST
    }


}


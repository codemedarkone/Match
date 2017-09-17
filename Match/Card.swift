//
//  Card.swift
//  Match
//
//  Created by chris  on 9/15/17.
//  Copyright © 2017 kuronuma studios. All rights reserved.
//

import UIKit

class Card: UIView {

    let cardImageView = UIImageView()
    var cardValue = 0
    let cardNames = ["card2", "card3", "card3", "card4", "card5", "card6", "card7", "card8", "card9", "card10", "jack", "queen", "king", "ace"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // custom functionality
        //TODO: Initialize the imageview with an image
        //TODo: add it to the view
        //TODO: set constraints for the imageview
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //fatalError("init(coder:) has not been implemented")
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
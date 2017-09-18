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
        
        // add image view into view
        addSubview(cardImageView)
        
        //TODO: Initialize the imageview with an image
        cardImageView.translatesAutoresizingMaskIntoConstraints = false
        cardImageView.image = UIImage(named: "back")
        
        //TODO: set constraints for the imageview
        let heightConstraint = NSLayoutConstraint(item: cardImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 170)
        
        let widthConstraint = NSLayoutConstraint(item: cardImageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 120)
        
        cardImageView.addConstraints([widthConstraint, heightConstraint])
        
        let topConstraint = NSLayoutConstraint(item: cardImageView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
        
        let leftConstraint = NSLayoutConstraint(item: cardImageView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0)
        
        addConstraints([topConstraint, leftConstraint])
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

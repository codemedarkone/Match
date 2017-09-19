//
//  Card.swift
//  Match
//
//  Created by chris  on 9/15/17.
//  Copyright © 2017 kuronuma studios. All rights reserved.
//

import UIKit

class Card: UIView {

    let backImageView = UIImageView()
    let frontImageView = UIImageView()
    
    var cardValue = 0 
    let cardNames = ["card2", "card3", "card3", "card4", "card5", "card6", "card7", "card8", "card9", "card10", "jack", "queen", "king", "ace"]
    
    var flippedUp = false
    var isDone = false {
        didSet {
            if isDone == true {
                // remove the image from the cardimageview
                
                UIView.animate(withDuration: 1, delay: 2, options: .curveEaseOut, animations: {
                    
                    self.backImageView.alpha = 0
                    self.frontImageView.alpha = 0
                    
                }, completion: nil)
                
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // add image view into view
        addSubview(backImageView)
        
        //TODO: Initialize the imageview with an image
        backImageView.translatesAutoresizingMaskIntoConstraints = false
        backImageView.image = UIImage(named: "back")
        
        applySizeConstraints(imageView: backImageView)
        applyPositionConstraints(imageView: backImageView)
        
        //add front imageView into view
        addSubview(frontImageView)
        
        frontImageView.translatesAutoresizingMaskIntoConstraints = false
        applySizeConstraints(imageView: frontImageView)
        applyPositionConstraints(imageView: frontImageView)
        
       
    }
    
    func applySizeConstraints(imageView:UIImageView){
        
        //TODO: set constraints for the imageview
        let heightConstraint = NSLayoutConstraint(item: imageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 170)
        
        let widthConstraint = NSLayoutConstraint(item: imageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 120)
        
        imageView.addConstraints([widthConstraint, heightConstraint])
    }
    
    func applyPositionConstraints(imageView:UIImageView) {
        
        let topConstraint = NSLayoutConstraint(item: imageView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
        
        let leftConstraint = NSLayoutConstraint(item: imageView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0)
        
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
    
    func flipUp() {
        
        //set the front card image
        frontImageView.image = UIImage(named: cardNames[cardValue])
        
        //run the transition animation
        UIImageView.transition(from: backImageView, to: frontImageView, duration: 1, options: .transitionFlipFromLeft, completion: nil)
        
        applyPositionConstraints(imageView: frontImageView)
        
        //set the flag
        flippedUp = true
    }
    
   @objc func flipDown() {
        
        //run the transition animation
        UIView.transition(from: frontImageView, to: backImageView, duration: 1, options: .transitionFlipFromRight, completion: nil)
        
        applyPositionConstraints(imageView: backImageView)
        
        //set the flag
        flippedUp = false
    }

}

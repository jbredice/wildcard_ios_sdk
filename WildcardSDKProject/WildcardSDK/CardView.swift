//
//  CardView.swift
//  WildcardSDKProject
//
//  Created by David Xiang on 12/8/14.
//
//

import Foundation
import UIKit
import QuartzCore

public class CardView : UIView
{
    let containerView:UIView
    public var physics:CardPhysics?
    public var contentView:CardContentView?
    public var backOfCard:UIView!
    public var backingCard:Card!
    
    // MARK: Public Class Functions
    
    // Renders a CardView from a Card w/ best fit layout
    public class func createCardViewFromCard(card:Card)->CardView?{
        let layoutToUse = CardLayoutEngine.sharedInstance.matchLayout(card)
        return CardView.createCardViewFromCard(card, layout:layoutToUse)
    }
    
    // Renders a CardView from a Card w/ explicit layout
    public class func createCardViewFromCard(card:Card, layout:CardLayout)->CardView?{
        
        // generate content view for this card
        let cardContentView = CardContentView.generateContentViewFromLayout(layout)
        
        // initialize the CardView with optimal size
        var newCardView = CardView(frame:CGRectZero)
        
        // initialize content view
        newCardView.initializeContentView(cardContentView)
        
        // the back
        newCardView.initializeBackOfCard()
        
        // update content for card
        cardContentView.updateViewForCard(card)
        
        // finalize
        newCardView.finalizeCard()
        
        // backing card
        newCardView.backingCard = card
        
        return newCardView
        
    }
    
    // MARK: UIView
    override init(frame: CGRect) {
        self.containerView = UIView()
        super.init(frame: frame)
        convenienceInitialize()
    }
    
    override public func layoutSubviews()
    {
        super.layoutSubviews()
        
        // reset shadow path
        let path = UIBezierPath(rect: bounds)
        layer.shadowPath =  path.CGPath
    }
    
    required public init(coder: NSCoder) {
        self.containerView = UIView()
        super.init(coder: coder)
        convenienceInitialize()
    }
    
    // MARK: Instance
    public func renderCard(card:Card, animated:Bool){
        if(contentView != nil){
            // if already belongs to a view, keep current position
            var prevCenter = CGPointZero
            if(hasSuperview()){
                prevCenter = center
            }
            
            let cardContentView = CardContentView.generateContentViewFromLayout(CardLayoutEngine.sharedInstance.matchLayout(card))
            
            // update content for card
            cardContentView.updateViewForCard(card)
  
            // reset the content view
            initializeContentView(cardContentView)
            
            // finalize
            finalizeCard()
            
            // reset position
            if (hasSuperview()){
                center = prevCenter
            }
            
            backingCard = card
        }
    }
    
    // MARK: Private
    func initializeContentView(cardContentView:CardContentView){
        if(contentView != nil){
            contentView!.removeFromSuperview()
            contentView = nil
        }
        
        // initialize the bounds initially to whatever the content view is
        bounds =  cardContentView.bounds
        
        containerView.addSubview(cardContentView)
        cardContentView.constrainToSuperViewEdges()
        contentView = cardContentView
    }
    
    func initializeBackOfCard(){
        // TODO: Placeholder for now
        let label = UILabel(frame: CGRectZero)
        label.textColor = UIColor.wildcardDarkBlue()
        label.font =  UIFont.wildcardLargePlaceholderFont()
        label.text = "The Back"
        
        backOfCard = UIView(frame: CGRectZero)
        backOfCard?.backgroundColor = UIColor.whiteColor()
        insertSubview(backOfCard!, belowSubview: containerView)
        backOfCard?.constrainToSuperViewEdges()
        
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        backOfCard?.addSubview(label)
        backOfCard?.addConstraint(NSLayoutConstraint(item: label, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: backOfCard, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0))
        backOfCard?.addConstraint(NSLayoutConstraint(item: label, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: backOfCard, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 4))
    }
    
    func finalizeCard(){
       if(contentView != nil){
            let optimalSize = contentView!.optimalBounds()
            
            // always finalize w/ frame origin at 0,0
            frame = CGRectMake(0, 0, optimalSize.size.width, optimalSize.size.height)
            
            setNeedsLayout()
        }
    }
    
    private func convenienceInitialize(){
        
        backgroundColor = UIColor.clearColor()
        containerView.backgroundColor = UIColor.clearColor()
        containerView.layer.cornerRadius = 2.0
        containerView.layer.masksToBounds = true
        addSubview(containerView)
        containerView.constrainToSuperViewEdges()
        
        // drop shadow
        layer.shadowColor = UIColor.wildcardMediumGray().CGColor
        layer.shadowOpacity = 0.8
        layer.shadowOffset = CGSizeMake(0.0, 1.0)
        layer.shadowRadius = 1.0
        
        physics = CardPhysics(cardView:self)
        physics?.setup()
    }
}
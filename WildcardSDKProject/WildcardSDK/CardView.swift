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
    var contentView:CardContentView?
    
    // MARK: UIView
    override init(frame: CGRect) {
        self.containerView = UIView()
        super.init(frame: frame)
        convenienceInitialize()
    }
    
    // MARK: Public
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
    
    public func resizeToOptimalBounds(){
        finalizeCard()
    }
    
    public func renderCard(card:Card){
        println("Re render card now")
        
        var originalOrigin = CGRectZero
        if(superview != nil)
        {
            originalOrigin = frame
        }
        
        let cardContentView = CardViewRenderer.generateContentViewFromLayout(CardLayoutEngine.sharedInstance.matchLayout(card))
        
        initializeContentView(cardContentView)
        
        // update content for card
        cardContentView.updateViewForCard(card)
        
        // any last minute things to do to card view before returning to user
        if (superview == nil){
            finalizeCard()
        }else{
            // already belongs to a super view, do not change position, but re frame to optimal
            let optimalSize = contentView!.optimalBounds()
            
            // always finalize w/ origin at 0,0
            frame = CGRectMake(originalOrigin.origin.x, originalOrigin.origin.y, optimalSize.width, optimalSize.height)
            
            setNeedsLayout()
        }
        
    }
    
    // MARK: Instance
    func initializeContentView(cardContentView:CardContentView){
        if(contentView != nil){
            contentView!.removeFromSuperview()
            contentView = nil
        }
        
        // initialize the bounds initially to whatever the content view is
        bounds =  cardContentView.bounds
        layoutIfNeeded()
        
        containerView.addSubview(cardContentView)
        cardContentView.constrainToSuperViewEdges()
        contentView = cardContentView
    }
    
    func finalizeCard(){
        if(contentView != nil){
            let optimalSize = contentView!.optimalBounds()
            
            // always finalize w/ origin at 0,0
            frame = CGRectMake(0, 0, optimalSize.width, optimalSize.height)
            
            setNeedsLayout()
        }
    }
    
    // MARK: Private
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
    }
    
}
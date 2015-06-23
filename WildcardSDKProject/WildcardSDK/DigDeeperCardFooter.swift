//
//  TallDigDeeperCardFooter.swift
//  WildcardSDKProject
//
//  Created by David Xiang on 12/16/14.
//
//

import Foundation

@objc
public class DigDeeperFooter: CardViewElement {
    
    /// Buttons
    public var readMoreButton:UIButton!
    public var digDeeperButton:UIButton!
    
    /// Content insets
    public var contentEdgeInset:UIEdgeInsets{
        get{
            return UIEdgeInsetsMake(topConstraint.constant, leftConstraint.constant, bottomConstraint.constant, rightConstraint.constant)
        }
        set{
            topConstraint.constant = newValue.top
            leftConstraint.constant = newValue.left
            rightConstraint.constant = newValue.right
            bottomConstraint.constant = newValue.bottom
        }
    }
    
    // MARK: Private
    private var leftConstraint:NSLayoutConstraint!
    private var rightConstraint:NSLayoutConstraint!
    private var topConstraint:NSLayoutConstraint!
    private var bottomConstraint:NSLayoutConstraint!
    
    override public func initialize() {
        readMoreButton = UIButton.defaultReadMoreButton()
        addSubview(readMoreButton!)
        
        leftConstraint = readMoreButton?.constrainLeftToSuperView(15)
        topConstraint = readMoreButton?.constrainTopToSuperView(10)
        bottomConstraint = readMoreButton?.constrainBottomToSuperView(10)
        
        readMoreButton.addTarget(self, action: "readMoreButtonTapped", forControlEvents: UIControlEvents.TouchUpInside)
        
        digDeeperButton = UIButton.defaultDigDeeperButton()
        addSubview(digDeeperButton!)
        
        rightConstraint = digDeeperButton?.constrainRightToSuperView(15)
        topConstraint = digDeeperButton?.constrainTopToSuperView(10)
        bottomConstraint = digDeeperButton?.constrainBottomToSuperView(10)
        
        digDeeperButton.addTarget(self, action: "DigDeeperButtonTapped", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    override public func optimizedHeight(cardWidth:CGFloat)->CGFloat{
        var height:CGFloat = 0
        height += topConstraint.constant
        height += readMoreButton.intrinsicContentSize().height
        height += bottomConstraint.constant
        return round(height)
    }
    
    override public func adjustForPreferredWidth(cardWidth: CGFloat) {
    }
    
    func readMoreButtonTapped(){
        WildcardSDK.analytics?.trackEvent("CardEngaged", withProperties: ["cta":"readMore"], withCard: cardView?.backingCard)
        if(cardView != nil){
            cardView!.delegate?.cardViewRequestedAction?(cardView!, action: CardViewAction(type: .Maximize, parameters: nil))
        }
    }
    
    func DigDeeperButtonTapped(){
        if(cardView != nil){
            cardView!.delegate?.cardViewRequestedAction?(cardView!, action: CardViewAction(type: .Custom, parameters: nil))
        }
    }
}
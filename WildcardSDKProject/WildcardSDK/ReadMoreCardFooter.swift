//
//  TallReadMoreCardFooter.swift
//  WildcardSDKProject
//
//  Created by David Xiang on 12/16/14.
//
//

import Foundation

@objc
public class ReadMoreFooter: CardViewElement {
    
    public var readMoreButton:UIButton!
//    public var saveButton:UIButton!
    
    public var contentEdgeInset:UIEdgeInsets{
        get{
//            return UIEdgeInsetsMake(topConstraint.constant, leftConstraint.constant, bottomConstraint.constant, rightConstraint.constant)
            return UIEdgeInsetsMake(topConstraint.constant, leftConstraint.constant, bottomConstraint.constant, 0.0);
        }
        set{
            topConstraint.constant = newValue.top
            leftConstraint.constant = newValue.left
//            rightConstraint.constant = newValue.right
            bottomConstraint.constant = newValue.bottom
        }
    }
    
    // MARK: Private
    private var topConstraint:NSLayoutConstraint!
    private var bottomConstraint:NSLayoutConstraint!
    private var leftConstraint:NSLayoutConstraint!
//    private var rightConstraint:NSLayoutConstraint!
    
    override public func initialize() {
        readMoreButton = UIButton.defaultReadMoreButton()
        addSubview(readMoreButton!)
        
        leftConstraint = readMoreButton?.constrainLeftToSuperView(15)
        topConstraint = readMoreButton?.constrainTopToSuperView(10)
        bottomConstraint = readMoreButton?.constrainBottomToSuperView(10)
        
        readMoreButton.addTarget(self, action: "readMoreButtonTapped", forControlEvents: UIControlEvents.TouchUpInside)
        
//        saveButton = UIButton.defaultSaveButton()
//        addSubview(saveButton!)
//        rightConstraint = saveButton?.constrainRightToSuperView(15)
//        
//        saveButton.addTarget(self, action: "saveButtonTapped", forControlEvents: .TouchUpInside)
//        
//        addConstraint(NSLayoutConstraint(item: saveButton, attribute: .CenterY, relatedBy: .Equal, toItem: readMoreButton, attribute: .CenterY, multiplier: 1.0, constant: 0))
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
    
//    func saveButtonTapped(){
//        if(cardView != nil){
//            cardView!.delegate?.cardViewRequestedAction?(cardView!, action: CardViewAction(type: .Custom, parameters: nil))
//        }
//    }
}
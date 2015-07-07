//
//  ViewOnWebFooter.swift
//  WildcardSDKProject
//
//  Created by David Xiang on 12/16/14.
//
//

import Foundation

@objc
public class ViewOnWebCardFooter: CardViewElement {
    
    public var readMoreButton:UIButton!
    public var saveButton:UIButton!
    public var hairline:UIView!
    
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
    private var topConstraint:NSLayoutConstraint!
    private var bottomConstraint:NSLayoutConstraint!
    private var leftConstraint:NSLayoutConstraint!
    private var rightConstraint:NSLayoutConstraint!
    
    override public func initialize() {
        readMoreButton = UIButton.defaultReadMoreButton()
        addSubview(readMoreButton!)
        
        leftConstraint = readMoreButton?.constrainLeftToSuperView(15)
        topConstraint = readMoreButton?.constrainTopToSuperView(10)
        bottomConstraint = readMoreButton?.constrainBottomToSuperView(10)
        
        hairline = addTopBorderWithWidth(0.5, color: UIColor.wildcardBackgroundGray())
        
        readMoreButton.addTarget(self, action: "readMoreButtonTapped", forControlEvents: .TouchUpInside)
        
        saveButton = UIButton.defaultSaveButton()
        addSubview(saveButton!)
        rightConstraint = saveButton?.constrainRightToSuperView(15)
        
        saveButton.addTarget(self, action: "saveButtonTapped", forControlEvents: .TouchUpInside)
        
        addConstraint(NSLayoutConstraint(item: saveButton, attribute: .CenterY, relatedBy: .Equal, toItem: readMoreButton, attribute: .CenterY, multiplier: 1.0, constant: 0))
    }
    
    func readMoreButtonTapped(){
        if(cardView != nil){
            WildcardSDK.analytics?.trackEvent("CardEngaged", withProperties: ["cta":"viewOnWeb"], withCard: cardView!.backingCard)
            cardView!.handleViewOnWeb(cardView!.backingCard.webUrl)
        }
    }
    
    func saveButtonTapped(){
        if(cardView != nil){
            cardView!.delegate?.cardViewRequestedAction?(cardView!, action: CardViewAction(type: .Custom, parameters: nil))
        }
    }
    
    override public func adjustForPreferredWidth(cardWidth: CGFloat) {
    }
    
    override public func optimizedHeight(cardWidth:CGFloat)->CGFloat{
        var height:CGFloat = 0
        height += topConstraint.constant
        height += readMoreButton.intrinsicContentSize().height
        height += bottomConstraint.constant
        return round(height)
    }
}
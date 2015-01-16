//
//  ViewOnWebFooter.swift
//  WildcardSDKProject
//
//  Created by David Xiang on 12/16/14.
//
//

import Foundation

public class ViewOnWebCardFooter: CardViewElement {
    
    public var viewOnWebButton:UIButton!
    public var hairline:UIView!
    
    public var viewOnWebButtonOffset:UIOffset!{
        get{
            return UIOffset(horizontal: verticalCenterConstraint.constant, vertical: verticalCenterConstraint.constant)
        }
        set{
            verticalCenterConstraint.constant = newValue.vertical
            verticalCenterConstraint.constant = newValue.horizontal
        }
    }
    
    private var verticalCenterConstraint:NSLayoutConstraint!
    private var leftConstraint:NSLayoutConstraint!
    
    override func initializeElement() {
        viewOnWebButton = UIButton.defaultViewOnWebButton()
        addSubview(viewOnWebButton!)
        verticalCenterConstraint = viewOnWebButton?.verticallyCenterToSuperView(0)
        leftConstraint = viewOnWebButton?.constrainLeftToSuperView(10)
        hairline = addTopBorderWithWidth(0.5, color: UIColor.wildcardBackgroundGray())
    }
    
    override func optimizedHeight(cardWidth:CGFloat)->CGFloat{
        return 40
    }
}
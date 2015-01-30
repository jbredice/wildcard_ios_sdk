//
//  ArticleCard4x3FloatRightImageTextWrapVisualSource.swift
//  WildcardSDKProject
//
//  Created by David Xiang on 1/18/15.
//
//

import Foundation

@objc
public class ArticleCardSmallImageVisualSource : BaseVisualSource
{
    var header:FullCardHeader
    var body:ImageFloatRightBody
    var footer:ReadMoreFooter
    
    public override init(card:Card){
        self.header = UIView.loadFromNibNamed("FullCardHeader") as FullCardHeader
        self.header.hairline.hidden = true
        self.body = UIView.loadFromNibNamed("ImageFloatRightBody") as ImageFloatRightBody
        self.body.contentEdgeInset = UIEdgeInsetsMake(5, 15, 0, 15)
        self.footer = ReadMoreFooter(frame:CGRectZero)
        self.footer.readMoreButtonOffset = UIOffsetMake(15, 0)
        super.init(card: card)
    }
    
    public func viewForCardHeader()->CardViewElement?{
        return header
    }
    
    public func heightForCardHeader()->CGFloat{
        return header.optimizedHeight(widthForCard())
    }
    
    public override func viewForCardBody()->CardViewElement{
        return body
    }
    
    public override func heightForCardBody()->CGFloat{
        return body.optimizedHeight(widthForCard())
    }
    
    public func viewForCardFooter() -> CardViewElement? {
        return footer
    }
    
    public func heightForCardFooter() -> CGFloat {
        return 60
    }
}
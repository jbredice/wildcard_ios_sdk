//
//  VideoCardShortVisualSource.swift
//  WildcardSDKProject
//
//  Created by David Xiang on 3/9/15.
//
//

import Foundation

@objc
public class VideoCardShortImageSource : BaseVisualSource, CardViewVisualSource{
    
    var header:FullCardHeader!
    var body:SingleParagraphCardBody!
    var footer:ViewOnWebCardFooter!
    
    public func viewForCardHeader()->CardViewElement?{
        if(header == nil){
            header = CardViewElementFactory.createCardViewElement(WCElementType.FullHeader) as FullCardHeader
            header.hairline.hidden = true
            header.logo.hidden = true
            header.contentEdgeInset = UIEdgeInsetsMake(10, 15, 10, 15)
        }
        return header
    }
    
    public func viewForCardBody()->CardViewElement{
        if(body == nil){
            body = CardViewElementFactory.createCardViewElement(WCElementType.SimpleParagraph) as SingleParagraphCardBody
            body.contentEdgeInset = UIEdgeInsetsMake(0, 15, 5, 15)
        }
        return body;
    }
    
    public func viewForCardFooter()->CardViewElement?{
        if(footer == nil){
            footer = CardViewElementFactory.createCardViewElement(WCElementType.ViewOnWebFooter) as ViewOnWebCardFooter
            footer.hairline.hidden = true
        }
        return footer
    }
}
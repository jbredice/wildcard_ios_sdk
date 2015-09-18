//
//  MaximizedArticleDataSource.swift
//  WildcardSDKProject
//
//  Created by David Xiang on 12/18/14.
//
//

import Foundation

@objc
public class MaximizedArticleVisualSource : NSObject, MaximizedCardViewVisualSource {
    
    var card:Card
    var body:MediaTextFullWebView!
    
    public init(card:Card){
        self.card = card
    }
    
    public func applicationFrameEdgeInsets() -> UIEdgeInsets {
        return UIEdgeInsetsMake(10, 10, 10, 10)
    }
    
    public func viewForCardBody()->CardViewElement{
        if(body == nil){
            body = CardViewElementFactory.createCardViewElement(WCElementType.MediaTextFullWebView) as! MediaTextFullWebView
        }
        return body
    }
}
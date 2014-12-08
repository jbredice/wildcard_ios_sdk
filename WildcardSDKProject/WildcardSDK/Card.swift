//
//  Card.swift
//  WildcardSDKProject
//
//  Created by David Xiang on 12/3/14.
//
//

import Foundation

@objc
public class Card {
    
    enum Type{
        case Unknown
        case Article
        case WebLink
    }
    
    let webUrl:NSURL
    let cardType:String
    let type:Type
    
    init(webUrl:NSURL, cardType:String){
        self.webUrl = webUrl
        self.cardType = cardType
        
        if(cardType == "weblink"){
            type = Type.WebLink
        }else if(cardType == "article"){
            type = Type.Article
        }else{
            type = Type.Unknown
        }
    }
}
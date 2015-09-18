//
//  NSURLExtensions.swift
//  WildcardSDKProject
//
//  Created by David Xiang on 4/23/15.
//
//

import Foundation

public extension NSURL{
    
    func isTwitterProfileURL()->Bool{
        let pattern = "^http(s)://(www.)?twitter.com/(\\w*)\\/?$"
        let regex = try? NSRegularExpression(pattern: pattern, options: NSRegularExpressionOptions.CaseInsensitive)
        let length:Int = absoluteString.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)
        let ytMatch = regex?.firstMatchInString(absoluteString, options: NSMatchingOptions(), range: NSMakeRange(0, length))
        if(ytMatch != nil){
            return true
        }else{
            return false
        }
    }
    
    func isTwitterTweetURL()->Bool{        
        let pattern = "^http(s)://(www.)?twitter.com/(\\w*)/status/(\\d*)\\/?$"
        let regex = try? NSRegularExpression(pattern: pattern, options: NSRegularExpressionOptions.CaseInsensitive)
        let length:Int = absoluteString.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)
        let ytMatch = regex?.firstMatchInString(absoluteString, options: NSMatchingOptions(), range: NSMakeRange(0, length))
        if(ytMatch != nil){
            return true
        }else{
            return false
        }
    }
}
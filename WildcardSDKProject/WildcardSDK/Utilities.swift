//
//  Utilities.swift
//  WildcardSDKProject
//
//  Created by David Xiang on 12/8/14.
//
//

import Foundation

/// Public Bag of Tricks
public class Utilities{
    
    // MARK: Public
    
    /// Prints the font families available
    class func printFontFamilies(){
        for name in UIFont.familyNames()
        {
            if let nameString = name as? String{
                let names = UIFont.fontNamesForFamilyName(nameString)
                println(nameString)
                println(names)
            }
        }
    }
    
    /// Get the height required for a specific text string, with a max height
    public class func heightRequiredForText(text:String, lineHeight:CGFloat, font:UIFont, width:CGFloat, maxHeight:CGFloat)->CGFloat{
        let nsStr = NSString(string: text)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = lineHeight
        paragraphStyle.maximumLineHeight = lineHeight
        
        var attributesDictionary:[NSObject:AnyObject] =
        [NSParagraphStyleAttributeName: paragraphStyle,
            NSFontAttributeName:font]
        
        let bounds =
        nsStr.boundingRectWithSize(CGSizeMake(width,
            maxHeight),
            options: NSStringDrawingOptions.UsesLineFragmentOrigin,
            attributes: attributesDictionary,
            context: nil)
        return bounds.size.height;
    }
    
    /// Get the height required for a specific text string with unbounded height
    public class func heightRequiredForText(text:String, lineHeight:CGFloat, font:UIFont, width:CGFloat)->CGFloat{
        return Utilities.heightRequiredForText(text, lineHeight: lineHeight, font: font, width: width, maxHeight: CGFloat.max)
    }
    
    // Returns a CGSize from a visual source
    public class func sizeFromVisualSource(visualSource:CardViewVisualSource)->CGSize{
        let width = visualSource.widthForCard()
        var height:CGFloat = 0
        if let headerHeight = visualSource.heightForCardHeader?(){
            height += headerHeight
        }
        if let footerHeight = visualSource.heightForCardFooter?(){
            height += footerHeight
        }
        height += visualSource.heightForCardBody()
        return CGSizeMake(width, height)
    }
    
    // MARK: Private
    
    /**
    Verifies the integrity of the maximize visual size
    */
    class func validateMaximizeVisualSource(visualSource:MaximizedCardViewVisualSource)->Bool{
        let appFrame = UIScreen.mainScreen().applicationFrame
        let insets = visualSource.applicationFrameEdgeInsets()
        let size = sizeFromVisualSource(visualSource)
        var valid = true
        
        let appFrameWidth = appFrame.width - insets.left - insets.right
        let appFrameHeight = appFrame.height - insets.top - insets.bottom
        
        if(appFrameWidth != size.width){
            println("The card width \(size.width) should equal width relative to app frame \(appFrameWidth)")
            valid = false
        }
        if(appFrameHeight != size.height){
            println("The card height \(size.height) should equal height relative to app frame \(appFrameHeight)")
            valid = false
        }
        return valid
    }
    
}
//
//  ModalMaximizedCardViewController.swift
//  WildcardSDKProject
//
//  Created by David Xiang on 12/18/14.
//
//

import UIKit
import StoreKit

class StockMaximizedCardViewController: UIViewController, CardPhysicsDelegate, CardViewDelegate,UIViewControllerTransitioningDelegate, SKStoreProductViewControllerDelegate {
    
    var presentingControllerBackgroundView:UIView?
    var blurredOverlayView:UIView?
    var previousCardView:CardView!
    var cardView:CardView?
    var maximizedCard:Card!
    var maximizedCardDataSource:CardViewVisualSource!
    
    var cardDataSource:CardViewVisualSource!
    var cardViewTopConstraint:NSLayoutConstraint?
    var cardViewBottomConstraint:NSLayoutConstraint?
    var cardViewLeftConstraint:NSLayoutConstraint?
    var cardViewRightConstraint:NSLayoutConstraint?
    
    var initialCardFrame:CGRect!
    var initialCardVisualSource:CardViewVisualSource!
    var finishedLoadAnimation = false
    
    func cardViewRequestedAction(cardView: CardView, action: CardViewAction) {
        if(action.type == .Collapse){
            presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
        }else if(action.type == .DownloadApp){
            if let actionParams = action.parameters{
                let id = actionParams["id"] as NSString
                var parameters = NSMutableDictionary()
                parameters[SKStoreProductParameterITunesItemIdentifier] = id.integerValue
                
                var storeController = SKStoreProductViewController()
                storeController.delegate = self
                UIApplication.sharedApplication().networkActivityIndicatorVisible = true
                storeController.loadProductWithParameters(parameters, completionBlock: { (bool:Bool, error:NSError!) -> Void in
                    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                    self.presentViewController(storeController, animated: true, completion: nil)
                    return
                })
            }
        }
    }
 
    // MARK: CardPhysicsDelegate
    func cardViewDropped(cardView: CardView, position: CGPoint) {
        cardView.physics?.panGestureReset()
    }
    
    // MARK:UIViewController
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardView = CardView.createCardView(maximizedCard, visualSource: initialCardVisualSource)
        cardView?.delegate = self
        cardView!.frame = initialCardFrame
        
        view.addSubview(cardView!)
        
        //initiailize constraints
        cardViewLeftConstraint = cardView?.constrainLeftToSuperView(initialCardFrame.origin.x)
        cardViewTopConstraint = cardView?.constrainTopToSuperView(initialCardFrame.origin.y)
        cardViewRightConstraint = cardView?.constrainRightToSuperView(view.frame.size.width - initialCardFrame.origin.x - initialCardFrame.size.width)
        cardViewBottomConstraint = cardView?.constrainBottomToSuperView(view.frame.size.height - initialCardFrame.origin.y - initialCardFrame.size.height)
        view.addConstraint(cardViewLeftConstraint!)
        view.addConstraint(cardViewTopConstraint!)
        view.addConstraint(cardViewRightConstraint!)
        view.addConstraint(cardViewBottomConstraint!)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if(!finishedLoadAnimation){
            cardView?.fadeOut(0.2, delay: 0, completion: { (bool) -> Void in
                self.cardView?.reloadWithCard(self.maximizedCard, visualSource: self.maximizedCardDataSource)
                self.cardView?.header?.alpha = 0
                self.cardView?.footer?.alpha = 0
                self.cardView?.body?.alpha = 0
            })
        }
    }

    func cardViewWillReload(cardView: CardView) {
    }
    
    func cardViewDidReload(cardView: CardView) {
    }
    
 
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if(!finishedLoadAnimation){
            self.cardView?.fadeIn(0.2, delay: 0, completion: nil)
            finishedLoadAnimation = true
        }
    }
    
    // MARK: SKStoreProductViewControllerDelegate
    func productViewControllerDidFinish(viewController: SKStoreProductViewController!) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: UIViewControllerTransitioningDelegate
    func presentationControllerForPresentedViewController(presented: UIViewController!, presentingViewController presenting: UIViewController!, sourceViewController source: UIViewController!) -> UIPresentationController! {
        
        if presented == self {
            let presentationController = StockMaximizedCardPresentationController(presentedViewController: presented, presentingViewController: presenting)
            presentationController.presentingCardView = previousCardView
            return presentationController
        }else{
            return nil
        }
    }
    
    func animationControllerForPresentedController(presented: UIViewController!, presentingController presenting: UIViewController!, sourceController source: UIViewController!) -> UIViewControllerAnimatedTransitioning! {
        
        if presented == self {
            return StockMaximizedCardAnimationController(isPresenting: true)
        }else {
            return nil
        }
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController!) -> UIViewControllerAnimatedTransitioning! {
        
        if dismissed == self {
            return StockMaximizedCardAnimationController(isPresenting: false)
        }else {
            return nil
        }
    }
}

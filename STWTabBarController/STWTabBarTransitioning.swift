//
//  STWTabBarTransitioning.swift
//  STWTabBarController
//
//  Created by Steewe MacBook Pro on 26/02/18.
//  Copyright © 2018 Steewe MacBook Pro. All rights reserved.
//

import Foundation
import UIKit

class STWTabBarTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
    
    private weak var tabBarController:STWTabBarController!
    
    //MARK: - INIT
    
    convenience init(tabBarController:STWTabBarController) {
        self.init()
        self.tabBarController = tabBarController
    }
    
    //MARK: - UIViewControllerAnimatedTransitioning
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) else { return }
        guard let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) else { return }
        
        transitionContext.containerView.addSubview(fromViewController.view)
        transitionContext.containerView.addSubview(toViewController.view)
        
        var moltiplicator:CGFloat = 0
        
        if let index = tabBarController.viewControllers?.index(of: fromViewController) {
            moltiplicator = (index < tabBarController.selectedIndex) ? 1 : -1
        }
        
        toViewController.view.frame = toViewController.view.frame.offsetBy(dx: toViewController.view.frame.width * moltiplicator, dy: 0)
        let fromNewFrame = fromViewController.view.frame.offsetBy(dx: -(fromViewController.view.frame.width * moltiplicator), dy: 0)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: { () -> Void in
            
            toViewController.view.frame = fromViewController.view.frame
            fromViewController.view.frame = fromNewFrame
            
            self.tabBarController.updateOffsetSlider()
            
        }) { (finished) -> Void in
          
            if transitionContext.transitionWasCancelled { self.tabBarController.updateOffsetSlider(self.tabBarController.selectedIndex - Int(moltiplicator)) }
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)

        }
    }
}

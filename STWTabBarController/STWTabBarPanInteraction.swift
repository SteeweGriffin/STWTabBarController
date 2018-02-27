//
//  STWTabBarPanInteraction.swift
//  STWTabBarController
//
//  Created by Steewe MacBook Pro on 26/02/18.
//  Copyright © 2018 Steewe MacBook Pro. All rights reserved.
//

import Foundation
import UIKit

class STWTabBarPanInteraction: UIPercentDrivenInteractiveTransition {
    
    private var interactionInProgress = false {
        didSet{ isIntercationInProgress = interactionInProgress }
    }
    
    private var startIndex = 0
    private var shouldCompleteTransition = false
    
    private weak var tabBarController: STWTabBarController!
    
    public private(set) var isIntercationInProgress: Bool = false
    
    //MARK: - INIT
    
    init(tabBarController: STWTabBarController) {
        
        super.init()
        
        self.tabBarController = tabBarController
        startIndex = self.tabBarController.selectedIndex
        completionSpeed = 0.999
        self.preparePanGesture()
    }
    
    //MARK: - PTIVATE
    
    private func preparePanGesture() {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(handleGesture(_:)))
        tabBarController.view.addGestureRecognizer(gesture)
    }
    
    @objc private func handleGesture(_ gestureRecognizer: UIScreenEdgePanGestureRecognizer) {
        
        let translation = gestureRecognizer.translation(in: gestureRecognizer.view!.superview!)
        
        let velocity = gestureRecognizer.velocity(in: gestureRecognizer.view!)
        
        let rightToLeft = velocity.x < 0
        
        var progress = (translation.x / tabBarController.selectedViewController!.view.frame.width)
        
        
        if tabBarController.selectedIndex > startIndex {
            progress = (translation.x < 0) ? abs(progress) : 0
        }
        
        progress = CGFloat(fminf(fmaxf(Float(progress), 0.0), 1.0))
        
        switch gestureRecognizer.state {
            
        case .began:
            
            startIndex = tabBarController.selectedIndex
            interactionInProgress = true
            
            if (rightToLeft) {
                self.tabBarController.selectedIndex = startIndex + 1
            } else {
                self.tabBarController.selectedIndex = startIndex - 1
            }
            
        case .changed:
            
            if (self.interactionInProgress) {
                shouldCompleteTransition = progress > 0.3
                update(progress)
            }
            
        case .cancelled:
            interactionInProgress = false
            cancel()
            
        case .ended:
            interactionInProgress = false
            if shouldCompleteTransition { finish() } else { cancel() }
            
        default:
            break
        }
    }
}


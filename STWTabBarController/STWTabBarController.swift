//
//  STWTabBarController.swift
//  STWTabBarController
//
//  Created by Steewe MacBook Pro on 26/02/18.
//  Copyright © 2018 Steewe MacBook Pro. All rights reserved.
//

import UIKit

public class STWTabBarController: UITabBarController {
    
    private var interactive:STWTabBarPanInteraction?
    private var transationing:STWTabBarTransitioning?
    
    private var slider:UIView?
    
    private var offsetSliderConstraint:NSLayoutConstraint?
    private var widthSliderConstraint:NSLayoutConstraint?
    private var heightSliderConstraint:NSLayoutConstraint?
    
    private var items:[UIView] = [UIView]()
    private var itemWidth:CGFloat = 0
    
    private var tabNumber:CGFloat = 0 {
        didSet { self.updateSliderApparence() }
    }
    
    /// Indicator Color
    /// - default: UITabBar.tintColor
    
    public var sliderColor:UIColor = .clear {
        didSet { self.updateSliderApparence() }
    }
    
    /// Indicator is visible
    /// - default: true
    
    public var showIndicator:Bool = true {
        didSet{ self.updateSliderApparence() }
    }
    
    /// Indicator Height
    /// - default: 2
    
    public var sliderHeight:CGFloat = 2 {
        didSet{ self.updateSliderApparence() }
    }

    //MARK: - LIFE CYCLE
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        sliderColor = tabBar.tintColor
        interactive = STWTabBarPanInteraction(tabBarController: self)
        transationing = STWTabBarTransitioning(tabBarController: self)
        
        createSlider()
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override public func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.updateSliderApparence()
        DispatchQueue.main.async { self.updateOffsetSlider() }
    }
    
    override public func setViewControllers(_ viewControllers: [UIViewController]?, animated: Bool) {
        super.setViewControllers(viewControllers, animated: animated)
        items = tabBar.subviews.filter( { $0.isUserInteractionEnabled } )
        tabNumber = (viewControllers != nil) ? CGFloat(viewControllers!.count) : 0
    }
    
    //MARK: - PRIVATE
    
    private func createSlider() {
        
        slider = UIView()
        slider?.isUserInteractionEnabled = false
        slider?.translatesAutoresizingMaskIntoConstraints = false
        
        tabBar.addSubview(slider!)
    }
    
    private func updateSliderApparence() {
        
        itemWidth = tabBar.frame.size.width / tabNumber
        
        slider?.isHidden = !showIndicator
        slider?.backgroundColor = sliderColor
        
     
        slider?.topAnchor.constraint(equalTo: tabBar.topAnchor, constant: 0).isActive = true
        
        heightSliderConstraint?.isActive = false
        heightSliderConstraint = slider?.heightAnchor.constraint(equalToConstant: sliderHeight)
        heightSliderConstraint?.isActive = true
        
        widthSliderConstraint?.isActive = false
        widthSliderConstraint = slider?.widthAnchor.constraint(equalToConstant: itemWidth)
        widthSliderConstraint?.isActive = true
        
        offsetSliderConstraint?.isActive = false
        offsetSliderConstraint = slider?.leftAnchor.constraint(equalTo: tabBar.leftAnchor, constant: items[self.selectedIndex].center.x - (itemWidth/2))
        offsetSliderConstraint?.isActive = true
    }
    
    //MARK: - PUBLIC
    
    public func updateOffsetSlider(_ forcedAt:Int? = nil) {
        
        self.widthSliderConstraint?.constant = self.itemWidth
        self.offsetSliderConstraint?.constant = self.items[forcedAt ?? self.selectedIndex].center.x - (self.itemWidth/2)
        self.tabBar.layoutIfNeeded()
    }
}

//MARK: - UITabBarControllerDelegate

extension STWTabBarController: UITabBarControllerDelegate {
    
    public func tabBarController(_ tabBarController: UITabBarController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactive?.isIntercationInProgress ?? false ? interactive : nil
    }
    
    public func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return transationing
    }
    
}


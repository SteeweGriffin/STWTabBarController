//
//  ViewController.swift
//  testCustomTabBarController
//
//  Created by Steewe MacBook Pro on 26/02/18.
//  Copyright © 2018 Steewe MacBook Pro. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private let label = UILabel()
    
    override var title: String? {
        didSet{ label.text = title }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        label.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(label)
        
        label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}

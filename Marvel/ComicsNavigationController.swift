//
//  ComicsNavigationController.swift
//  Marvel
//
//  Created by Abhishek on 11/10/23.
//

import UIKit
class ComicsNavigationController: UINavigationController, UIGestureRecognizerDelegate{
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        interactivePopGestureRecognizer?.delegate = self
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}

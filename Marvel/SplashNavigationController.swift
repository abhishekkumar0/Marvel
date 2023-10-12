//
//  SplashNavigationController.swift
//  Marvel
//
//  Created by Abhishek on 08/10/23.
//
import UIKit
class SplashViewNavigationController: UINavigationController, UIGestureRecognizerDelegate{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        interactivePopGestureRecognizer?.delegate = self
        self.setNavigationBarHidden(true, animated: false)
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }

}

//
//  TabBarController.swift
//  Marvel
//
//  Created by Abhishek on 09/10/23.
//

import UIKit
class TabBarController: UITabBarController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpTabs()
    }
    
    private func setUpTabs(){
        let homeViewController = createNav(with: "Characters", and: UIImage(named: "Component 1"), vc: HomeViewController())
        let cominViewController = createNav(with: "Comic", and: UIImage(named: "Group"), vc: ComicsViewController())
        self.setViewControllers([homeViewController, cominViewController], animated: true)
    }
    
    private func createNav(with title: String, and image: UIImage?, vc: UIViewController) -> UINavigationController{
        let nvc = UINavigationController(rootViewController: vc)
        nvc.tabBarItem.title = title
        nvc.tabBarItem.image = image
        return nvc
    }
    
    
}

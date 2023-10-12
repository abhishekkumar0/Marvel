//
//  SplashViewController.swift
//  Marvel
//
//  Created by Abhishek on 08/10/23.
//

import UIKit
class SplashViewController: UIViewController{
    
    lazy private var logo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Marvel-Logo")
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
            sceneDelegate?.setOnWindow(vc: TabBarController())
        })
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}

extension SplashViewController{
    
    private func configureView(){
        self.view.backgroundColor = UIColor.colorFromHexString("ED1B24")
        self.addSubviews()
        self.setUpConstraints()
    }
    
    private func addSubviews(){
        self.view.addSubviews([logo])
        logo.frame = view.frame
    }
    
    private func setUpConstraints(){
    }
    
    
}

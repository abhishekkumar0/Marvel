//
//  UIViewControllerExtension.swift
//  Marvel
//
//  Created by Abhishek on 12/10/23.
//

import UIKit
extension UIViewController{
    
    public func openCharactersByNameViewController(nameStartingWith: String){
        let vc = CharactersByNameViewController(nameStartWith: nameStartingWith)
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
}


extension UIViewController{
    
    private static let alphaViewTag = 3948943849
    func showAlphaView(){
        DispatchQueue.main.async {
            let view = AlphaView()
            view.frame = self.view.frame
            view.tag = UIViewController.alphaViewTag
            self.view.addSubview(view)
            view.showView()
        }
    }
    
    func hideAlphaView(){
        DispatchQueue.main.async {
            if let alphaView = self.view.subviews.first(where: { $0.tag == UIViewController.alphaViewTag }) as? AlphaView{
                alphaView.hideView {[weak self] (success) in
                    guard let _ = self else {return}
                    alphaView.removeFromSuperview()
                }
            }
                
        }
    }
    
}

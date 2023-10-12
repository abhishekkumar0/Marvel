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

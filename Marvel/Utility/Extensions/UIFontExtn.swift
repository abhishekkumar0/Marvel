//
//  UIFont.swift
//  Marvel
//
//  Created by Abhishek on 09/10/23.
//

import UIKit

extension UIFont {

    public enum FontFamily: String{
        case Poppins
    }

    public enum FontFace: String{
        case Medium
        case Bold
        case Light
        case Regular
        case SemiBold
        case Black
        case ExtraBold
    }
    
    public class func fontWith(name: FontFamily, fontFace: FontFace , size: CGFloat) -> UIFont {
        UIFont.init(name: "\(name.rawValue)-\(fontFace.rawValue)", size: size)!
    }
}

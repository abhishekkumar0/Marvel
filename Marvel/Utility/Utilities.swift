//
//  Utility.swift
//  Marvel
//
//  Created by Abhishek on 11/10/23.
//

import UIKit
class Utilities: NSObject {
    class func attributedText(text: String, font: UIFont, color: UIColor) -> NSMutableAttributedString {
        let attrString = NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: color,
                                                                              NSAttributedString.Key.font: font])
        return attrString
    }
}

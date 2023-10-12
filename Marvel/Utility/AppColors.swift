//
//  AppColors.swift
//  Marvel
//
//  Created by Abhishek on 08/10/23.
//

import UIKit

let darkBlue = UIColor(red: 0/255, green: 107/255, blue: 180/255, alpha: 1.0) //006bb4
let lightBlue = UIColor(red: 0/255, green: 160/255, blue: 255/255, alpha: 1.0) //00a0ff


class AppColor{
    static let shared = AppColor()
    
    private init(){}
    
    let primaryColor = UIColor.colorFromHexString("212121")
    let buttonDisabledColor = UIColor.colorFromHexString("D0DBE4")
    let primaryFontColor = UIColor.colorFromHexString("3E4452")
    let secondaryFontColor = UIColor.colorFromHexString("9FAFBC")
    let borderColor = UIColor.colorFromHexString("E3E8EC")
    let backgroundColor = UIColor.colorFromHexString("F5F6FA")
}

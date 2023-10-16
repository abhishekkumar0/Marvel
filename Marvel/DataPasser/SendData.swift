//
//  SendData.swift
//  Marvel
//
//  Created by Abhishek on 11/10/23.
//

import Foundation
protocol SendData: AnyObject {
    func passData(dataPasser: Any, data: Any)
}

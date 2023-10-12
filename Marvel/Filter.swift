//
//  Filter.swift
//  Marvel
//
//  Created by Abhishek on 11/10/23.
//

import Foundation
struct Filter{
    var label: String
    var dateDescriptor: ComicsDateDescriptor
}

enum ComicsDateDescriptor: String{
    case lastWeek
    case thisWeek
    case nextWeek
    case thisMonth
}

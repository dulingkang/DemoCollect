//
//  Extention.swift
//  DemoCollect
//
//  Created by dulingkang on 16/3/16.
//  Copyright © 2016年 com.shawn. All rights reserved.
//

import Foundation

extension NSObject {
    var theClassName: String {
        return NSStringFromClass(self.dynamicType).componentsSeparatedByString(".").last!
    }
}
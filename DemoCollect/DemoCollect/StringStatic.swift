//
//  StringStatic.swift
//  DemoCollect
//
//  Created by ShawnDu on 16/7/12.
//  Copyright © 2016年 com.shawn. All rights reserved.
//

import UIKit

class StringUtil {
    static func test() {
        print("my string util");
    }
}

class StringStatic: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(StringStatic.viewTapped))
        self.view.addGestureRecognizer(tap)
//        test()
        
        // Do any additional setup after loading the view.
    }

    func viewTapped() {
//        let string = "StringUtil"
//        let className = "DemoCollect" + "." + string
//        let selectorName = "test"
//        let currentClass = NSClassFromString(className)! as NSObject.Type
//        let selector: Selector = Selector(selectorName)
//        if currentClass.respondsToSelector(selector) {
//            currentClass.performSelector(selector)
//        }
    }
    
    func test() {
        if let cls = NSClassFromString("StringUtil") as? AnyClass.Type {
            print(class_isMetaClass(cls))
        }
    }
}

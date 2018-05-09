//
//  StringStatic.swift
//  DemoCollect
//
//  Created by ShawnDu on 16/7/12.
//  Copyright © 2016年 com.shawn. All rights reserved.
//

import UIKit

class Car {
    let make: String
    
    required init(make: String) {
        self.make = make
    }
    
    var description: String {
        return "\(make) is a \(type(of: self))."
    }
}

class myLitterCar: Car {
    
}

class StringStatic: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(StringStatic.viewTapped))
        self.view.addGestureRecognizer(tap)
//        test()
        
        // Do any additional setup after loading the view.
    }

    func viewTapped() {
        let string = "Car"
        let className = "DemoCollect" + "." + string
//        let selectorName = "test"
        if let currentClass = NSClassFromString(className) as? Car.Type {
            let car = currentClass.init(make: "FirstCar")
            car.description
        }
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

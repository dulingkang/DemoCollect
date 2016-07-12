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
        
        
        // Do any additional setup after loading the view.
    }

    func viewTapped() {
        let string = "StringUtil"
        let className = "DemoCollect" + "." + string
        let selectorName = "test"
        let currentClass = NSClassFromString(className)! as AnyClass
        let selector: Selector = Selector(selectorName)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

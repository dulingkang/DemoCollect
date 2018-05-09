//
//  AppConfig.swift
//  AspectsDemo
//
//  Created by dulingkang on 16/3/4.
//  Copyright © 2016年 com.shawn. All rights reserved.
//

import UIKit
//import Aspects

//struct AppConfig {
//    static func SSViewControllerConfig() {
//        let wrappedBlock:@convention(block) (AspectInfo)-> Void = { aspectInfo in
//            let instance = aspectInfo.instance() as? UIViewController
//            instance?.SSViewDidLoad()
//            }
//        let wrappedObject: AnyObject = unsafeBitCast(wrappedBlock, to: AnyObject.self)
//        do {
//            try UIViewController.aspect_hook(#selector(UIViewController.viewDidLoad), with: AspectOptions(), usingBlock: wrappedObject)
//        } catch {
//            print(error)
//        }
//    }
//}
//
//extension UIViewController {    
//    func SSViewDidLoad() {
//        self.navigationController?.navigationBar.isTranslucent = true
//        print("SSViewDidLoad")
////        self.view.backgroundColor = UIColor.greenColor()
//        self.navigationController?.title = self.theClassName
//        if self.responds(to: #selector(getter: UIViewController.edgesForExtendedLayout)) {
//            self.edgesForExtendedLayout = UIRectEdge()
//        }
//    }
//}







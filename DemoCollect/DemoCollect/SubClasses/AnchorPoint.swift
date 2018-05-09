//
//  AnchorPoint.swift
//  DemoCollect
//
//  Created by dulingkang on 16/3/15.
//  Copyright © 2016年 com.shawn. All rights reserved.
//

import UIKit

class AnchorPoint: UIViewController {

    let point1 = CGPoint(x: kScreenWidth/2, y: kScreenWidth/2)
    //MARK: - life cycle
    override func viewDidLoad() {
        view.backgroundColor = UIColor.white
        addSublayer()
        addViewAtPoint(point1)
    }
    
    
    //MARK: - private method
    fileprivate func addSublayer() {
        let layer = CALayer()
        layer.bounds = CGRect(x: 0, y: 0, width: kScreenWidth/2, height: kScreenWidth/2)
        layer.borderColor = UIColor.red.cgColor
        layer.borderWidth = 1
        layer.position = point1
        layer.anchorPoint = CGPoint(x: 0, y: 0.5)
        view.layer.addSublayer(layer)
    }
    
    fileprivate func addViewAtPoint(_ point: CGPoint) {
        let pointView = UIView.init(frame: CGRect(x: point.x - 3, y: point.y - 3, width: 6, height: 6))
        pointView.backgroundColor = UIColor.blue
        pointView.layer.cornerRadius = 3
        view.addSubview(pointView)
    }
}

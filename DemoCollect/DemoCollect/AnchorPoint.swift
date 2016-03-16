//
//  AnchorPoint.swift
//  DemoCollect
//
//  Created by dulingkang on 16/3/15.
//  Copyright © 2016年 com.shawn. All rights reserved.
//

import UIKit

class AnchorPoint: UIViewController {

    let point1 = CGPointMake(kScreenWidth/2, kScreenWidth/2)
    //MARK: - life cycle
    override func viewDidLoad() {
        view.backgroundColor = UIColor.whiteColor()
        addSublayer()
        addViewAtPoint(point1)
    }
    
    
    //MARK: - private method
    private func addSublayer() {
        let layer = CALayer()
        layer.bounds = CGRectMake(0, 0, kScreenWidth/2, kScreenWidth/2)
        layer.borderColor = UIColor.redColor().CGColor
        layer.borderWidth = 1
        layer.position = point1
        layer.anchorPoint = CGPointMake(0, 0.5)
        view.layer.addSublayer(layer)
    }
    
    private func addViewAtPoint(point: CGPoint) {
        let pointView = UIView.init(frame: CGRectMake(point.x - 3, point.y - 3, 6, 6))
        pointView.backgroundColor = UIColor.blueColor()
        pointView.layer.cornerRadius = 3
        view.addSubview(pointView)
    }
}

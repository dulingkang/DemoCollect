//
//  PathAnimation.swift
//  DemoCollect
//
//  Created by dulingkang on 2018/5/3.
//  Copyright © 2018年 com.shawn. All rights reserved.
//

import UIKit
import CoreGraphics

extension Selector {
  static let start = #selector(PathAnimation.startAnimation)
}

class PathAnimation: UIViewController {
  struct Layout {
    static let radius = kScreenWidth/2
  }
  
  lazy var pandaImageView: UIImageView = {
    return UIImageView(image: UIImage(named: "panda"))
  }()
  
  lazy var startButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("start", for: .normal)
    button.frame = CGRect(x: (kScreenWidth - 60)/2, y: 80, width: 60, height: 30)
    button.addTarget(self, action: .start, for: .touchUpInside)
    return button
  }()
  
  lazy var pointA: CALayer = {
    let layer = CALayer()
    layer.frame = CGRect(x: Layout.radius - 5, y: kScreenHeight/2 - 5, width: 10, height: 10)
    layer.backgroundColor = UIColor.red.cgColor
    layer.cornerRadius = 5
    return layer
  }()
  
  lazy var pointB: CALayer = {
    let layer = CALayer()
    layer.frame = CGRect(x: kScreenWidth - 5, y: kScreenHeight/2 - 5, width: 10, height: 10)
    layer.backgroundColor = UIColor.green.cgColor
    layer.cornerRadius = 5
    return layer
  }()
  
  lazy var pointC: CALayer = {
    let layer = CALayer()
    layer.frame = CGRect(x: Layout.radius - 5, y: kScreenHeight/2 - Layout.radius - 5, width: 10, height: 10)
    layer.backgroundColor = UIColor.blue.cgColor
    layer.cornerRadius = 5
    return layer
  }()
  
  lazy var pointD: CALayer = {
    let layer = CALayer()
    layer.frame = CGRect(x: Layout.radius/2 - 5, y: kScreenHeight/2 - 5, width: 10, height: 10)
    layer.backgroundColor = UIColor.darkGray.cgColor
    layer.cornerRadius = 5
    return layer
  }()

  lazy var circle: CALayer = {
    let layer = CALayer()
    layer.frame = CGRect(x: 0, y: kScreenHeight/2 - Layout.radius, width:Layout.radius * 2 , height: Layout.radius * 2)
    layer.borderColor = UIColor.red.cgColor
    layer.borderWidth = 1
    layer.cornerRadius = Layout.radius
    return layer
  }()
  
  let transform = CGAffineTransform(translationX: kScreenWidth/2, y: kScreenHeight/2)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    view.addSubview(pandaImageView)
    view.addSubview(startButton)
    view.layer.addSublayer(pointA)
    view.layer.addSublayer(pointB)
    view.layer.addSublayer(pointC)
    view.layer.addSublayer(pointD)
    view.layer.addSublayer(circle)
    pandaImageView.transform = transform
    pandaImageView.layer.position = CGPoint(x: 0, y: 0)
  }
  
  func lineAnimation() {
    let animation = CABasicAnimation()
    animation.keyPath = "position.x";
    animation.fromValue = 0;
    animation.toValue = Layout.radius;
    animation.duration = 1;
    pandaImageView.layer.add(animation, forKey: "line")
    pandaImageView.layer.position = CGPoint(x: Layout.radius, y: 0)
  }
  
  func roundAnimation() -> CAKeyframeAnimation{
    let keyframeAnimation = CAKeyframeAnimation(keyPath: "position")
    let path = CGMutablePath()
    let radius = kScreenWidth/2
    path.addLine(to: CGPoint(x: radius, y: 0))
    path.addArc(center: CGPoint(x: 0, y: 0), radius: radius, startAngle: 0, endAngle: 1.5 * .pi, clockwise: true)
    path.addLine(to: CGPoint(x: -radius/2, y: 0))
    path.addLine(to: CGPoint(x: 0, y: 0))
    keyframeAnimation.path = path
    keyframeAnimation.calculationMode = kCAAnimationPaced
    keyframeAnimation.duration = 2.0;
    return keyframeAnimation
  }
  
  func scaleAnimation() -> CAKeyframeAnimation{
    let keyframeAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
    keyframeAnimation.values = [1.2, 0.8, 1]
    keyframeAnimation.duration = 1.0;
    keyframeAnimation.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn), CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)]
    return keyframeAnimation
  }
  
  
  func startAnimation() {
    let roundAnimation = self.roundAnimation()
    let scaleAnimation = self.scaleAnimation()
    scaleAnimation.beginTime = roundAnimation.duration
    let groupAnimation = CAAnimationGroup()
    groupAnimation.animations = [roundAnimation, scaleAnimation]
    groupAnimation.duration = roundAnimation.duration + scaleAnimation.duration
    pandaImageView.layer.add(groupAnimation, forKey: "group")
    pandaImageView.layer.position = CGPoint(x: 0, y: 0)
  }
}

//
//  MainViewController.swift
//  DemoCollect
//
//  Created by dulingkang on 16/3/15.
//  Copyright © 2016年 com.shawn. All rights reserved.
//

import UIKit


class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var classes: [String] {
        get{
            return ["AnchorPoint",
                "NaviFrame",
                "StringStatic"
            ]
        }
    }
    
    //MARK: - life cycle
    override func viewDidLoad() {
        configViews()
    }
    
    //MARK: - tableView
    //MARK: dataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return classes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = "SSMainCell"
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier)
        if (cell == nil) {
            cell = UITableViewCell(style: .Default, reuseIdentifier: identifier)
        }
        cell?.textLabel?.text = classes[indexPath.row]
        return cell!
    }
    
    //MARK: delegte
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var className = classes[indexPath.row]
        className = "DemoCollect" + "." + className
        let currentClass = NSClassFromString(className) as! UIViewController.Type
        let destVC = currentClass.init()
        self.navigationController?.pushViewController(destVC, animated: true)
    }
    
    //MARK: - private method
    private func configViews() {
        let tableView = UITableView(frame: self.view.bounds, style: .Plain)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
    }
}

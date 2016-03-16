//
//  NaviFrame.swift
//  DemoCollect
//
//  Created by dulingkang on 16/3/16.
//  Copyright © 2016年 com.shawn. All rights reserved.
//

import UIKit

class NaviFrame: UIViewController, UITableViewDataSource {

    var nameArray: [String] {
        get {
            var array: [String] = []
            for i in 0...20 {
                array.append("Row\(i)")
            }
            return array
        }
    }
    
    //MARK: - life cycle
    override func viewDidLoad() {
        self.navigationController?.navigationBar.translucent = true
        view.backgroundColor = UIColor.whiteColor()
        addTableView()
    }
    
    //MARK: - tableView datasource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = "SSNaviFrameCell"
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier)
        if (cell == nil) {
            cell = UITableViewCell(style: .Default, reuseIdentifier: identifier)
        }
        cell?.textLabel?.text = nameArray[indexPath.row]
        cell?.contentView.backgroundColor = UIColor.blueColor()
        return cell!
    }
    
    //MARK: - private method
    private func addTableView() {
        let tableView = UITableView(frame: CGRectMake(0, 0, kScreenWidth, kScreenHeight), style: .Plain)
        tableView.layer.borderColor = UIColor.redColor().CGColor
        tableView.layer.borderWidth = 1
        tableView.dataSource = self
        view.addSubview(tableView)
    }
    
}

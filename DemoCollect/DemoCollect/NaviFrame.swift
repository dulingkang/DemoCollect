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
        self.navigationController?.navigationBar.isTranslucent = true
        view.backgroundColor = UIColor.white
        addTableView()
    }
    
    //MARK: - tableView datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "SSNaviFrameCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if (cell == nil) {
            cell = UITableViewCell(style: .default, reuseIdentifier: identifier)
        }
        cell?.textLabel?.text = nameArray[indexPath.row]
        cell?.contentView.backgroundColor = UIColor.blue
        return cell!
    }
    
    //MARK: - private method
    fileprivate func addTableView() {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight), style: .plain)
        tableView.layer.borderColor = UIColor.red.cgColor
        tableView.layer.borderWidth = 1
        tableView.dataSource = self
        view.addSubview(tableView)
    }
    
}

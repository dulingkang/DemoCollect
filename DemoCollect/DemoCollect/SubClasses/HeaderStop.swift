//
//  HeaderStop.swift
//  DemoCollect
//
//  Created by dulingkang on 2018/5/14.
//  Copyright © 2018年 com.shawn. All rights reserved.
//

import UIKit

class HeaderStopCell: UITableViewCell {
  var sortClosure: ((Int)-> Void)?
}

class TestView: UIView {
  var sortClosure: ((Int)-> Void)?
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = .green
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

class HeaderStop: UIViewController {
  var testInt: Int = 0
  var testView: TestView = TestView(frame: CGRect(x: 0, y: 0, width: 300, height: 400))
  lazy var tableView: UITableView = {
    let tableView = UITableView(frame: self.view.bounds, style: .plain)
    tableView.delegate = self
    tableView.dataSource = self
    return tableView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(tableView)
    view.addSubview(testView)
    testView.sortClosure = { [unowned self] sort in
      self.testInt = sort
    }
  }
  
  deinit {
    print("HeaderStop")
  }
  
  
}

extension HeaderStop: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 20
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = HeaderStopCell(style: .default, reuseIdentifier: "headerStopCell")
    cell.textLabel?.text = "\(indexPath.row)"
    cell.sortClosure = { sort in
//      self.testInt = sort
    }
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 20
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let label = UILabel(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 20))
    label.text = "\(section)"
    return label
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    testView.sortClosure?(indexPath.row)
  }
}
protocol Aaprotocol {
  
}

enum APIClientResult<T> {
  case success(T)
  case failure(String)
}
struct ApiClient {
  static func get<Model: Aaprotocol>(path: String, params:[String : AnyObject] = [:],completion: ((APIClientResult<Model>) ->Void)?) {
    completion?(.failure(""))
  }

}

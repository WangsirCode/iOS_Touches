//
//  ViewController.swift
//  Touches_test
//
//  Created by 汪宇豪 on 2016/10/31.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate{
    @IBOutlet weak var myview: BlueView!

    var tabbleView:UITableView {
        let tableview = UITableView(frame: self.view.frame,style:.plain)
        tableview.delegate = self
        tableview.dataSource = self
        return tableview
    }
    var model:Array<String>{
        return ["Restricting Touches"]
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //当UITapGestureRecognizer识别手势后，touchcancel会传给相关view,如果设置了tap.cancelsTouchesInView为false，则不会
//        let tap = UITapGestureRecognizer(target: self, action: "handletap")
//        tap.cancelsTouchesInView = false
//        self.myview .addGestureRecognizer(tap)

    }
    func handletap()
    {
        print("tap ")
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = self.model[indexPath.row]
        return cell
    }
    
}


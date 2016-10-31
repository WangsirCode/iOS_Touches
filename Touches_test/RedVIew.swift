//
//  TestView.swift
//  Touches_test
//
//  Created by 汪宇豪 on 2016/10/31.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

import UIKit
//event end 的时候是不是有通知
//为什么event的地址会不一样
//为什么touch和event的地址是一样的
class RedView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.red
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor.red
    }
    //当手指离开viewhou，view就结束了
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("redview touches begin")
        print("in this view ,we have \(touches.count) touches")
        print("touch type is \(touches.first!.type)" )
        print("fist touc is \(Unmanaged.passRetained(touches.first!).toOpaque())")
        print("the event is \(Unmanaged.passRetained(touches.first!).toOpaque())")
        print("in this event ,we have \(event?.allTouches!.count) touches")
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("redview touches move")
        print("in this view ,we have \(touches.count) touches")
        print("touch type is \(touches.first!.type)" )
        print("fist touc is \(Unmanaged.passRetained(touches.first!).toOpaque())")
        print("the event is \(Unmanaged.passRetained(touches.first!).toOpaque())")
        print("in this event ,we have \(event?.allTouches!.count) touches")
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("redview touches end")
        print("in this view ,we have \(touches.count) touches")
        print("touch type is \(touches.first!.type)" )
        print("fist touc is \(Unmanaged.passRetained(touches.first!).toOpaque())")
        print("the event is \(Unmanaged.passRetained(touches.first!).toOpaque())")
        print("in this event ,we have \(event?.allTouches!.count) touches")    }
}

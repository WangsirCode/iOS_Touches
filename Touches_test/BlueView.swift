//
//  BlueView.swift
//  Touches_test
//
//  Created by 汪宇豪 on 2016/10/31.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

import UIKit

class BlueView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.blue
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor.blue
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("blue touches begin")
        print("in this view ,we have \(touches.count) touches")
        print("touch type is \(touches.first!.type)" )
        print("fist touc is \(Unmanaged.passRetained(touches.first!).toOpaque())")
        print("the event is \(Unmanaged.passRetained(touches.first!).toOpaque())")
        print("in this event ,we have \(event?.allTouches?.count) touches")
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("blue touches move")
        print("in this view ,we have \(touches.count) touches")
        print("touch type is \(touches.first!.type)" )
        print("fist touc is \(Unmanaged.passRetained(touches.first!).toOpaque())")
        print("the event is \(Unmanaged.passRetained(touches.first!).toOpaque())")
        print("in this event ,we have \(event?.allTouches?.count) touches")
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("blue touches end")
        print("in this view ,we have \(touches.count) touches")
        print("touch type is \(touches.first!.type)" )
        print("fist touc is \(Unmanaged.passRetained(touches.first!).toOpaque())")
        print("the event is \(Unmanaged.passRetained(touches.first!).toOpaque())")
        print("in this event ,we have \(event?.allTouches?.count) touches")
    }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touches cancel")
    }
}

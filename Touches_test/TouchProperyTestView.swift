//
//  TouchProperyTestView.swift
//  Touches_test
//
//  Created by 汪宇豪 on 2016/10/31.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

import UIKit

class TouchProperyTestView: UIView {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        print("location is  \(touch.location(in: self))")
        print("preciseLocation is \(touch.previousLocation(in: self))")
        print("timestamp is \(touch.timestamp)")
        print("tapCount is \(touch.tapCount)")
        print("majorRadius is \(touch.majorRadius)")
        print("  ")
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        print("location is  \(touch.location(in: self))")
        print("preciseLocation is \(touch.previousLocation(in: self))")
        print("timestamp is \(touch.timestamp)")
        print("tapCount is \(touch.tapCount)")
        print("majorRadius is \(touch.majorRadius)")
        print("majorRadiusTolerance is \(touch.majorRadiusTolerance)")
        print("  ")
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        print("location is  \(touch.location(in: self))")
        print("preciseLocation is \(touch.previousLocation(in: self))")
        print("timestamp is \(touch.timestamp)")
        print("tapCount is \(touch.tapCount)")
        print("majorRadius is \(touch.majorRadius)")
        print("  ")
    }
}

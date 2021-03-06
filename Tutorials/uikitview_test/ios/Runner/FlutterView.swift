//
//  FlutterView.swift
//  Runner
//
//  Created by 근성가이 on 17/01/2019.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

import UIKit
import Flutter

public class FlutterView: NSObject, FlutterPlatformView {
    public func view() -> UIView {
        let tempView = TempView()
        return tempView
    }
}

public class FlutterViewFactory: NSObject, FlutterPlatformViewFactory {
    public func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
        return FlutterView()
    }
}

//Native UI를 구현하려면, FlutterPlatformView와 FlutterPlatformViewFactory 를 구현해야 한다.
//FlutterPlatformView로 일반 UIView처럼 구현하고, FlutterPlatformViewFactory로 Factory 패턴을 구현한다.

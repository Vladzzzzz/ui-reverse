//
//  AWindow.swift
//  ui-reverse
//
//  Created by Vlad Zaytsev on 13.02.2023.
//

import UIKit

public class AWindow: UIWindow {
    public private(set) var aSubviews: [AView] = []

    public func addASubview(_ view: AView) {
        layer.addSublayer(view.layer)
        aSubviews.append(view)
    }
}

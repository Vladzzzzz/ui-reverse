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

    public override func sendEvent(_ event: UIEvent) {
        guard
            event.type == .touches,
            let touches = event.allTouches,
            let touch = touches.first
        else {
            return
        }

        let hitView = aHitTest(touch.location(in: self), with: event)

        switch touch.phase {
        case .began:
            hitView?.touchesBegan(touches, with: event)
        case .ended:
            hitView?.touchesEnded(touches, with: event)
        case .cancelled:
            hitView?.touchesCancelled(touches, with: event)
        case .moved:
            hitView?.touchesMoved(touches, with: event)
        default:
            break
        }
    }

    // MARK: - HitTesting

    public func aHitTest(_ point: CGPoint, with event: UIEvent?) -> AView? {
        guard !isHidden, isUserInteractionEnabled, alpha >= 0.01 else {
            return nil
        }

        for subview in aSubviews.reversed() {
            if let hitView = subview.hitTest(subview.layer.convert(point, to: layer), with: event) {
                return hitView
            }
        }

        return nil
    }
}

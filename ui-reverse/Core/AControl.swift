//
//  AControl.swift
//  ui-reverse
//
//  Created by Vlad Zaytsev on 05.03.2023.
//

import UIKit

public class AControl: AView {
    public enum Event: Hashable { case touchUpInside, touchDown }
    public enum State { case normal, highlighted }

    public var state: State = .normal

    private var targets: [Event: [(target: Any?, action: Selector)]] =  [:]

    public func addTarget(_ target: Any?, action: Selector, for event: AControl.Event) {
        if targets[event] != nil {
            targets[event]?.append((target: target, action: action))
        } else {
            targets[event] = [(target: target, action: action)]
        }
    }

    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        state = .highlighted
        targets[.touchDown]?.forEach { target, action in
            sendAction(action, to: target, for: event)
        }
    }

    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        state = .normal
        targets[.touchUpInside]?.forEach { target, action in
            sendAction(action, to: target, for: event)
        }
    }

    public func sendAction(_ action: Selector, to target: Any?, for event: UIEvent?) {
        UIApplication.shared.sendAction(action, to: target, from: self, for: event)
    }
}

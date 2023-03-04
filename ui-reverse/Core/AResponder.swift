//
//  AResponder.swift
//  ui-reverse
//
//  Created by Vlad Zaytsev on 02.03.2023.
//

import UIKit

public class AResponder: NSObject {
    public var next: AResponder? { nil }

    public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        next?.touchesBegan(touches, with: event)
    }

    public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        next?.touchesEnded(touches, with: event)
    }

    public func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        next?.touchesCancelled(touches, with: event)
    }

    public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        next?.touchesMoved(touches, with: event)
    }
}

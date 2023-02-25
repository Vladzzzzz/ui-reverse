//
//  ALabel.swift
//  ui-reverse
//
//  Created by Vlad Zaytsev on 25.02.2023.
//

import UIKit

public class ALabel: AView {
    public var text: String? { didSet { setNeedsDisplay() } }

    public var font: UIFont? { didSet { setNeedsDisplay() } }

    public var textColor: UIColor? { didSet { setNeedsDisplay() } }

    public var textAlignment: NSTextAlignment = .left { didSet { setNeedsDisplay() } }

    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = textAlignment
        var attributes: [NSAttributedString.Key : Any] = [:]
        attributes[.font] = font
        attributes[.foregroundColor] = textColor
        attributes[.paragraphStyle] = paragraphStyle
        (text as NSString?)?.draw(in: rect, withAttributes: attributes)
    }
}

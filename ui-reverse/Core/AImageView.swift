//
//  AImageView.swift
//  ui-reverse
//
//  Created by Vlad Zaytsev on 25.02.2023.
//

import UIKit

public class AImageView: AView {
    public enum ContentMode { case center, scaleAspectFit, scaleAspectFill }

    public var contentMode: ContentMode = .scaleAspectFill {
        didSet {
            configure(contentMode: contentMode)
            setNeedsDisplay()
        }
    }

    public var image: UIImage? { didSet { setNeedsDisplay() } }

    public override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        configure(contentMode: contentMode)
    }

    public func display(_ layer: CALayer) {
        layer.contents = image?.cgImage
    }

    private func configure(contentMode: ContentMode) {
        switch contentMode {
        case .center: layer.contentsGravity = .center
        case .scaleAspectFit: layer.contentsGravity = .resizeAspect
        case .scaleAspectFill: layer.contentsGravity = .resizeAspectFill
        }
    }
}

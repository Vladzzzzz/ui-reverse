//
//  AButton.swift
//  ui-reverse
//
//  Created by Vlad Zaytsev on 05.03.2023.
//

import UIKit

public class AButton: AControl {
    public let titleLabel = ALabel()

    public override var state: AControl.State {
        didSet { configure(with: state) }
    }

    public var title: String? {
        get { titleLabel.text }
        set { titleLabel.text = newValue }
    }

    private var styleParameters: [AControl.State: [StyleKey: Any]] = [.normal: [:], .highlighted: [:]]

    public override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        state = .normal
        addSubview(titleLabel)
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.frame = bounds
    }

    public func setTitleColor(_ color: UIColor, for state: AControl.State) {
        if self.state == state { titleLabel.textColor = color }
        styleParameters[state]![.titleColor] = color
    }

    public func setBackgroundColor(_ color: UIColor, for state: AControl.State) {
        if self.state == state { backgroundColor = color }
        styleParameters[state]![.backgroundColor] = color
    }
}

private extension AButton {
    enum StyleKey: Hashable {
        case titleColor
        case backgroundColor
    }

    func configure(with state: State) {
        if let titleColor = styleParameters[state]?[.titleColor] as? UIColor {
            titleLabel.textColor = titleColor
        }
        if let backgroundColor = styleParameters[state]?[.backgroundColor] as? UIColor {
            self.backgroundColor = backgroundColor
        }
    }
}

import UIKit

public class AView: NSObject, CALayerDelegate {
    // MARK: - Init

    public init(frame: CGRect = .zero) {
        super.init()
        self.frame = frame
        layer.delegate = self
    }

    // MARK: - Layer

    public let layer = CALayer()

    public var frame: CGRect {
        get { layer.frame }
        set { layer.frame = newValue }
    }

    public var bounds: CGRect {
        get { layer.bounds }
        set { layer.bounds = newValue }
    }

    public var backgroundColor: UIColor? {
        get { layer.backgroundColor.flatMap { UIColor(cgColor: $0) } }
        set { layer.backgroundColor = newValue?.cgColor }
    }

    public var alpha: CGFloat {
        get { CGFloat(layer.opacity) }
        set { layer.opacity = Float(newValue) }
    }

    public var isHidden: Bool {
        get { layer.isHidden }
        set { layer.isHidden = newValue }
    }

    // MARK: - Subviews

    public private(set) var subviews: [AView] = []
    public private(set) weak var superview: AView?

    public func addSubview(_ view: AView) {
        guard view != self else { return }
        if view.superview != nil { view.removeFromSuperview() }
        subviews.append(view)
        layer.addSublayer(view.layer)
        view.superview = self
    }

    public func removeFromSuperview() {
        superview?.remove(subview: self)
        layer.removeFromSuperlayer()
        superview = nil
    }

    func remove(subview: AView) {
        subviews.removeAll { $0 === subview }
    }

    // MARK: - Layout

    public func layoutSubviews() { }

    public func setNeedsLayout() { layer.setNeedsLayout() }

    public func layoutIfNeeded() { layer.layoutIfNeeded() }

    // MARK: - Display

    public func draw(_ rect: CGRect) { }

    public func setNeedsDisplay() { layer.setNeedsDisplay() }

    // MARK: - CALayerDelegate

    public func draw(_ layer: CALayer, in ctx: CGContext) {
        let rect = ctx.boundingBoxOfClipPath
        UIGraphicsPushContext(ctx)
        draw(rect)
        UIGraphicsPopContext()
    }

    public func layoutSublayers(of _: CALayer) { layoutSubviews() }
}

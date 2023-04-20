//
//  AViewController.swift
//  ui-reverse
//
//  Created by Vlad Zaytsev on 06.03.2023.
//

import UIKit

public class AViewController: AResponder {
    // MARK: - View

    private var _view: AView?
    public var view: AView! {
        get {
            if let view = _view {
                return view
            } else {
                self.loadView()
                _view?.viewController = self
                self.viewDidLoad()
                return _view
            }
        }
        set {
            _view = newValue
        }
    }

    // MARK: - Lifecycle

    public override init() { super.init() }
    public func loadView() {
        view = AView(frame: .init(origin: .zero, size: .zero))
    }
    public func viewDidLoad() { }
    public func viewWillLayoutSubviews() { }
    public func viewDidLayoutSubviews() { }
    public func viewWillAppear(_ animated: Bool) { }
    public func viewDidAppear(_ animated: Bool) { }
    public func viewWillDisappear(_ animated: Bool) { }
    public func viewDidDisappear(_ animated: Bool) { }

    // MARK: - Responder

    public override var next: AResponder? {
        presentingViewController // ?? parent ?? view.aWindow
    }

    // MARK: - AppearanceTransition

    private var appearanceTransitionCount = 0
    private var appearanceTransitionIsAnimated = false
    private var viewIsAppearing = false

    public func beginAppearanceTransition(_ isAppearing: Bool, animated: Bool) {
        if appearanceTransitionCount == 0 || (appearanceTransitionCount > 0 && viewIsAppearing != isAppearing) {
            appearanceTransitionCount = 1
            appearanceTransitionIsAnimated = animated
            viewIsAppearing = isAppearing

            if viewIsAppearing {
                _ = view // Убеждаемся что вью загружена
                viewWillAppear(animated)
            } else {
                viewWillDisappear(animated)
            }
        } else {
            appearanceTransitionCount += 1
        }
    }

    public func endAppearanceTransition() {
        if appearanceTransitionCount > 0 { appearanceTransitionCount -= 1 }
        guard appearanceTransitionCount == 0 else { return }
        let isAnimated = appearanceTransitionIsAnimated
        viewIsAppearing ? viewDidAppear(isAnimated) : viewDidDisappear(isAnimated)
    }

    // MARK: - Presenting

    public var presentedViewController: AViewController?
    public weak var presentingViewController: AViewController?

    public func present(_ viewControllerToPresent: AViewController, animated: Bool, completion: (() -> Void)? = nil) {
        guard let window = view.window else {
            return
        }
        presentedViewController = viewControllerToPresent
        viewControllerToPresent.presentingViewController = self

        window.addASubview(viewControllerToPresent.view)
        viewControllerToPresent.view.frame = .init(
            origin: .init(x: window.bounds.origin.x, y: window.bounds.height),
            size: .init(width: window.bounds.width, height: window.bounds.height)
        )
        let animationBlock: () -> Void = {
            viewControllerToPresent.view.frame.origin.y = window.bounds.origin.y
        }
        let completionBlock: (Bool) -> Void = { _ in
            viewControllerToPresent.endAppearanceTransition()
            self.endAppearanceTransition()
            completion?()
        }

        beginAppearanceTransition(false, animated: animated)
        viewControllerToPresent.beginAppearanceTransition(true, animated: animated)
        if animated {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                AView.animate(withDuration: 0.5, animations: animationBlock, completion: completionBlock)
            }
        } else {
            animationBlock()
            completionBlock(true)
        }
    }

    public func dismiss(animated: Bool, completion: (() -> Void)? = nil) {
        guard let window = view.window, let presentingViewController = presentingViewController else {
            return
        }

        let animationBlock: () -> Void = { [weak self] in
            self?.view.frame.origin.y = window.bounds.height
        }

        let completionBlock: (Bool) -> Void = { [weak presentingViewController, weak self] _ in
            self?.view.removeFromSuperview()
            presentingViewController?.endAppearanceTransition()
            self?.endAppearanceTransition()
            completion?()
        }

        presentingViewController.presentedViewController = nil
        self.presentingViewController = nil

        beginAppearanceTransition(false, animated: animated)
        presentingViewController.beginAppearanceTransition(true, animated: animated)
        if animated {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                AView.animate(withDuration: 0.5, animations: animationBlock, completion: completionBlock)
            }
        } else {
            animationBlock()
            completionBlock(true)
        }
    }
}

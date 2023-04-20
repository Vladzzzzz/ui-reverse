//
//  InfoVC.swift
//  ui-reverse
//
//  Created by Vlad Zaytsev on 15.03.2023.
//

import UIKit

final class InfoViewController: AViewController {
    // MARK: - Views

    private lazy var closeButton: AButton = {
        let button = AButton()
        button.title = "Закрыть"
        button.layer.cornerRadius = Constants.buttonCornerRadius
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.red, for: .highlighted)
        button.setBackgroundColor(.black, for: .highlighted)
        button.setBackgroundColor(.darkGray, for: .normal)
        button.titleLabel.textAlignment = .center
        button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        return button
    }()

    private let infoLabel: ALabel = {
        let label = ALabel()
        label.font = Constants.font
        return label
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        infoLabel.text = Constants.description
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureLayout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = .cyan
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        view.backgroundColor = .lightGray
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.backgroundColor = .red
    }

    @objc
    func tapButton() {
        dismiss(animated: true)
    }
}

private extension InfoViewController {
    enum Constants {
        static let horizontalInset: CGFloat = 16
        static let verticalInset: CGFloat = 30
        static let verticalSpacing: CGFloat = 16
        static let buttonSize = CGSize(width: 60, height: 20)
        static let buttonCornerRadius: CGFloat = 4
        static let font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        static let description = "Сергей Викторович не только солидный акционер, но и замечательный человек! И то, что вы до сих пор этого не знаете, бросает тень на вашу вовлеченность в процессы и жизнь компании. А так же ставит под вопрос вашу дальнейшую карьеру."
    }

    func addSubviews() {
        [infoLabel, closeButton].forEach { view.addSubview($0) }
    }

    func configureLayout() {
        closeButton.frame.size = Constants.buttonSize
        closeButton.frame.origin = .init(x: Constants.horizontalInset, y: Constants.verticalInset)
        infoLabel.frame = .init(
            x: Constants.horizontalInset,
            y: closeButton.frame.maxY + Constants.verticalSpacing,
            width: view.bounds.width - Constants.horizontalInset * 2,
            height: view.bounds.height - closeButton.frame.maxY - Constants.verticalSpacing
        )
    }
}

import UIKit

final class ShareholderView: AView {
    private enum Constants {
        static let horizontalInset: CGFloat = 16
        static let verticalInset: CGFloat = 30
        static let horizontalSpacing: CGFloat = 8
        static let verticalSpacing: CGFloat = 8
        static let imageSize = CGSize(width: 64, height: 64)
        static let buttonSize = CGSize(width: 80, height: 20)
        static let titleFont = UIFont.systemFont(ofSize: 16, weight: .semibold)
        static let subtitleFont = UIFont.systemFont(ofSize: 14, weight: .thin)
        static let descriptionFont = UIFont.systemFont(ofSize: 14, weight: .regular)
    }


    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        backgroundColor = .lightGray
        addSubviews()
        configureLayout(viewSize: frame)
    }

    private let imageView: AView = { let view = AView(); view.backgroundColor = .gray; return view }()
    private let titleLabel: AView = { let view = AView(); view.backgroundColor = .gray; return view }()
    private let subtitleLabel: AView = { let view = AView(); view.backgroundColor = .gray; return view }()
    private let button: AView = { let view = AView(); view.backgroundColor = .gray; return view }()
    private let descriptionLabel: AView = { let view = AView(); view.backgroundColor = .gray; return view }()
}

private extension ShareholderView {
    func addSubviews() {
        [imageView, titleLabel, subtitleLabel, button, descriptionLabel].forEach {
            addSubview($0)
        }
    }

    func configureLayout(viewSize: CGRect) {
        imageView.layer.cornerRadius = Constants.imageSize.height / 2
        imageView.frame = .init(
            origin: .init(x: Constants.horizontalInset, y: Constants.verticalInset),
            size: Constants.imageSize
        )
        titleLabel.frame = .init(
            origin: .init(x: imageView.frame.maxX + Constants.horizontalSpacing, y: Constants.verticalInset),
            size: .init(
                width: viewSize.width - imageView.frame.maxX - Constants.horizontalSpacing - Constants.horizontalInset,
                height: Constants.titleFont.lineHeight
            )
        )
        subtitleLabel.frame = .init(
            origin: .init(x: imageView.frame.maxX + Constants.horizontalSpacing, y: titleLabel.frame.maxY + Constants.verticalSpacing),
            size: .init(
                width: viewSize.width - imageView.frame.maxX - Constants.horizontalSpacing - Constants.horizontalInset,
                height: Constants.subtitleFont.lineHeight
            )
        )
        button.layer.cornerRadius = Constants.buttonSize.height / 2
        button.frame = .init(
            origin: .init(x: imageView.frame.maxX + Constants.horizontalSpacing, y: subtitleLabel.frame.maxY + Constants.verticalSpacing),
            size: Constants.buttonSize
        )

        descriptionLabel.frame = .init(
            origin: .init(x: Constants.horizontalInset, y: button.frame.maxY + Constants.verticalSpacing),
            size: .init(
                width: viewSize.width - 2 * Constants.horizontalInset,
                height: viewSize.size.height - button.frame.maxY + Constants.verticalSpacing - Constants.verticalInset
            )
        )
    }
}

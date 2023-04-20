import UIKit

protocol ShareholderViewDelegete: AnyObject {
    func didPressInfo()
}

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

    weak var delegate: ShareholderViewDelegete?

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        backgroundColor = .lightGray
        addSubviews()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        configureLayout(viewSize: bounds)
    }

    private let imageView: AImageView = {
        let view = AImageView()
        view.layer.masksToBounds = true
        return view
    }()
    private lazy var button: AButton = {
        let button = AButton()
        button.title = "Инфо"
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.red, for: .highlighted)
        button.setBackgroundColor(.black, for: .highlighted)
        button.setBackgroundColor(.darkGray, for: .normal)
        button.titleLabel.textAlignment = .center
        button.addTarget(self, action: #selector(tapInfo), for: .touchUpInside)
        return button
    }()
    private let titleLabel: ALabel = {
        let view = ALabel()
        view.font = Constants.titleFont
        return view
    }()
    private let subtitleLabel: ALabel = {
        let view = ALabel()
        view.font = Constants.subtitleFont
        return view
    }()
    private let descriptionLabel: ALabel = {
        let view = ALabel()
        view.font = Constants.descriptionFont
        return view
    }()

    func configure(with viewModel: ShareholderViewModel) {
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        descriptionLabel.text = viewModel.description
        imageView.image = viewModel.image
    }
}

private extension ShareholderView {
    @objc
    func tapInfo() {
        delegate?.didPressInfo()
    }

    func addSubviews() {
        [imageView, titleLabel, subtitleLabel, button, descriptionLabel].forEach { addSubview($0) }
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

struct ShareholderViewModel {
    let title: String
    let subtitle: String
    let description: String
    let image: UIImage
}

extension ShareholderViewModel {
    enum Seeds {
        static let value = ShareholderViewModel(
            title: "Иванов Сергей Викторович",
            subtitle: "Главный Акционер \"Рога и Копыта\"",
            description: "Lorem Ipsum - это текст-\"рыба\", часто используемый в печати и вэб-дизайне. Lorem Ipsum является стандартной \"рыбой\" для текстов на латинице с начала XVI века. В то время некий безымянный печатник создал большую коллекцию размеров и форм шрифтов, используя Lorem Ipsum для распечатки образцов. Lorem Ipsum не только успешно пережил без заметных изменений пять веков, но и перешагнул в электронный дизайн. Его популяризации в новое время послужили публикация листов Letraset с образцами Lorem Ipsum в 60-х годах и, в более недавнее время, программы электронной вёрстки типа Aldus PageMaker, в шаблонах которых используется Lorem Ipsum.",
            image: UIImage(named: "bankir")!
        )
    }
}

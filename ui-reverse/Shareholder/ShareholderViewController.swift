//
//  ShareholderViewController.swift
//  ui-reverse
//
//  Created by Vlad Zaytsev on 06.03.2023.
//

import UIKit

final class ShareholderViewController: AViewController {
    private let contentView = ShareholderView(frame: .zero)
    override func loadView() {
        view = contentView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.delegate = self
        contentView.configure(with: ShareholderViewModel.Seeds.value)
    }
}

extension ShareholderViewController: ShareholderViewDelegete {
    func didPressInfo() {
        let vc = InfoViewController()
        present(vc, animated: true)
    }
}

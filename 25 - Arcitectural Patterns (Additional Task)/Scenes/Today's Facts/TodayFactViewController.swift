//
//  TodayFactsViewController.swift
//  25 - Arcitectural Patterns (Additional Task)
//
//  Created by Ani's Mac on 18.11.23.
//

import UIKit

final class TodayFactViewController: UIViewController {
    // MARK: - Properties
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 40
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = .init(top: 16, left: 16, bottom: 16, right: 16)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private let changeTodayFactButton: UIButton = {
        let button = UIButton()
        button.setTitle("Change Fact", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.layer.cornerRadius = 8
        return button
    }()
    
    private let viewModel = TodayFactsViewModel()
    
    // MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupViewModelDelegate()
        setupChangeTodayFactButton()
        viewModel.viewDidLoad()
    }
    
    // MARK: - Private Methods
    private func setup() {
        setUpBackground()
        setupSubviews()
        setupConstraints()
    }
    
    private func setUpBackground() {
        view.backgroundColor = .white
    }
    
    private func setupSubviews() {
        view.addSubview(mainStackView)
        mainStackView.addArrangedSubview(titleLabel)
        mainStackView.addArrangedSubview(changeTodayFactButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            changeTodayFactButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    private func setupViewModelDelegate() {
        viewModel.delegate = self
    }
    
    private func setupChangeTodayFactButton() {
        changeTodayFactButton.addAction(
            UIAction(
                title: "",
                handler: { [weak self] action in
                    self?.changeFactButtonDidTap()
                }
            ),
            for: .touchUpInside
        )
    }
    
    private func changeFactButtonDidTap() {
        viewModel.viewDidLoad()
    }
}

// MARK: - TodayFactsViewModelDelegate
extension TodayFactViewController: TodayFactsViewModelDelegate {
    func factsFetched(_ text: String) {
        DispatchQueue.main.async {
            self.titleLabel.text = text
        }
    }
    
    func showError(_ error: Error) {
        print("error")
    }
}

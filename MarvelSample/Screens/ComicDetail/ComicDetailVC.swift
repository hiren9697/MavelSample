//
//  ComicDetailVC.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 03/08/24.
//

import UIKit

class ComicDetailVC: ParentVC {
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isScrollEnabled = true
        return scrollView
    }()
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "fifth")
        return imageView
    }()
    let imageViewContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "Hello there, how are you?, I am really well, what about you?"
        return label
    }()
    let titleLabelContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        setupInitialUI()
    }
    
    // MARK: - UI method(s)
    private func setupConstraints() {
        // ScrollView
        view.addSubview(scrollView)
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        // ImageView
        imageViewContainer.addSubview(imageView)
        imageView.leadingAnchor.constraint(equalTo: imageViewContainer.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: imageViewContainer.trailingAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: imageViewContainer.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: imageViewContainer.bottomAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        stackView.addArrangedSubview(imageViewContainer)
        // Title
        titleLabelContainer.addSubview(titleLabel)
        titleLabel.leadingAnchor.constraint(equalTo: titleLabelContainer.leadingAnchor, constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: titleLabelContainer.trailingAnchor, constant: -20).isActive = true
        titleLabel.topAnchor.constraint(equalTo: titleLabelContainer.topAnchor, constant: 10).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: titleLabelContainer.bottomAnchor, constant: -10).isActive = true
        stackView.addArrangedSubview(titleLabelContainer)
        // StackView
        scrollView.addSubview(stackView)
        stackView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }
    
    override func setupInitialUI() {
        super.setupInitialUI()
    }
}


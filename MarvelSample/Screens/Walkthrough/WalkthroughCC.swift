//
//  WalkthroughCC.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 06/07/24.
//

import UIKit

// MARK: - CC
class WalkthroughCC: ParentCC {
    
    let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "logo")
        return imageView
    }()
    let textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.white
        return label
    }()
    
    var viewModel: WalkthroughItemVM!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureInitialUI()
    }
}

// MARK: - UI
extension WalkthroughCC {
    
    private func configureInitialUI() {
        contentView.backgroundColor = UIColor.black
        // 1. Background Image
        contentView.addSubview(backgroundImageView)
        backgroundImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        backgroundImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                                    constant: -200).isActive = true
        // 2. Logo
        contentView.addSubview(logoImageView)
        logoImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        logoImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor,
                                               constant: -100).isActive = true
        // 3. Text
        contentView.addSubview(textLabel)
        textLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor,
                                       constant: 52).isActive = true
        // textLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        textLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                           constant: 20).isActive = true
        textLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                            constant: -20).isActive = true
    }
    
    func updateUI(viewModel: WalkthroughItemVM) {
        self.viewModel = viewModel
        backgroundImageView.image = UIImage(named: viewModel.imageName)
        textLabel.text = viewModel.text
    }
}

//
//  TableViewNextPageLoader.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 31/07/24.
//

import UIKit

class TableViewNextPageLoader: UITableViewHeaderFooterView {
    
    let activity: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.color = AppColors.red
        activity.hidesWhenStopped = true
        return activity
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = AppColors.red
        return label
    }()
    
    lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [activity, titleLabel])
        stack.axis = .horizontal
        stack.spacing = 15
        stack.alignment = .center
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupInitialUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // HsetupInitialUI()
    }
    
//    override var intrinsicContentSize: CGSize {
//        return CGSize(width: Geometry.screenWidth, height: 60)
//    }
    
    private func setupInitialUI() {
        addSubview(stack)
        stack.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        stack.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        titleLabel.text = "Loading next page"
        titleLabel.layoutSubviews()
        stack.layoutSubviews()
    }
    
    public func startAnimating() {
        activity.startAnimating()
    }
    
    public func stopAnimating() {
        activity.stopAnimating()
    }
    
//    public func show() {
//        activity.startAnimating()
//        stack.isHidden = true
//        layoutIfNeeded()
//        UIView.animate(withDuration: 0.2,
//                       delay: 0,
//                       options: .curveEaseInOut) {[weak self] in
//            guard let strongSelf = self else { return }
//            strongSelf.stack.isHidden = false
//            strongSelf.layoutSubviews()
//        } completion: { _ in }
//
//    }
//
//    public func hide() {
//        UIView.animate(withDuration: 0.2,
//                       delay: 0,
//                       options: .curveEaseInOut) {[weak self] in
//            guard let strongSelf = self else { return }
//            strongSelf.stack.isHidden = false
//            strongSelf.layoutIfNeeded()
//        } completion: {[weak self] _ in
//            self?.activity.stopAnimating()
//        }
//    }
    
    public func updateText(text: String) {
        titleLabel.text = text
        titleLabel.layoutIfNeeded()
        setNeedsLayout()
        layoutIfNeeded()
    }
}

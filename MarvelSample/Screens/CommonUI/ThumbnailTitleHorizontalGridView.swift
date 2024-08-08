//
//  HorizontalGridView.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 07/08/24.
//

import UIKit


class CharactersGridData: HorizontalGridData {
    let title: String = "Characters"
    var data: [ThumbnailTitleData]
    
    init(data: [ThumbnailTitleData]) {
        self.data = data
    }
}

final class ThumbnailTitleHorizontalGridView: UIView {
    // MARK: - UI Components
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.gray
        label.textAlignment = .left
        return label
    }()
    let titleLabelContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = .zero
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    let collectionViewContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
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
    
    // MARK: - Variables
    let itemSpace: CGFloat = 0
    let lineSpace: CGFloat = 10
    let gridHorizontalPadding: CGFloat = 20
    let gridVerticalPadding: CGFloat = 5
    lazy var itemSize: CGSize = {
        let width: CGFloat = 375 / 3
        let height = width * 1.3
        return CGSize(width: width, height: height)
    }()
    lazy var collectionViewContainerHeight: CGFloat = {
        let itemHeight = itemSize.height
        // let collectionViewTopBottomConstraintHeight: CGFloat = 5 * 2
        let collectionViewSectionPadding = gridVerticalPadding * 2
        let totalHeight = itemHeight + collectionViewSectionPadding
        return totalHeight
    }()
    
    var viewModel: HorizontalGridData
    
    init(viewModel: HorizontalGridData) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupConstraints()
        setupInitialUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        setupConstraints()
    }
}

// MARK: - UI Helper methods
extension ThumbnailTitleHorizontalGridView {
    
    private func setupConstraints() {
        // Container view
        self.addSubview(containerView)
        containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        // Stack view
        containerView.addSubview(stackView)
        stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        // Title label
        titleLabelContainer.addSubview(titleLabel)
        titleLabel.leadingAnchor.constraint(equalTo: titleLabelContainer.leadingAnchor, constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: titleLabelContainer.trailingAnchor, constant: -20).isActive = true
        titleLabel.topAnchor.constraint(equalTo: titleLabelContainer.topAnchor, constant: 5).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: titleLabelContainer.bottomAnchor, constant: -5).isActive = true
        // CollectionView
        collectionViewContainer.addSubview(collectionView)
        collectionView.leadingAnchor.constraint(equalTo: collectionViewContainer.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: collectionViewContainer.trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: collectionViewContainer.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: collectionViewContainer.bottomAnchor).isActive = true
        // Title label container
        collectionViewContainer.heightAnchor.constraint(equalToConstant: collectionViewContainerHeight).isActive = true
        stackView.addArrangedSubview(titleLabelContainer)
        // Collection view container
        stackView.addArrangedSubview(collectionViewContainer)
    }
    
    private func setupInitialUI() {
        // Title
        titleLabel.text = viewModel.title
        // CollectionView
        collectionView.register(ThumbnailTitleCC<CDCharacterItemVM>.self,
                                          forCellWithReuseIdentifier: ThumbnailTitleCC<CDCharacterItemVM>.name)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
        
//        collectionView.backgroundColor = .red
//        self.backgroundColor = .black
//        self.collectionViewContainer.backgroundColor = .blue
//        stackView.backgroundColor = .yellow
    }
}

// MARK: - CollectionView Delegate
extension ThumbnailTitleHorizontalGridView: UICollectionViewDelegate {
    
}

// MARK: - CollectionView Datasource
extension ThumbnailTitleHorizontalGridView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ThumbnailTitleCC<CDCharacterItemVM>.name,
                                                      for: indexPath) as! ThumbnailTitleCC<CDCharacterItemVM>
        cell.update(viewModel: viewModel.data[indexPath.row] as! CDCharacterItemVM)
        return cell
    }
}

// MARK: - CollectionView DelegateFlowLayout
extension ThumbnailTitleHorizontalGridView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        itemSpace
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        lineSpace
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: gridVerticalPadding,
                     left: gridHorizontalPadding,
                     bottom: gridVerticalPadding,
                     right: gridHorizontalPadding)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return itemSize
    }
}

//
//  CharacterDetailVC.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 02/09/24.
//

import UIKit

/// ViewController for character detail screen
class CharacterDetailVC: ParentVC {
    // MARK: - UI Components
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
    lazy var comicCollectionView: ThumbnailTitleHorizontalGridView =  {
        ThumbnailTitleHorizontalGridView(viewModel: viewModel.comicsHorizontalGridVM)
    }()
    lazy var seriesCollectionView: ThumbnailTitleHorizontalGridView =  {
        ThumbnailTitleHorizontalGridView(viewModel: viewModel.seriesHorizontalGridVM)
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
    let viewModel: CharacterDetailVM
    let itemSpace: CGFloat = 0
    let lineSpace: CGFloat = 10
    let gridHorizontalPadding: CGFloat = 20
    let gridVerticalPadding: CGFloat = 5
    lazy var itemSize: CGSize = {
        let width = view.bounds.width / 3
        let height = width * 1.3
        return CGSize(width: width, height: height)
    }()
    lazy var horizontalGridHeight: CGFloat = {
        let itemHeight = itemSize.height
        let collectionViewTopBottomConstraintHeight: CGFloat = 5 * 2
        let collectionViewSectionPadding = gridVerticalPadding * 2
        let totalHeight = itemHeight + collectionViewTopBottomConstraintHeight + collectionViewSectionPadding
        return totalHeight
    }()
    
    init(viewModel: CharacterDetailVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        setupInitialUI()
        fillData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // charactersCollectionView.reloadData()
    }
    
    // MARK: - UI method(s)
    override func setupConstraints() {
        super.setupConstraints()
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
        // Comic collection view
        comicCollectionView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(comicCollectionView)
        // Series collection view
        seriesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(seriesCollectionView)
        // StackView
        scrollView.addSubview(stackView)
        stackView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }
    
    override func setupInitialUI() {
        super.setupInitialUI()
    }
    
    // MARK: - Helper
    func loadImage() {
        imageView.kf.setImage(with: viewModel.thumbnailURL)
    }
    
    private func fillData() {
        loadImage()
        titleLabel.text = viewModel.name
    }
}

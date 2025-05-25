//
//  SearchViewCell.swift
//  InstagramClone
//
//  Created by Bakhrom Usmanov on 15/05/25.
//

import UIKit

final class SearchViewCell: UITableViewCell {
   
   //MARK: - Properties
   
   private var viewModel: SearchCellViewModel? {
      didSet {
         updateView()
      }
   }
   
   //MARK: - Subviews
   
   private let profileImageView: UIImageView = {
      let imageView = UIImageView(image: UIImage(named: Constants.profileImageName))
      imageView.contentMode = .scaleAspectFill
      imageView.clipsToBounds = true
      imageView.layer.cornerRadius = Constants.profileImageCornerRadius
      return imageView
   }()
   
   private let usernameLabel: UILabel = {
      let label = UILabel()
      label.font = ThemeManager.fonts.bodyMediumBold
      label.textColor = ThemeManager.colors.textPrimaryDark
      return label
   }()
   
   private let fullNameLabel: UILabel = {
      let label = UILabel()
      label.font = ThemeManager.fonts.bodyMediumMedium
      label.textColor = ThemeManager.colors.textSecondaryDark
      return label
   }()
   
   private let labelsStackView: UIStackView = {
      let stackView = UIStackView()
      stackView.axis = .vertical
      stackView.distribution = .fill
      stackView.alignment = .leading
      stackView.spacing = Constants.labelToLabelSpacing
      return stackView
   }()
   
   //MARK: Initialization
   
   override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
      super.init(style: style, reuseIdentifier: reuseIdentifier)
      setupViews()
      setupConstraints()
      setupSelectionView()
      showLayoutColors(false)
   }
   
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
   //MARK: - Lifecycle
   
   override func prepareForReuse() {
      cancelImageLoading()
      profileImageView.image = nil
   }
}

//MARK: - Public Functions

extension SearchViewCell {
   func setViewModel(_ viewModel: SearchCellViewModel) {
      self.viewModel = viewModel
   }
   
   static var baseContentHeight: CGFloat {
      return Constants.profileImageViewSize + Constants.verticalPadding * 2
   }
}

//MARK: - Private Functions

private extension SearchViewCell {
   func updateView() {
      usernameLabel.text = viewModel?.username
      fullNameLabel.text = viewModel?.fullName
      updateProfileImage()
   }
   
   func updateProfileImage() {
      guard let imageURL = viewModel?.profileImageURL else { return }
      ImageDownloaderService.shared.loadImage(from: imageURL) { image in
         self.profileImageView.image = image
      }
   }
   
   func cancelImageLoading() {
      guard let url = viewModel?.profileImageURL else { return }
      ImageDownloaderService.shared.cancelLoading(for: url)
   }
}

//MARK: - Appearance & Theming

private extension SearchViewCell {
   func showLayoutColors(_ isEnabled: Bool) {
      guard isEnabled else { return }
      
      labelsStackView.backgroundColor = .systemPink
      usernameLabel.backgroundColor = .blue
      fullNameLabel.backgroundColor = .green
      backgroundColor = .yellow
   }
   
   func setupSelectionView() {
      selectionStyle = .default
      let selectionView = UIView()
      selectionView.backgroundColor = ThemeManager.colors.grey200
      selectedBackgroundView = selectionView
   }
}

//MARK: - Layout & Constraints

private extension SearchViewCell {
   
   func setupViews() {
      contentView.addSubview(profileImageView)
      contentView.addSubview(labelsStackView)
      
      labelsStackView.addArrangedSubview(usernameLabel)
      labelsStackView.addArrangedSubview(fullNameLabel)
   }
   
   func setupConstraints() {
      profileImageView.snp.makeConstraints { make in
         make.top.bottom.equalToSuperview().inset(Constants.verticalPadding)
         make.leading.equalToSuperview().inset(Constants.horizontalPadding)
         make.size.equalTo(Constants.profileImageViewSize)
      }
      
      labelsStackView.snp.makeConstraints { make in
         make.leading.equalTo(profileImageView.snp.trailing).offset(Constants.imageToLabelSpacing)
         make.trailing.equalToSuperview().inset(Constants.horizontalPadding)
         make.centerY.equalTo(profileImageView)
      }
   }
}

private extension SearchViewCell {
   enum Constants {
      //Namings
      static let profileImageName = "thumbnail"
      
      //Spacings
      static let horizontalPadding = ThemeManager.spacings.spacingM
      static let verticalPadding = ThemeManager.spacings.spacingM
      static let imageToLabelSpacing = ThemeManager.spacings.spacingS
      static let labelToLabelSpacing = ThemeManager.spacings.spacingXS
      
      //Sizes
      static let profileImageViewSize: CGFloat = 50
      static let profileImageCornerRadius: CGFloat = profileImageViewSize / 2
   }
}

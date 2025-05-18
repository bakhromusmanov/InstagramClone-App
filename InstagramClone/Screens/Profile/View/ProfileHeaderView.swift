//
//  ProfileHeaderView.swift
//  InstagramClone
//
//  Created by Bakhrom Usmanov on 02/05/25.
//

import Foundation
import UIKit

final class ProfileHeaderView: UICollectionReusableView {
   
   //MARK: - Properties
   
   private var viewModel: ProfileHeaderViewModel? {
      didSet {
         updateView()
      }
   }
   
   //MARK: - Subviews
   
   private let topSeparatorView: UIView = {
      let view = UIView()
      view.backgroundColor = ThemeManager.colors.textSecondaryDark
      return view
   }()
   
   private let bottomSeparatorView: UIView = {
      let view = UIView()
      view.backgroundColor = ThemeManager.colors.textSecondaryDark
      return view
   }()
   
   private let profileImageView: UIImageView = {
      let imageView = UIImageView(
         image: UIImage(named: Constants.thumbnailImageName)
      )
      imageView.contentMode = .scaleAspectFill
      imageView.layer.cornerRadius = Constants.profileImageCornerRadius
      imageView.layer.masksToBounds = true
      return imageView
   }()
   
   private let fullNameLabel: UILabel = {
      let label = UILabel()
      label.text = Constants.defaultFullNameText
      label.textColor = ThemeManager.colors.textPrimaryDark
      label.font = Constants.fullNameLabelFont
      return label
   }()
   
   private lazy var postsButton: ProfileStatsButton = {
      let button = ProfileStatsButton(type: .system)
      button.setupStats(title: Constants.postsLabelText, value: Constants.defaultStatsCount)
      return button
   }()
   
   private lazy var followersButton: ProfileStatsButton = {
      let button = ProfileStatsButton(type: .system)
      button.setupStats(title: Constants.followersLabelText, value: Constants.defaultStatsCount)
      return button
   }()
   
   private lazy var followingsButton: ProfileStatsButton = {
      let button = ProfileStatsButton(type: .system)
      button.setupStats(title: Constants.followingLabelText, value: Constants.defaultStatsCount)
      return button
   }()
   
   private let statsStackView: UIStackView = {
      let stackView = UIStackView()
      stackView.axis = .horizontal
      stackView.distribution = .fillEqually
      stackView.alignment = .center
      return stackView
   }()
   
   private lazy var editProfileButton: UIButton = {
      let button = UIButton(type: .system)
      button.setTitle(Constants.editProfileButtonText, for: .normal)
      button.setTitleColor(ThemeManager.colors.textPrimaryDark, for: .normal)
      button.titleLabel?.font = ThemeManager.fonts.bodyMediumBold
      button.backgroundColor = ThemeManager.colors.whiteOpacity10
      button.layer.cornerRadius = Constants.editButtonCornerRadius
      button.layer.borderColor = ThemeManager.colors.border.cgColor
      button.layer.borderWidth = Constants.editButtonBorderWidth
      return button
   }()
   
   private let segmentStackView: UIStackView = {
      let stackView = UIStackView()
      stackView.axis = .horizontal
      stackView.distribution = .fillEqually
      stackView.alignment = .center
      stackView.backgroundColor = ThemeManager.colors.backgroundSecondary
      return stackView
   }()
   
   private lazy var gridButton: UIButton = {
      let button = UIButton(type: .system)
      button.setImage(UIImage(systemName: Constants.gridImageName), for: .normal)
      button.imageView?.contentMode = .scaleAspectFit
      button.tintColor = ThemeManager.colors.enabledButton
      return button
   }()
   
   private lazy var listButton: UIButton = {
      let button = UIButton(type: .system)
      button.setImage(UIImage(systemName: Constants.listImageName), for: .normal)
      button.imageView?.contentMode = .scaleAspectFit
      button.tintColor = ThemeManager.colors.textSecondaryDark
      return button
   }()
   
   private lazy var bookmarkButton: UIButton = {
      let button = UIButton(type: .system)
      button.setImage(UIImage(systemName: Constants.bookmarkImageName), for: .normal)
      button.imageView?.contentMode = .scaleAspectFit
      button.tintColor = ThemeManager.colors.textSecondaryDark
      return button
   }()
   
   //MARK: - Initialization
   
   override init(frame: CGRect) {
      super.init(frame: frame)
      setupViews()
      setupConstraints()
      showLayoutColors(false)
   }
   
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
   //MARK: Lifecycle
   
   override func prepareForReuse() {
      cancelImageLoading()
      profileImageView.image = nil
   }
}

//MARK: - Public Functions

extension ProfileHeaderView {
   func setViewModel(_ viewModel: ProfileHeaderViewModel) {
      self.viewModel = viewModel
   }
   
   static func calculateHeight() -> CGFloat {
      let height = ThemeManager.sizes.separatorLineHeight + Constants.defaultVerticalPadding * 3 + Constants.profileImageSize + Constants.spacingM  + Constants.fullNameLabelFont.lineHeight + Constants.spacingXL + Constants.editProfileButtonHeight + Constants.segmentStackViewHeight
      return height
   }
}

//MARK: - Private Functions

private extension ProfileHeaderView {
   func updateView() {
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

private extension ProfileHeaderView {
   func updateColors() {
      backgroundColor = ThemeManager.colors.backgroundPrimary
   }
   
   func showLayoutColors(_ isEnabled: Bool) {
      if isEnabled {
         profileImageView.backgroundColor = .yellow
         fullNameLabel.backgroundColor = .red
         statsStackView.backgroundColor = .purple
         editProfileButton.backgroundColor = .orange
         segmentStackView.backgroundColor = .systemPink
      }
   }
}

//MARK: - Layout & Constraints

private extension ProfileHeaderView {
   func setupViews() {
      addSubview(topSeparatorView)
      addSubview(profileImageView)
      addSubview(fullNameLabel)
      
      addSubview(statsStackView)
      statsStackView.addArrangedSubview(postsButton)
      statsStackView.addArrangedSubview(followersButton)
      statsStackView.addArrangedSubview(followingsButton)
      
      addSubview(editProfileButton)
      addSubview(segmentStackView)
      segmentStackView.addArrangedSubview(gridButton)
      segmentStackView.addArrangedSubview(listButton)
      segmentStackView.addArrangedSubview(bookmarkButton)
      addSubview(bottomSeparatorView)
   }
   
   func setupConstraints() {
      
      profileImageView.snp.makeConstraints { make in
         make.top.equalToSuperview().inset(Constants.defaultVerticalPadding)
         make.leading.equalToSuperview().inset(Constants.defaultHorizontalPadding)
         make.size.equalTo(Constants.profileImageSize)
      }
      
      fullNameLabel.snp.makeConstraints { make in
         make.top.equalTo(profileImageView.snp.bottom).offset(Constants.spacingM)
         make.leading.equalToSuperview().inset(Constants.defaultHorizontalPadding)
      }
      
      statsStackView.snp.makeConstraints { make in
         make.leading.equalTo(profileImageView.snp.trailing).offset(Constants.defaultHorizontalPadding)
         make.trailing.equalToSuperview().inset(Constants.defaultHorizontalPadding)
         make.centerY.equalTo(profileImageView.snp.centerY)
      }
      
      editProfileButton.snp.makeConstraints { make in
         make.top.equalTo(fullNameLabel.snp.bottom).offset(Constants.spacingXL)
         make.leading.trailing.equalToSuperview().inset(Constants.defaultHorizontalPadding)
         make.height.equalTo(Constants.editProfileButtonHeight)
      }
      
      bottomSeparatorView.snp.makeConstraints { make in
         make.top.equalTo(editProfileButton.snp.bottom).offset(Constants.defaultVerticalPadding)
         make.leading.trailing.equalToSuperview()
         make.height.equalTo(ThemeManager.sizes.separatorLineHeight)
      }
      
      segmentStackView.snp.makeConstraints { make in
         make.top.equalTo(bottomSeparatorView.snp.bottom)
         make.leading.trailing.bottom.equalToSuperview()
         make.height.equalTo(Constants.segmentStackViewHeight)
      }
      
      gridButton.snp.makeConstraints { make in
         make.height.equalTo(Constants.segmentButtonSize)
      }
      
      listButton.snp.makeConstraints { make in
         make.height.equalTo(Constants.segmentButtonSize)
      }
      
      bookmarkButton.snp.makeConstraints { make in
         make.height.equalTo(Constants.segmentButtonSize)
      }
   }
}

//MARK: - Constants

private extension ProfileHeaderView {
   enum Constants {

      //Fonts
      static let fullNameLabelFont = ThemeManager.fonts.bodyMediumBold
      
      //Texts
      static let postsLabelText = "posts"
      static let followersLabelText = "followers"
      static let followingLabelText = "following"
      static let editProfileButtonText = "Edit Profile"
      static let defaultFullNameText = "Username"
      static let defaultStatsCount: Int = 0
      
      //Icons
      static let thumbnailImageName = "thumbnail"
      static let gridImageName = "square.grid.3x3.fill"
      static let listImageName = "list.triangle"
      static let bookmarkImageName = "bookmark"
      
      //Spacings
      static let spacingXS: CGFloat = ThemeManager.spacings.spacingXS
      static let spacingS: CGFloat = ThemeManager.spacings.spacingS
      static let spacingM: CGFloat = ThemeManager.spacings.spacingM
      static let spacingL: CGFloat = ThemeManager.spacings.spacingL
      static let spacingXL: CGFloat = ThemeManager.spacings.spacingXL
      static let defaultHorizontalPadding = spacingM
      static let defaultVerticalPadding = spacingM
      
      //Sizes
      static let profileImageSize: CGFloat = 80
      static let segmentButtonSize: CGFloat = 24
      static let segmentStackViewHeight: CGFloat = segmentButtonSize + spacingS * 2
      static let editProfileButtonHeight: CGFloat = 30
      static let profileImageCornerRadius: CGFloat = profileImageSize / 2
      static let editButtonCornerRadius: CGFloat = 5
      static let editButtonBorderWidth: CGFloat = 1
   }
}

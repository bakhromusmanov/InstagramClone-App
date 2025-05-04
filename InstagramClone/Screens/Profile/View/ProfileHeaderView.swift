//
//  ProfileHeaderView.swift
//  InstagramClone
//
//  Created by Bakhrom Usmanov on 02/05/25.
//

import Foundation
import UIKit

final class ProfileHeaderView: UICollectionReusableView {
   
   //MARK: - Subviews
   
   private let profileImageView: UIImageView = {
      let imageView = UIImageView(
         image: UIImage(named: ThemeManager.thumbnailImageName)
      )
      imageView.contentMode = .scaleAspectFill
      imageView.layer.cornerRadius = Constants.profileImageCornerRadius
      imageView.layer.masksToBounds = true
      return imageView
   }()
   
   private let fullNameLabel: UILabel = {
      let label = UILabel()
      label.text = Constants.defaultFullNameText
      label.textColor = ThemeManager.textPrimaryColor
      label.font = ThemeManager.titleBold
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
      button.setTitleColor(ThemeManager.textPrimaryColor, for: .normal)
      button.titleLabel?.font = ThemeManager.titleBold
      button.backgroundColor = ThemeManager.backgroundInputField
      button.layer.cornerRadius = Constants.editButtonCornerRadius
      button.layer.borderColor = ThemeManager.textSecondaryColor.cgColor
      button.layer.borderWidth = Constants.editButtonBorderWidth
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
   
   //MARK: - Public Functions
   
   static func calculateHeight() -> CGFloat {
      let height = Constants.defaultVerticalPadding * 2 + Constants.profileImageSize + Constants.spacingM  + ThemeManager.titleBold.lineHeight + Constants.spacingL + Constants.editProfileButtonHeight
      return height
   }
}

//MARK: - Appearance & Theming

private extension ProfileHeaderView {
   func updateColors() {
      backgroundColor = ThemeManager.backgroundPrimaryColor
   }
   
   func showLayoutColors(_ isEnabled: Bool) {
      if isEnabled {
         profileImageView.backgroundColor = .yellow
         fullNameLabel.backgroundColor = .red
         statsStackView.backgroundColor = .purple
         editProfileButton.backgroundColor = .orange
      }
   }
}

//MARK: - Layout & Constraints

private extension ProfileHeaderView {
   
   func setupViews() {
      addSubview(profileImageView)
      addSubview(fullNameLabel)
      
      addSubview(statsStackView)
      statsStackView.addArrangedSubview(postsButton)
      statsStackView.addArrangedSubview(followersButton)
      statsStackView.addArrangedSubview(followingsButton)
      
      addSubview(editProfileButton)
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
         make.top.equalTo(fullNameLabel.snp.bottom).offset(Constants.spacingL)
         make.leading.trailing.equalToSuperview().inset(Constants.defaultHorizontalPadding)
         make.bottom.equalToSuperview().inset(Constants.defaultVerticalPadding)
      }
      
   }
}

//MARK: - Constants

private extension ProfileHeaderView {
   enum Constants {
      
      //Namings
      static let postsLabelText = "posts"
      static let followersLabelText = "followers"
      static let followingLabelText = "following"
      static let editProfileButtonText = "Edit Profile"
      static let defaultFullNameText = "Username"
      static let defaultStatsCount: Int = 0
      
      //Spacings
      static let spacingXS: CGFloat = 4
      static let spacingS: CGFloat = 8
      static let spacingM: CGFloat = 12
      static let spacingL: CGFloat = 16
      static let spacingXL: CGFloat = 20
      static let defaultHorizontalPadding = spacingM
      static let defaultVerticalPadding = spacingL
      
      //Sizes
      static let profileImageSize: CGFloat = 80
      static let editProfileButtonHeight: CGFloat = 48
      static let profileImageCornerRadius: CGFloat = profileImageSize / 2
      static let editButtonCornerRadius: CGFloat = 5
      static let editButtonBorderWidth: CGFloat = 1
   }
}

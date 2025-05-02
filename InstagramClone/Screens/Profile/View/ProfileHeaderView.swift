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
      let imageView = UIImageView(image: UIImage(named: Constants.profileImageName))
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
      button.setupButton(title: Constants.postsLabelText, count: Constants.defaultCountText)
      return button
   }()
   
   private lazy var followersButton: ProfileStatsButton = {
      let button = ProfileStatsButton(type: .system)
      button.setupButton(title: Constants.followersLabelText, count: Constants.defaultCountText)
      return button
   }()
   
   private lazy var followingsButton: ProfileStatsButton = {
      let button = ProfileStatsButton(type: .system)
      button.setupButton(title: Constants.followingLabelText, count: Constants.defaultCountText)
      return button
   }()
   
   private lazy var editProfileButton: UIButton = {
      let button = UIButton(type: .system)
      button.setTitle(Constants.editProfileButtonText, for: .normal)
      button.setTitleColor(ThemeManager.textPrimaryColor, for: .normal)
      button.titleLabel?.font = ThemeManager.titleBold
      button.layer.cornerRadius = Constants.editButtonCornerRadius
      button.layer.borderColor = ThemeManager.textPrimaryColor.cgColor
      button.layer.borderWidth = Constants.editButtonBorderWidth
      return button
   }()
   
   //MARK: - Initialization
   
   override init(frame: CGRect) {
      super.init(frame: frame)
      backgroundColor = .yellow
      setupViews()
      setupConstraints()
   }
   
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
}

//MARK: - Layout & Constraints

private extension ProfileHeaderView {
   
   func setupViews() {
      addSubview(profileImageView)
      addSubview(fullNameLabel)
      
      addSubview(postsButton)
      addSubview(followersButton)
      addSubview(followingsButton)
      
      addSubview(editProfileButton)
   }
   
   func setupConstraints() {
      
      profileImageView.snp.makeConstraints { make in
         make.leading.top.equalToSuperview().inset(Constants.containerEdgesInset)
         make.size.equalTo(Constants.profileImageSize)
      }
      
      fullNameLabel.snp.makeConstraints { make in
         make.top.equalTo(profileImageView.snp.bottom).offset(Constants.imageToLabelOffset)
         make.leading.equalToSuperview().inset(Constants.containerEdgesInset)
      }
      
      postsButton.snp.makeConstraints { make in
         make.leading.equalTo(profileImageView.snp.trailing).offset(16)
         make.centerY.equalTo(profileImageView.snp.centerY)
      }
      
      followersButton.snp.makeConstraints { make in
         make.leading.equalTo(postsButton.snp.trailing).offset(16)
         make.centerY.equalTo(profileImageView.snp.centerY)
      }
      
      followingsButton.snp.makeConstraints { make in
         make.leading.equalTo(followersButton.snp.trailing).offset(16)
         make.centerY.equalTo(profileImageView.snp.centerY)
      }
      
      editProfileButton.snp.makeConstraints { make in
         make.bottom.leading.trailing.equalToSuperview().inset(Constants.containerEdgesInset)
      }
      
   }
}

//MARK: - Constants

private extension ProfileHeaderView {
   enum Constants {
      
      //Namings
      static let profileImageName = "thumbnail"
      static let postsLabelText = "posts"
      static let followersLabelText = "followers"
      static let followingLabelText = "following"
      static let editProfileButtonText = "Edit Profile"
      static let defaultFullNameText = "Username"
      static let defaultCountText = "0"

      //Spacings
      static let containerEdgesInset: CGFloat = 8
      static let imageToLabelOffset: CGFloat = 8
      
      //Sizes
      static let profileImageSize: CGFloat = 80
      static let editProfileButtonHeight: CGFloat = 20
      static let profileImageCornerRadius: CGFloat = profileImageSize / 2
      static let editButtonCornerRadius: CGFloat = 5
      static let editButtonBorderWidth: CGFloat = 2
   }
}

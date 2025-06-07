//
//  HomeCell.swift
//  InstagramClone
//
//  Created by Bakhrom Usmanov on 14/04/25.
//

import UIKit

final class HomeCell: UICollectionViewCell {
   
   //MARK: - Properties
   
   private var mediaHeight: CGFloat = 0
   
   //MARK: - Subviews
   
   private let headerView: UIView = {
      let view = UIView()
      view.backgroundColor = .clear
      return view
   }()
   
   private let actionsContainerView: UIView = {
      let view = UIView()
      view.backgroundColor = .clear
      return view
   }()
   
   private let actionsStackView: UIStackView = {
      let stackView = UIStackView()
      stackView.distribution = .fillEqually
      stackView.axis = .horizontal
      stackView.alignment = .center
      stackView.spacing = Constants.spacingS
      return stackView
   }()
   
   private let profileImageView: UIImageView = {
      let imageView = UIImageView(image: UIImage(named: Constants.thumbnailImageName))
      imageView.contentMode = .scaleAspectFill
      imageView.clipsToBounds = true
      imageView.layer.cornerRadius = Constants.profileImageCornerRadius
      return imageView
   }()
   
   private let mediaImageView: UIImageView = {
      let imageView = UIImageView(image: UIImage(named: Constants.placeholderImageName))
      imageView.contentMode = .scaleAspectFill
      return imageView
   }()
   
   private lazy var usernameButton: UIButton = {
      let button = UIButton(type: .system)
      button.setTitle(Constants.usernameButtonTitle, for: .normal)
      button.setTitleColor(ThemeManager.colors.textPrimaryDark, for: .normal)
      button.titleLabel?.font = Constants.usernameButtonFont
      return button
   }()
   
   private lazy var likeButton: UIButton = {
      let button = UIButton(type: .system)
      button.setImage(UIImage(systemName: Constants.likeUnselectedImageName), for: .normal)
      button.setImage(UIImage(systemName: Constants.likeSelectedImageName), for: .selected)
      button.imageView?.contentMode = .scaleAspectFill
      button.tintColor = ThemeManager.colors.textPrimaryDark
      return button
   }()
   
   private lazy var commentButton: UIButton = {
      let button = UIButton(type: .system)
      button.setImage(UIImage(systemName: Constants.commentUnselectedImageName), for: .normal)
      button.setImage(UIImage(systemName: Constants.commentSelectedImageName), for: .selected)
      button.imageView?.contentMode = .scaleAspectFill
      button.tintColor = ThemeManager.colors.textPrimaryDark
      return button
   }()
   
   private lazy var shareButton: UIButton = {
      let button = UIButton(type: .system)
      button.setImage(UIImage(systemName: Constants.shareUnselectedImageName), for: .normal)
      button.setImage(UIImage(systemName: Constants.shareSelectedImageName), for: .selected)
      button.imageView?.contentMode = .scaleAspectFill
      button.tintColor = ThemeManager.colors.textPrimaryDark
      return button
   }()
   
   private let footerView: UIView = {
      let view = UIView()
      view.backgroundColor = .clear
      return view
   }()
   
   private let likeCountLabel: UILabel = {
      let label = UILabel()
      label.text = Constants.likeCountButtonTitle
      label.font = Constants.likesCountLabelFont
      label.textAlignment = .left
      label.textColor = ThemeManager.colors.textPrimaryDark
      return label
   }()
   
   private let descriptionLabel: UILabel = {
      let label = UILabel()
      label.text = Constants.descriptionLabelTitle
      label.font = Constants.captionLabelFont
      label.textAlignment = .left
      label.textColor = ThemeManager.colors.textPrimaryDark
      return label
   }()
   
   private let timestampLabel: UILabel = {
      let label = UILabel()
      label.text = Constants.timestampLabelTitle
      label.font = Constants.timestampLabelFont
      label.textAlignment = .left
      label.textColor = ThemeManager.colors.textSecondaryDark
      return label
   }()
   
   //MARK: - Initialization
   
   override init(frame: CGRect) {
      super.init(frame: .zero)
      setupViews()
      setupConstraints()
      showLayoutColors(false)
   }
   
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
}

//MARK: - Public Functions

extension HomeCell {

   static var baseContentHeight: CGFloat {
      let height: CGFloat = Constants.profileImageViewSize + Constants.defaultVerticalPadding * 4 + Constants.actionButtonSize + Constants.likesCountLabelFont.lineHeight + Constants.captionLabelFont.lineHeight + Constants.timestampLabelFont.lineHeight
      return height
   }
   
   func setMediaHeight(_ mediaHeight: CGFloat) {
      self.mediaHeight = mediaHeight
      updateHeightConstraint()
   }

}

//MARK: - Private Functions



//MARK: - Appearance & Theming

private extension HomeCell {
   func showLayoutColors(_ isEnabled: Bool) {
      guard isEnabled else { return }
      profileImageView.backgroundColor = .red
      usernameButton.backgroundColor = .green
      headerView.backgroundColor = .blue
      mediaImageView.backgroundColor = .brown
      actionsContainerView.backgroundColor = .cyan
      actionsStackView.backgroundColor = .gray
      likeButton.backgroundColor = .orange
      commentButton.backgroundColor = .systemPink
      shareButton.backgroundColor = .systemTeal
      footerView.backgroundColor = .systemIndigo
      likeCountLabel.backgroundColor = .purple
      descriptionLabel.backgroundColor = .systemPink
      timestampLabel.backgroundColor = .yellow
   }
}

//MARK: - Layout & Constraints

private extension HomeCell {
   func updateHeightConstraint() {
      mediaImageView.snp.updateConstraints { update in
         update.height.equalTo(mediaHeight)
      }
   }
   
   func setupViews() {
      contentView.addSubview(headerView)
      contentView.addSubview(mediaImageView)
      contentView.addSubview(actionsContainerView)
      contentView.addSubview(footerView)
      
      headerView.addSubview(profileImageView)
      headerView.addSubview(usernameButton)
      
      actionsContainerView.addSubview(actionsStackView)
      actionsStackView.addArrangedSubview(likeButton)
      actionsStackView.addArrangedSubview(commentButton)
      actionsStackView.addArrangedSubview(shareButton)
      
      footerView.addSubview(likeCountLabel)
      footerView.addSubview(descriptionLabel)
      footerView.addSubview(timestampLabel)
   }
   
   func setupConstraints() {
      
      headerView.snp.makeConstraints { make in
         make.top.leading.trailing.equalToSuperview()
      }

      profileImageView.snp.makeConstraints { make in
         make.top.bottom.equalToSuperview().inset(Constants.defaultVerticalPadding)
         make.leading.equalToSuperview().inset(Constants.defaultVerticalPadding)
         make.size.equalTo(Constants.profileImageViewSize)
      }

      usernameButton.snp.makeConstraints { make in
         make.leading.equalTo(profileImageView.snp.trailing).offset(Constants.spacingS)
         make.centerY.equalTo(profileImageView.snp.centerY)
      }

      mediaImageView.snp.makeConstraints { make in
         make.top.equalTo(headerView.snp.bottom)
         make.leading.trailing.equalToSuperview()
         make.height.equalTo(mediaHeight)
      }
      
      actionsContainerView.snp.makeConstraints { make in
         make.top.equalTo(mediaImageView.snp.bottom)
         make.leading.trailing.equalToSuperview()
      }
      
      actionsStackView.snp.makeConstraints { make in
         make.top.bottom.equalToSuperview().inset(Constants.defaultVerticalPadding)
         make.leading.equalToSuperview().inset(Constants.defaultHorizontalPadding)
      }

      likeButton.snp.makeConstraints { make in
         make.size.equalTo(Constants.actionButtonSize)
      }
      
      commentButton.snp.makeConstraints { make in
         make.size.equalTo(Constants.actionButtonSize)
      }
      
      shareButton.snp.makeConstraints { make in
         make.size.equalTo(Constants.actionButtonSize)
      }
      
      footerView.snp.makeConstraints { make in
         make.top.equalTo(actionsContainerView.snp.bottom)
         make.leading.trailing.equalToSuperview()
         make.bottom.equalToSuperview()
      }

      likeCountLabel.snp.makeConstraints { make in
         make.top.equalToSuperview()
         make.leading.equalToSuperview().inset(Constants.defaultHorizontalPadding)
      }
      
      descriptionLabel.snp.makeConstraints { make in
         make.top.equalTo(likeCountLabel.snp.bottom).offset(Constants.spacingS)
         make.leading.equalToSuperview().inset(Constants.defaultHorizontalPadding)
      }
      
      timestampLabel.snp.makeConstraints { make in
         make.top.equalTo(descriptionLabel.snp.bottom).offset(Constants.spacingS)
         make.leading.equalToSuperview().inset(Constants.defaultHorizontalPadding)
         make.bottom.equalToSuperview()
      }
   }
}

//MARK: - Constants

private extension HomeCell {
   enum Constants {
      
      //Texts
      static let usernameButtonTitle = "user"
      static let likeCountButtonTitle = "1 like"
      static let descriptionLabelTitle = "Some test caption for now"
      static let timestampLabelTitle = "2 days ago"
      
      //Icons
      static let thumbnailImageName = "thumbnail"
      static let placeholderImageName = "placeholder"
      static let likeSelectedImageName = "heart.fill"
      static let likeUnselectedImageName = "heart"
      static let commentSelectedImageName = "message.fill"
      static let commentUnselectedImageName = "message"
      static let shareSelectedImageName = "paperplane.fill"
      static let shareUnselectedImageName = "paperplane"
      
      //Sizes
      static let actionButtonSize: CGFloat = 24
      static let profileImageViewSize: CGFloat = 50
      static let profileImageCornerRadius: CGFloat = profileImageViewSize / 2
      
      //Spacings
      static let spacingS: CGFloat = ThemeManager.spacings.spacingS
      static let defaultHorizontalPadding = ThemeManager.spacings.spacingM
      static let defaultVerticalPadding = ThemeManager.spacings.spacingM
      
      //Fonts
      static let usernameButtonFont: UIFont = ThemeManager.fonts.bodyMediumBold
      static let likesCountLabelFont: UIFont = ThemeManager.fonts.bodyMediumBold
      static let captionLabelFont: UIFont = ThemeManager.fonts.bodyMediumRegular
      static let timestampLabelFont: UIFont = ThemeManager.fonts.bodySmallRegular
   }
}

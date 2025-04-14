//
//  HomeCell.swift
//  InstagramClone
//
//  Created by Bakhrom Usmanov on 14/04/25.
//

import UIKit

final class HomeCell: UICollectionViewCell {
   
   //MARK: - Properties
   
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
      stackView.distribution = .fill
      stackView.axis = .horizontal
      stackView.alignment = .center
      stackView.spacing = Constants.labelToLabelOffset
      return stackView
   }()
   
   private let avatarImageView: UIImageView = {
      let imageView = UIImageView(image: UIImage(named: ThemeManager.avatarImageName))
      imageView.contentMode = .scaleAspectFit
      imageView.clipsToBounds = true
      imageView.layer.cornerRadius = Constants.avatarCornerRadius
      return imageView
   }()
   
   private let mediaImageView: UIImageView = {
      let imageView = UIImageView(image: UIImage(named: ThemeManager.mediaImageName))
      imageView.contentMode = .scaleAspectFit
      return imageView
   }()
   
   private lazy var usernameButton: UIButton = {
      let button = UIButton(type: .system)
      button.setTitle(Constants.usernameButtonTitle, for: .normal)
      button.setTitleColor(ThemeManager.textPrimaryColor, for: .normal)
      button.titleLabel?.font = ThemeManager.title
      return button
   }()
   
   private lazy var likeButton: UIButton = {
      let button = UIButton(type: .system)
      button.setImage(UIImage(systemName: ThemeManager.likeUnselectedImageName, withConfiguration: ThemeManager.config), for: .normal)
      button.setImage(UIImage(systemName: ThemeManager.likeSelectedImageName, withConfiguration: ThemeManager.config), for: .selected)
      button.imageView?.contentMode = .scaleAspectFit
      button.tintColor = ThemeManager.textPrimaryColor
      return button
   }()
   
   private lazy var commentButton: UIButton = {
      let button = UIButton(type: .system)
      button.setImage(UIImage(systemName: ThemeManager.commentUnselectedImageName, withConfiguration: ThemeManager.config), for: .normal)
      button.setImage(UIImage(systemName: ThemeManager.commentSelectedImageName, withConfiguration: ThemeManager.config), for: .selected)
      button.imageView?.contentMode = .scaleAspectFit
      button.tintColor = ThemeManager.textPrimaryColor
      return button
   }()
   
   private lazy var shareButton: UIButton = {
      let button = UIButton(type: .system)
      button.setImage(UIImage(systemName: ThemeManager.shareUnselectedImageName, withConfiguration: ThemeManager.config), for: .normal)
      button.setImage(UIImage(systemName: ThemeManager.shareSelectedImageName, withConfiguration: ThemeManager.config), for: .selected)
      button.imageView?.contentMode = .scaleAspectFit
      button.tintColor = ThemeManager.textPrimaryColor
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
      label.font = ThemeManager.subtitle
      label.textAlignment = .left
      label.tintColor = ThemeManager.textPrimaryColor
      return label
   }()
   
   private let captionLabel: UILabel = {
      let label = UILabel()
      label.text = Constants.captionLabelTitle
      label.font = ThemeManager.body
      label.textAlignment = .left
      label.tintColor = ThemeManager.textPrimaryColor
      return label
   }()
   
   private let timestampLabel: UILabel = {
      let label = UILabel()
      label.text = Constants.timestampLabelTitle
      label.font = ThemeManager.caption
      label.textAlignment = .left
      label.tintColor = ThemeManager.textSecondaryColor
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
   
   //MARK: - Public Functions
   
   //MARK: - Private Functions

}

//MARK: - Appearance & Theming
private extension HomeCell {
   func showLayoutColors(_ isEnabled: Bool) {
      guard isEnabled else { return }
      avatarImageView.backgroundColor = .red
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
      captionLabel.backgroundColor = .systemPink
      timestampLabel.backgroundColor = .yellow
   }
}

//MARK: - Layout & Constraints
private extension HomeCell {
   func setupViews() {
      contentView.addSubview(headerView)
      contentView.addSubview(mediaImageView)
      contentView.addSubview(actionsContainerView)
      contentView.addSubview(footerView)
      
      headerView.addSubview(avatarImageView)
      headerView.addSubview(usernameButton)
      
      actionsContainerView.addSubview(actionsStackView)
      actionsStackView.addArrangedSubview(likeButton)
      actionsStackView.addArrangedSubview(commentButton)
      actionsStackView.addArrangedSubview(shareButton)
      
      footerView.addSubview(likeCountLabel)
      footerView.addSubview(captionLabel)
      footerView.addSubview(timestampLabel)
   }
   
   func setupConstraints() {
      headerView.snp.makeConstraints { make in
         make.top.leading.trailing.equalToSuperview()
      }
      
      avatarImageView.snp.makeConstraints { make in
         make.top.leading.bottom.equalToSuperview().inset(Constants.containerEdgesInset)
         make.size.equalTo(Constants.avatarImageViewSize)
      }
      
      usernameButton.snp.makeConstraints { make in
         make.leading.equalTo(avatarImageView.snp.trailing).offset(Constants.labelToLabelOffset)
         make.centerY.equalTo(avatarImageView.snp.centerY)
      }
      
      mediaImageView.snp.makeConstraints { make in
         make.top.equalTo(headerView.snp.bottom)
         make.leading.trailing.equalToSuperview()
         make.height.equalTo(contentView.snp.width)
      }
      
      actionsContainerView.snp.makeConstraints { make in
         make.top.equalTo(mediaImageView.snp.bottom)
         make.leading.trailing.equalToSuperview()
      }
      
      actionsStackView.snp.makeConstraints { make in
         make.leading.top.bottom.equalToSuperview().inset(Constants.containerEdgesInset)
      }
      
      likeButton.snp.makeConstraints { make in
         make.size.equalTo(ThemeManager.actionButtonSize)
      }
      
      commentButton.snp.makeConstraints { make in
         make.size.equalTo(ThemeManager.actionButtonSize)
      }
      
      shareButton.snp.makeConstraints { make in
         make.size.equalTo(ThemeManager.actionButtonSize)
      }
      
      footerView.snp.makeConstraints { make in
         make.top.equalTo(actionsContainerView.snp.bottom)
         make.leading.trailing.equalToSuperview()
      }
      
      likeCountLabel.snp.makeConstraints { make in
         make.top.equalToSuperview()
         make.leading.equalToSuperview().inset(Constants.containerEdgesInset)
      }
      
      captionLabel.snp.makeConstraints { make in
         make.top.equalTo(likeCountLabel.snp.bottom).offset(Constants.containerEdgesInset)
         make.leading.equalToSuperview().inset(Constants.containerEdgesInset)
      }
      
      timestampLabel.snp.makeConstraints { make in
         make.top.equalTo(captionLabel.snp.bottom).offset(Constants.containerEdgesInset)
         make.leading.equalToSuperview().inset(Constants.containerEdgesInset)
         make.bottom.equalToSuperview()
      }
   }
}

//MARK: - Constants
extension HomeCell {
   enum Constants {
      static let usernameButtonTitle = "user"
      static let likeCountButtonTitle = "1 like"
      static let captionLabelTitle = "Some test caption for now"
      static let timestampLabelTitle = "2 days ago"
      
      //Spacings & Sizes
      static let avatarImageViewSize: CGFloat = 40
      static let avatarCornerRadius: CGFloat = avatarImageViewSize / 2
      static let containerEdgesInset: CGFloat = 8
      static let labelToLabelOffset: CGFloat = 8
   }
}

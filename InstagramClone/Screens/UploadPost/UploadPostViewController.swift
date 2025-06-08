//
//  UploadPostViewController.swift
//  InstagramClone
//
//  Created by Bakhrom Usmanov on 20/12/24.
//

import UIKit

final class UploadPostViewController: UIViewController {
   
   //MARK: - Properties
   
   //MARK: Subviews
   
   private let topSeparatorView: UIView = {
      let view = UIView()
      view.backgroundColor = Constants.separatorLineColor
      return view
   }()
   
   private let scrollView: UIScrollView = {
      let scrollView = UIScrollView()
      scrollView.showsVerticalScrollIndicator = false
      scrollView.alwaysBounceVertical = true
      scrollView.backgroundColor = Constants.backgroundPrimaryColor
      return scrollView
   }()
   
   private let scrollContentView = UIView()
   
   private let dashedView: RectangularDashedView = {
      let view = RectangularDashedView(strokeColor: Constants.dashedViewBorderColor, lineWidth: Constants.dashedViewBorderWidth)
      view.layer.cornerRadius = Constants.dashedViewCornerRadius
      return view
   }()
   
   private lazy var photoImageView: UIImageView = {
      let imageView = UIImageView()
      imageView.contentMode = .scaleAspectFill
      imageView.layer.cornerRadius = Constants.photoImageViewCornerRadius
      imageView.clipsToBounds = true
      imageView.isHidden = true
      return imageView
   }()
   
   private let addPhotoContainerView = UIView()
   
   private let addPhotoLabel: UILabel = {
      let label = UILabel()
      label.font = Constants.addPhotoLabelFont
      label.text = Constants.addPhotoLabelText
      label.textColor = Constants.textPrimaryColor
      label.textAlignment = .center
      return label
   }()
   
   private let tapToSelectPhotoLabel: UILabel = {
      let label = UILabel()
      label.font = Constants.tapToSelectPhotoLabelFont
      label.text = Constants.tapToSelectPhotoLabelText
      label.textColor = Constants.textPrimaryColor
      label.textAlignment = .center
      return label
   }()
   
   private lazy var selectPhotoButton: UIButton = {
      let button = UIButton(type: .system)
      button.setTitle(Constants.selectPhotoButtonText, for: .normal)
      button.setTitleColor(Constants.textPrimaryColor, for: .normal)
      button.titleLabel?.font = Constants.selectPhotoButtonFont
      button.backgroundColor = Constants.selectPhotoButtonBackgroundColor
      button.layer.cornerRadius = Constants.selectPhotoButtonCornerRadius
      button.contentEdgeInsets = UIEdgeInsets(
         top: Constants.buttonEdgesPadding,
         left: Constants.buttonEdgesPadding,
         bottom: Constants.buttonEdgesPadding,
         right: Constants.buttonEdgesPadding
      )
      button.addTarget(self, action: #selector(selectPhotoButtonTapped), for: .touchUpInside)
      return button
   }()
   
   private lazy var captionTextView: BaseTextView = {
      let textView = BaseTextView()
      textView.font = Constants.captionTextViewFont
      textView.textColor = Constants.textPrimaryColor
      textView.tintColor = Constants.captionTextViewTextColor
      textView.backgroundColor = Constants.captionTextViewBackgroundColor
      textView.layer.cornerRadius = Constants.captionTextViewCornerRadius
      textView.setPlaceholder(text: Constants.captionTextViewPlaceholderText, font: Constants.captionTextViewFont, color: Constants.captionTextViewTextColor)
      return textView
   }()
   
   //MARK: - Lifecycle
   
   override func viewDidLoad() {
      super.viewDidLoad()
      setupNavigationBar()
      setupViews()
      setupConstraints()
      updateColors()
   }
}

//MARK: - Public Methods

extension UploadPostViewController {
   
}

//MARK: - Private Methods

private extension UploadPostViewController {
   func setupNavigationBar() {
      navigationItem.title = Constants.navigationBarTitleText
      navigationItem.titleView?.tintColor = Constants.textPrimaryColor
      navigationController?.navigationBar.backgroundColor = Constants.backgroundSecondaryColor
      
      navigationItem.rightBarButtonItem = UIBarButtonItem(
         title: Constants.navigationRightBarItemText,
         style: .done,
         target: self,
         action: #selector(handleNextButtonTapped))
      navigationItem.rightBarButtonItem?.tintColor = Constants.textPrimaryColor
      
      navigationItem.leftBarButtonItem = UIBarButtonItem(
         title: Constants.navigationLeftBarItemText,
         style: .done,
         target: self,
         action: #selector(handleUndoButtonTapped))
      navigationItem.leftBarButtonItem?.tintColor = Constants.textPrimaryColor
      
      navigationBarButtons(isEnabled: false)
   }
   
   func updateView(with state: UploadPostViewState) {
      switch state {
      case .notSelectedPhoto:
         photoImageView.image = nil
         addPhotoContainerView.isHidden = false
         photoImageView.isHidden = true
         captionTextView.text.removeAll()
         captionTextView.handleTextDidChange()
         navigationBarButtons(isEnabled: false)
      case .didSelectPhoto:
         addPhotoContainerView.isHidden = true
         photoImageView.isHidden = false
         navigationBarButtons(isEnabled: true)
      }
      
      captionTextView.resignFirstResponder()
      updatePhotoImageHeight()
   }
   
   func navigationBarButtons(isEnabled: Bool) {
      navigationItem.leftBarButtonItem?.isEnabled = isEnabled
      navigationItem.rightBarButtonItem?.isEnabled = isEnabled
   }
}

//MARK: - Navigation

private extension UploadPostViewController {
   func navigateToHomeController() {
      if let tabBarController = self.tabBarController as? TabBarViewController {
         tabBarController.navigateToHomeAndRefresh()
      }
   }
}

//MARK: - Actions

@objc
private extension UploadPostViewController {
   func handleNextButtonTapped() {
      uploadPost()
   }
   
   func handleUndoButtonTapped() {
      updateView(with: .notSelectedPhoto)
   }
   
   func selectPhotoButtonTapped() {
      showPhotoPicker(delegate: self)
   }
}

//MARK: - Networking

private extension UploadPostViewController {
   func uploadPost() {
      guard let image = photoImageView.image, let caption = captionTextView.text else {
         return
      }
      
      PostService.shared.uploadPost(image: image, caption: caption) { error in
         guard error == nil else { return }
         self.navigateToHomeController()
         self.updateView(with: .notSelectedPhoto)
      }
   }
}

//MARK: - Appearance & Theming

private extension UploadPostViewController {
   func updateColors() {
      view.backgroundColor = Constants.backgroundSecondaryColor
   }
}

//MARK: - Layout & Constraints

private extension UploadPostViewController {
   
   func updatePhotoImageHeight() {
      if let image = photoImageView.image {
         let width = dashedView.bounds.width
         let aspectRatio = image.size.height / image.size.width
         let newHeight = width * aspectRatio
         
         dashedView.snp.updateConstraints { make in
            make.height.equalTo(newHeight)
         }
         return
      }
      
      dashedView.snp.updateConstraints { make in
         make.height.equalTo(Constants.dashedViewHeight)
      }
   }
   
   func setupViews() {
      view.addSubview(topSeparatorView)
      view.addSubview(scrollView)
      scrollView.addSubview(scrollContentView)
      
      scrollContentView.addSubview(dashedView)
      scrollContentView.addSubview(captionTextView)
      
      dashedView.addSubview(photoImageView)
      dashedView.addSubview(addPhotoContainerView)
      
      addPhotoContainerView.addSubview(addPhotoLabel)
      addPhotoContainerView.addSubview(tapToSelectPhotoLabel)
      addPhotoContainerView.addSubview(selectPhotoButton)
   }
   
   func setupConstraints() {
      topSeparatorView.snp.makeConstraints { make in
         make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
         make.leading.trailing.equalToSuperview()
         make.height.equalTo(Constants.separatorLineHeight)
      }
      
      scrollView.snp.makeConstraints { make in
         make.top.equalTo(topSeparatorView.snp.bottom)
         make.leading.trailing.bottom.equalToSuperview()
      }
      
      scrollContentView.snp.makeConstraints { make in
         make.edges.equalToSuperview()
         make.width.equalToSuperview()
      }
      
      dashedView.snp.makeConstraints { make in
         make.top.equalToSuperview().inset(Constants.verticalPadding)
         make.leading.trailing.equalToSuperview().inset(Constants.horizontalPadding)
         make.height.equalTo(Constants.dashedViewHeight)
      }
      
      photoImageView.snp.makeConstraints { make in
         make.edges.equalToSuperview()
      }
      
      addPhotoContainerView.snp.makeConstraints { make in
         make.leading.trailing.equalToSuperview()
         make.centerY.equalToSuperview()
      }
      
      addPhotoLabel.snp.makeConstraints { make in
         make.top.equalToSuperview()
         make.centerX.equalToSuperview()
      }
      
      tapToSelectPhotoLabel.snp.makeConstraints { make in
         make.top.equalTo(addPhotoLabel.snp.bottom).offset(Constants.labelToLabelSpacing)
         make.centerX.equalToSuperview()
      }
      
      selectPhotoButton.snp.makeConstraints { make in
         make.top.equalTo(tapToSelectPhotoLabel.snp.bottom).offset(Constants.labelToButtonSpacing)
         make.centerX.equalToSuperview()
         make.height.equalTo(Constants.selectPhotoButtonHeight)
         make.bottom.equalToSuperview()
      }
      
      captionTextView.snp.makeConstraints { make in
         make.top.equalTo(photoImageView.snp.bottom).offset(Constants.verticalPadding)
         make.leading.trailing.equalToSuperview().inset(Constants.horizontalPadding)
         make.height.equalTo(Constants.captionTextViewHeight)
         make.bottom.equalToSuperview().inset(Constants.verticalPadding)
      }
   }
}

//MARK: - UIImagePickerControllerDelegate & UINavigationControllerDelegate

extension UploadPostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
   func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
      guard let selectedImage = info[.editedImage] as? UIImage else { return }
      photoImageView.image = selectedImage
      updateView(with: .didSelectPhoto)
      dismiss(animated: true)
   }
   
   func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
      dismiss(animated: true)
   }
}

//MARK: - UploadPostViewState

private extension UploadPostViewController {
   enum UploadPostViewState {
      case notSelectedPhoto
      case didSelectPhoto
   }
}

//MARK: - Constants

private extension UploadPostViewController {
   enum Constants {
      //Texts
      static let navigationBarTitleText = "Upload Photo"
      static let navigationRightBarItemText = "Next"
      static let navigationLeftBarItemText = "Undo"
      static let addPhotoLabelText = "Add a photo"
      static let tapToSelectPhotoLabelText = "Tap to select a photo from your library."
      static let selectPhotoButtonText = "Select Photo"
      static let captionTextViewPlaceholderText = "Write a caption..."
      
      //Fonts
      static let addPhotoLabelFont = ThemeManager.fonts.bodyXLargeBold
      static let tapToSelectPhotoLabelFont = ThemeManager.fonts.bodyMediumRegular
      static let selectPhotoButtonFont = ThemeManager.fonts.bodyMediumBold
      static let captionTextViewFont = ThemeManager.fonts.bodyLargeMedium
      
      //Colors
      static let backgroundPrimaryColor = ThemeManager.colors.backgroundPrimary
      static let backgroundSecondaryColor = ThemeManager.colors.backgroundSecondary
      static let dashedViewBorderColor = ThemeManager.colors.border
      static let separatorLineColor = ThemeManager.colors.separatorLine
      static let selectPhotoButtonBackgroundColor = ThemeManager.colors.inputFieldBackground
      static let captionTextViewBackgroundColor = ThemeManager.colors.inputFieldBackground
      static let captionTextViewTextColor = ThemeManager.colors.textSecondaryDark
      static let textPrimaryColor = ThemeManager.colors.textPrimaryDark
      
      //Sizes
      static let separatorLineHeight = ThemeManager.sizes.separatorLineHeight
      static let photoImageViewCornerRadius: CGFloat = 8
      static let dashedViewBorderWidth: CGFloat = 2
      static let dashedViewCornerRadius: CGFloat = 8
      static let dashedViewHeight: CGFloat = 240
      static let selectPhotoButtonCornerRadius: CGFloat = 8
      static let selectPhotoButtonHeight = ThemeManager.sizes.componentHeightS
      static let captionTextViewHeight: CGFloat = 120
      static let captionTextViewCornerRadius: CGFloat = 5
      
      //Spacings
      static let horizontalPadding = ThemeManager.spacings.spacingL
      static let verticalPadding = ThemeManager.spacings.spacingL
      static let labelToLabelSpacing: CGFloat = 8
      static let labelToButtonSpacing: CGFloat = 32
      static let buttonEdgesPadding: CGFloat = 12
   }
}

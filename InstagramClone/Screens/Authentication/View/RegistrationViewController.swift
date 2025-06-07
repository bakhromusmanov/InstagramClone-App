//
//  RegistrationViewController.swift
//  InstagramClone
//
//  Created by Bakhrom Usmanov on 15/04/25.
//

import UIKit

final class RegistrationViewController: UIViewController {
   
   //MARK: - Properties
   
   private var viewModel = RegistrationViewModel()
   private weak var delegate: AuthDelegate?
   private var profileImage: UIImage?
   
   //MARK: - Subviews
   
   private lazy var addPhotoButton: UIButton = {
      let button = UIButton(type: .system)
      button.setBackgroundImage(UIImage(named: Constants.addPhotoImageName), for: .normal)
      button.imageView?.contentMode = .scaleAspectFill
      button.tintColor = Constants.addPhotoTintColor
      button.layer.masksToBounds = true
      button.addTarget(self, action: #selector(addPhotoButtonPressed), for: .touchUpInside)
      return button
   }()
   
   private let inputFieldsStackView: UIStackView = {
      let stackView = UIStackView()
      stackView.axis = .vertical
      stackView.distribution = .fill
      stackView.alignment = .fill
      stackView.spacing = Constants.fieldToFieldSpacing
      return stackView
   }()
   
   private lazy var emailTextField: BaseTextField = {
      let textField = BaseTextField(placeholder: Constants.emailPlaceholder)
      textField.keyboardType = .emailAddress
      textField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
      return textField
   }()
   
   private lazy var passwordTextField: BaseTextField = {
      let textField = BaseTextField(placeholder: Constants.passwordPlaceholder)
      textField.keyboardType = .asciiCapable
      textField.isSecureTextEntry = true
      textField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
      return textField
   }()
   
   private lazy var fullNameTextField: BaseTextField = {
      let textField = BaseTextField(placeholder: Constants.fullNamePlaceholder)
      textField.keyboardType = .asciiCapable
      textField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
      return textField
   }()
   
   private lazy var usernameTextField: BaseTextField = {
      let textField = BaseTextField(placeholder: Constants.usernamePlaceholder)
      textField.keyboardType = .namePhonePad
      textField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
      return textField
   }()
   
   private lazy var signUpButton: CustomButton = {
      let button = CustomButton(type: .system)
      button.updateStyle(isValid: false)
      button.setTitle(Constants.signUpButtonTitle, for: .normal)
      button.addTarget(self, action: #selector(signUpButtonPressed), for: .touchUpInside)
      return button
   }()
   
   private lazy var haveAccountButton: UIButton = {
      let button = UIButton(type: .system)
      button.setTitleColor(ThemeManager.colors.textSecondaryLight, for: .normal)
      button.setDualTitle(regularText: Constants.haveAccountTitle, boldText: Constants.loginTitle)
      button.addTarget(self, action: #selector(haveAccountButtonPressed), for: .touchUpInside)
      return button
   }()
   
   //MARK: - Lifecycle
   
   override func viewDidLoad() {
      super.viewDidLoad()
      setupViews()
      setupConstraints()
      setupNavigationBar()
      updateColors()
   }
}

//MARK: - Actions

@objc
private extension RegistrationViewController {
   func signUpButtonPressed(sender: UIButton) {
      var user = AuthEntity(
         email: viewModel.email,
         password: viewModel.password,
         fullName: viewModel.fullName,
         username: viewModel.username
      )
      
      //MARK: ImageUploaderService
      
      if let profileImage {
         ImageUploaderService.uploadProfileImage(username: user.username, image: profileImage, completion: { downloadURL in
            user.profileImageURL = downloadURL
            self.register(user: user)
         })
      } else {
         register(user: user)
      }
   }
   
   func haveAccountButtonPressed(sender: UIButton) {
      showLoginController()
   }
   
   func addPhotoButtonPressed(sender: UIButton) {
      showPhotoPicker(delegate: self)
   }
   
   func textDidChange(sender: UITextField) {
      guard let text = sender.text else { return }
      
      switch sender {
      case emailTextField:
         viewModel.email = text
      case passwordTextField:
         viewModel.password = text
      case fullNameTextField:
         viewModel.fullName = text
      case usernameTextField:
         viewModel.username = text.lowercased()
      default: return
      }
      
      signUpButton.updateStyle(isValid: viewModel.isValid)
   }
}

//MARK: - Public Functions

extension RegistrationViewController {
   func setDelegate(_ delegate: AuthDelegate?) {
      self.delegate = delegate
   }
}

//MARK: - Private Functions

private extension RegistrationViewController {
   func setupNavigationBar() {
      navigationBar(isHidden: true)
   }
   
   func showLoginController() {
      navigationController?.popViewController(animated: true)
   }
}

//MARK: - Appearance & Theming

private extension RegistrationViewController {
   func updateColors() {
      view.setGradientBackground(startColor: ThemeManager.colors.secondary, endColor: ThemeManager.colors.primary)
   }
   
   func updateSignUpButton(isEnabled: Bool) {
      
   }
}

//MARK: - Layout & Constraints

private extension RegistrationViewController {
   func setupViews() {
      view.addSubview(addPhotoButton)
      view.addSubview(inputFieldsStackView)
      view.addSubview(haveAccountButton)
      
      inputFieldsStackView.addArrangedSubview(emailTextField)
      inputFieldsStackView.addArrangedSubview(passwordTextField)
      inputFieldsStackView.addArrangedSubview(fullNameTextField)
      inputFieldsStackView.addArrangedSubview(usernameTextField)
      inputFieldsStackView.addArrangedSubview(signUpButton)
   }
   
   func setupConstraints() {
      addPhotoButton.snp.makeConstraints { make in
         make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(Constants.defaultTopPadding)
         make.centerX.equalToSuperview()
         make.height.equalTo(Constants.addPhotoButtonHeight)
         make.width.equalTo(Constants.addPhotoButtonWidth)
      }
      
      inputFieldsStackView.snp.makeConstraints { make in
         make.top.equalTo(addPhotoButton.snp.bottom).offset(Constants.addPhotoToInputFieldSpacing)
         make.leading.trailing.equalToSuperview().inset(Constants.defaultHorizontalPadding)
      }
      
      emailTextField.snp.makeConstraints { make in
         make.height.equalTo(Constants.inputFieldHeight)
      }
      
      passwordTextField.snp.makeConstraints { make in
         make.height.equalTo(Constants.inputFieldHeight)
      }
      
      fullNameTextField.snp.makeConstraints { make in
         make.height.equalTo(Constants.inputFieldHeight)
      }
      
      usernameTextField.snp.makeConstraints { make in
         make.height.equalTo(Constants.inputFieldHeight)
      }
      
      signUpButton.snp.makeConstraints { make in
         make.height.equalTo(Constants.inputFieldHeight)
      }
      
      haveAccountButton.snp.makeConstraints { make in
         make.bottom.equalTo(view.snp.bottomMargin).inset(Constants.defaultBottomPadding)
         make.centerX.equalToSuperview()
         make.height.equalTo(haveAccountButton.titleLabel?.font.lineHeight.rounded(.up) ?? Constants.inputFieldHeight)
      }
   }
}

//MARK: Networking

private extension RegistrationViewController {
   func register(user: AuthEntity) {
      AuthService.shared.register(authEntity: user) { error in
         if let error {
            print("DEBUG: Error while registering user: \(error.localizedDescription)")
            return
         }
         
         self.delegate?.authDidComplete()
         self.dismiss(animated: true)
      }
   }
}

//MARK: - UIImagePickerControllerDelegate

extension RegistrationViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
   func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
      guard let selectedImage = info[.editedImage] as? UIImage else { return }
      profileImage = selectedImage
      addPhotoButton.setBackgroundImage(profileImage, for: .normal)
      addPhotoButton.layer.cornerRadius = Constants.addPhotoButtonCornerRadius
      addPhotoButton.layer.borderWidth = Constants.addPhotoButtonBorderWidth
      addPhotoButton.layer.borderColor = Constants.addPhotoButtonBorderColor
      dismiss(animated: true)
   }
   
   func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
      dismiss(animated: true)
   }
}

//MARK: - Constants

private extension RegistrationViewController {
   enum Constants {
      static let addPhotoTintColor = UIColor.white
      static let addPhotoButtonBorderColor: CGColor = UIColor.white.cgColor
      
      static let addPhotoImageName = "plusPhoto"
      static let emailPlaceholder = "Email"
      static let passwordPlaceholder = "Password"
      static let fullNamePlaceholder = "Fullname"
      static let usernamePlaceholder = "Username"
      static let signUpButtonTitle = "Sign Up"
      static let haveAccountTitle = "Already have an account? "
      static let loginTitle = "Log In"
      
      static let addPhotoButtonHeight: CGFloat = 140
      static let addPhotoButtonWidth: CGFloat = 140
      static let addPhotoButtonCornerRadius: CGFloat = addPhotoButtonWidth / 2
      static let addPhotoButtonBorderWidth: CGFloat = 3
      static let inputFieldHeight: CGFloat = ThemeManager.sizes.defaultTextFieldHeight
      
      static let defaultTopPadding: CGFloat = 32
      static let defaultHorizontalPadding: CGFloat = 32
      static let defaultBottomPadding: CGFloat = ThemeManager.spacings.spacingS
      static let addPhotoToInputFieldSpacing: CGFloat = 32
      static let fieldToFieldSpacing: CGFloat = 20
   }
}

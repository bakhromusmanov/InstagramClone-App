//
//  RegistrationViewController.swift
//  InstagramClone
//
//  Created by Bakhrom Usmanov on 15/04/25.
//

import UIKit

final class RegistrationViewController: UIViewController {
   
   //MARK: - Properties
   
   //MARK: - Subviews
   private lazy var addPhotoButton: UIButton = {
      let button = UIButton(type: .system)
      button.setBackgroundImage(UIImage(named: Constants.addPhotoImageName), for: .normal)
      button.imageView?.contentMode = .scaleAspectFill
      button.tintColor = Constants.addPhotoTintColor
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
   
   private let emailTextField: CustomTextField = {
      let textField = CustomTextField(placeholder: Constants.emailPlaceholder)
      textField.keyboardType = .emailAddress
      return textField
   }()
   
   private let passwordTextField: CustomTextField = {
      let textField = CustomTextField(placeholder: Constants.passwordPlaceholder)
      textField.isSecureTextEntry = true
      return textField
   }()
   
   private let fullNameTextField: CustomTextField = {
      let textField = CustomTextField(placeholder: Constants.fullNamePlaceholder)
      return textField
   }()
   
   private let usernameTextField: CustomTextField = {
      let textField = CustomTextField(placeholder: Constants.usernamePlaceholder)
      return textField
   }()
   
   private lazy var signUpButton: CustomButton = {
      let button = CustomButton(type: .system)
      button.setTitle(Constants.signUpButtonTitle, for: .normal)
      return button
   }()
   
   private lazy var haveAccountButton: UIButton = {
      let button = UIButton(type: .system)
      button.setTitleColor(ThemeManager.inputFieldSecondaryColor, for: .normal)
      button.setDualTitle(regularText: Constants.haveAccountTitle, boldText: Constants.loginTitle)
      button.addTarget(self, action: #selector(haveAccountButtonPressed), for: .touchUpInside)
      return button
   }()
   
   //MARK: - Lifecycle
   override func viewDidLoad() {
      super.viewDidLoad()
      setupViews()
      setupConstraints()
      updateColors()
      navigationBar(isHidden: true)
   }
   
   //MARK: - Private Functions
   private func showLoginController() {
      navigationController?.popViewController(animated: true)
   }
   
   //MARK: - Actions
   @objc private func addPhotoButtonPressed() {
      
   }
   
   @objc private func haveAccountButtonPressed() {
      showLoginController()
   }
}

//MARK: - Appearance & Theming
private extension RegistrationViewController {
   func updateColors() {
      setGradientBackground(startColor: ThemeManager.accentSecondaryColor, endColor: ThemeManager.accentPrimaryColor)
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
         make.top.equalTo(view.snp.topMargin).inset(Constants.contentTopInset)
         make.centerX.equalToSuperview()
         make.height.equalTo(Constants.addPhotoButtonHeight)
         make.width.equalTo(Constants.addPhotoButtonWidth)
      }
      
      inputFieldsStackView.snp.makeConstraints { make in
         make.top.equalTo(addPhotoButton.snp.bottom).offset(Constants.addPhotoToInputFieldSpacing)
         make.leading.trailing.equalToSuperview().inset(Constants.contentLeftRightInset)
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
         make.bottom.equalTo(view.snp.bottomMargin).inset(Constants.contentBottomInset)
         make.centerX.equalToSuperview()
         make.height.equalTo(haveAccountButton.titleLabel?.font.lineHeight.rounded(.up) ?? Constants.inputFieldHeight)
      }
   }
}


//MARK: - Constants
private extension RegistrationViewController {
   enum Constants {
      static let addPhotoTintColor = UIColor.white
      
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
      static let inputFieldHeight: CGFloat = 50
      
      static let contentTopInset: CGFloat = 32
      static let contentLeftRightInset: CGFloat = 32
      static let contentBottomInset: CGFloat = 8
      static let addPhotoToInputFieldSpacing: CGFloat = 32
      static let fieldToFieldSpacing: CGFloat = 20
   }
}

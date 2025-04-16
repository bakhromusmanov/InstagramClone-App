//
//  LoginViewController.swift
//  InstagramClone
//
//  Created by Bakhrom Usmanov on 15/04/25.
//

import UIKit

final class LoginViewController: UIViewController {
   
   //MARK: - Properties
   
   //MARK: - Subviews
   private let logoImageView: UIImageView = {
      let imageView = UIImageView(image: UIImage(named: Constants.logoImageName))
      imageView.contentMode = .scaleAspectFill
      imageView.tintColor = Constants.logoTintColor
      return imageView
   }()
   
   private let inputFieldsStackView: UIStackView = {
      let stackView = UIStackView()
      stackView.axis = .vertical
      stackView.alignment = .fill
      stackView.distribution = .fill
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
      textField.keyboardType = .default
      textField.isSecureTextEntry = true
      return textField
   }()
   
   private lazy var loginButton: CustomButton = {
      let button = CustomButton(type: .system)
      button.setTitle(Constants.loginButtonTitle, for: .normal)
      return button
   }()
   
   private lazy var forgotPasswordButton: UIButton = {
      let button = UIButton(type: .system)
      button.setTitleColor(ThemeManager.inputFieldSecondaryColor, for: .normal)
      button.setDualTitle(regularText: Constants.forgotPasswordTitle, boldText: Constants.getHelpTitle)
      return button
   }()
   
   private lazy var signUpButton: UIButton = {
      let button = UIButton(type: .system)
      button.setTitleColor(ThemeManager.inputFieldSecondaryColor, for: .normal)
      button.setDualTitle(regularText: Constants.dontHaveAccountTitle, boldText: Constants.signUpTitle)
      button.addTarget(self, action: #selector(signUpButtonPressed), for: .touchUpInside)
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
   
   //MARK: - Public Functions
   
   //MARK: - Private Functions
   private func showRegistrationController() {
      let controller = RegistrationViewController()
      navigationController?.pushViewController(controller, animated: true)
   }
   
   //MARK: - Actions
   @objc private func signUpButtonPressed(sender: UIButton) {
      showRegistrationController()
   }
}

//MARK: - Appearance & Theming
private extension LoginViewController {
   func updateColors() {
      setGradientBackground(startColor: ThemeManager.accentSecondaryColor, endColor: ThemeManager.accentPrimaryColor)
   }
}

//MARK: - Layout & Constraints
private extension LoginViewController {
   func setupViews() {
      view.addSubview(logoImageView)
      view.addSubview(inputFieldsStackView)
      view.addSubview(signUpButton)
      
      inputFieldsStackView.addArrangedSubview(emailTextField)
      inputFieldsStackView.addArrangedSubview(passwordTextField)
      inputFieldsStackView.addArrangedSubview(loginButton)
      inputFieldsStackView.addArrangedSubview(forgotPasswordButton)
   }
   
   func setupConstraints() {
      logoImageView.snp.makeConstraints { make in
         make.top.equalTo(view.snp.topMargin).inset(Constants.contentTopInset)
         make.centerX.equalToSuperview()
         make.width.equalTo(Constants.logoImageViewWidth)
         make.height.equalTo(Constants.logoImageViewHeight)
      }
      
      inputFieldsStackView.snp.makeConstraints { make in
         make.top.equalTo(logoImageView.snp.bottom).offset(Constants.logoToInputFieldSpacing)
         make.leading.trailing.equalToSuperview().inset(Constants.contentLeftRightInset)
      }
      
      emailTextField.snp.makeConstraints { make in
         make.height.equalTo(Constants.inputFieldHeight)
      }
      
      passwordTextField.snp.makeConstraints { make in
         make.height.equalTo(Constants.inputFieldHeight)
      }
      
      loginButton.snp.makeConstraints { make in
         make.height.equalTo(Constants.inputFieldHeight)
      }
      
      forgotPasswordButton.snp.makeConstraints { make in
         make.height.equalTo(forgotPasswordButton.titleLabel?.font.lineHeight.rounded(.up) ?? Constants.inputFieldHeight)
      }
      
      signUpButton.snp.makeConstraints { make in
         make.bottom.equalTo(view.snp.bottomMargin).inset(Constants.contentBottomInset)
         make.centerX.equalToSuperview()
         make.height.equalTo(forgotPasswordButton.titleLabel?.font.lineHeight.rounded(.up) ?? Constants.inputFieldHeight)
      }
   }
}

//MARK: - Constants
private extension LoginViewController {
   enum Constants {
      static let logoTintColor = UIColor.white
      
      static let logoImageName = "instagramLogoText"
      static let emailPlaceholder = "Email"
      static let passwordPlaceholder = "Password"
      static let loginButtonTitle = "Log In"
      static let forgotPasswordTitle = "Forgot your password? "
      static let getHelpTitle = "Get help signing in."
      static let dontHaveAccountTitle = "Don't have an account? "
      static let signUpTitle = "Sign Up"
      
      static let logoImageViewHeight: CGFloat = 80
      static let logoImageViewWidth: CGFloat = 120
      static let inputFieldHeight: CGFloat = 50
      
      static let contentTopInset: CGFloat = 32
      static let contentLeftRightInset: CGFloat = 32
      static let contentBottomInset: CGFloat = 8
      static let logoToInputFieldSpacing: CGFloat = 32
      static let fieldToFieldSpacing: CGFloat = 20
   }
}

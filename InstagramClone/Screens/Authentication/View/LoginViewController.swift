//
//  LoginViewController.swift
//  InstagramClone
//
//  Created by Bakhrom Usmanov on 15/04/25.
//

import UIKit

final class LoginViewController: UIViewController {
   
   //MARK: - Properties
   
   private var viewModel = LoginViewModel()
   private weak var delegate: AuthDelegate?
   
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
   
   private lazy var emailTextField: CustomTextField = {
      let textField = CustomTextField(placeholder: Constants.emailPlaceholder)
      textField.keyboardType = .emailAddress
      textField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
      return textField
   }()
   
   private lazy var passwordTextField: CustomTextField = {
      let textField = CustomTextField(placeholder: Constants.passwordPlaceholder)
      textField.keyboardType = .asciiCapable
      textField.isSecureTextEntry = true
      textField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
      return textField
   }()
   
   private lazy var loginButton: CustomButton = {
      let button = CustomButton(type: .system)
      button.updateStyle(isValid: false)
      button.setTitle(Constants.loginButtonTitle, for: .normal)
      button.addTarget(self, action: #selector(logInButtonPressed), for: .touchUpInside)
      return button
   }()
   
   private lazy var forgotPasswordButton: UIButton = {
      let button = UIButton(type: .system)
      button.setTitleColor(ThemeManager.colors.disabled, for: .normal)
      button.setDualTitle(regularText: Constants.forgotPasswordTitle, boldText: Constants.getHelpTitle)
      button.addTarget(self, action: #selector(forgotPasswordButtonPressed), for: .touchUpInside)
      return button
   }()
   
   private lazy var signUpButton: UIButton = {
      let button = UIButton(type: .system)
      button.setTitleColor(ThemeManager.colors.disabled, for: .normal)
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
   
   func setDelegate(_ delegate: AuthDelegate) {
      self.delegate = delegate
   }
   
   //MARK: - Private Functions
   
   private func showRegistrationController() {
      let controller = RegistrationViewController()
      controller.setDelegate(delegate)
      navigationController?.pushViewController(controller, animated: true)
   }
   
   
   //MARK: - Actions
   
   @objc private func signUpButtonPressed(sender: UIButton) {
      showRegistrationController()
   }
   
   @objc private func forgotPasswordButtonPressed(sender: UIButton) {
      
   }
   
   @objc private func textDidChange(sender: UITextField) {
      guard let text = sender.text else { return }
      
      switch sender {
      case emailTextField:
         viewModel.email = text
      case passwordTextField:
         viewModel.password = text
      default: return
      }
      
      loginButton.updateStyle(isValid: viewModel.isValid)
   }
}

//MARK: Networking

private extension LoginViewController {
   @objc private func logInButtonPressed(sender: UIButton) {
      AuthService.login(withEmail: viewModel.email, password: viewModel.password) { result, error in
         if let error {
            print("DEBUG: Error while logging in user: \(error.localizedDescription)")
            return
         }
         
         self.delegate?.authDidComplete()
         self.dismiss(animated: true)
      }
   }
}

//MARK: - Appearance & Theming

private extension LoginViewController {
   func updateColors() {
      setGradientBackground(startColor: ThemeManager.colors.secondary, endColor: ThemeManager.colors.primary)
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
         make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(Constants.defaultTopPadding)
         make.centerX.equalToSuperview()
         make.width.equalTo(Constants.logoImageViewWidth)
         make.height.equalTo(Constants.logoImageViewHeight)
      }
      
      inputFieldsStackView.snp.makeConstraints { make in
         make.top.equalTo(logoImageView.snp.bottom).offset(Constants.logoToInputFieldSpacing)
         make.leading.trailing.equalToSuperview().inset(Constants.defaultHorizontalPadding)
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
         make.bottom.equalTo(view.snp.bottomMargin).inset(Constants.defaultBottomPadding)
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
      
      static let defaultTopPadding: CGFloat = 32
      static let defaultHorizontalPadding: CGFloat = 32
      static let defaultBottomPadding: CGFloat = ThemeManager.spacings.spacingS
      static let logoToInputFieldSpacing: CGFloat = 32
      static let fieldToFieldSpacing: CGFloat = 20
   }
}

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
   
   private let emailTextField: UITextField = {
      let textField = UITextField()
      textField.keyboardType = .emailAddress
      textField.borderStyle = .roundedRect
      textField.backgroundColor = ThemeManager.backgroundInputField
      textField.textColor = ThemeManager.inputFieldPrimaryColor
      textField.font = ThemeManager.inputFieldRegularFont

      let placeholderAttributes: [NSAttributedString.Key: Any] = [
         .foregroundColor : ThemeManager.inputFieldSecondaryColor,
         .font : ThemeManager.inputFieldRegularFont]
      textField.attributedPlaceholder = NSAttributedString(string: Constants.emailPlaceholder, attributes: placeholderAttributes)
      return textField
   }()
   
   private let passwordTextField: UITextField = {
      let textField = UITextField()
      textField.keyboardType = .default
      textField.borderStyle = .roundedRect
      textField.backgroundColor = ThemeManager.backgroundInputField
      textField.textColor = ThemeManager.inputFieldPrimaryColor
      textField.font = ThemeManager.inputFieldRegularFont
      textField.isSecureTextEntry = true

      let placeholderAttributes: [NSAttributedString.Key: Any] = [
         .foregroundColor : ThemeManager.inputFieldSecondaryColor,
         .font : ThemeManager.inputFieldRegularFont]
      textField.attributedPlaceholder = NSAttributedString(string: Constants.passwordPlaceholder, attributes: placeholderAttributes)
      return textField
   }()
   
   private lazy var loginButton: UIButton = {
      let button = UIButton(type: .system)
      button.titleLabel?.font = ThemeManager.inputFieldBoldFont
      button.setTitleColor(ThemeManager.inputFieldPrimaryColor, for: .normal)
      button.setTitle(Constants.loginButtonTitle, for: .normal)
      button.backgroundColor = ThemeManager.buttonPrimaryColor
      button.layer.cornerRadius = Constants.loginButtonCornerRadius
      return button
   }()
   
   private lazy var forgotPasswordButton: UIButton = {
      let button = UIButton(type: .system)
      button.setTitleColor(ThemeManager.inputFieldSecondaryColor, for: .normal)
      
      let titleAttributes: [NSAttributedString.Key: Any] = [.font: ThemeManager.titleRegular]
      
      let titleBoldAttributes: [NSAttributedString.Key: Any] = [.font: ThemeManager.titleBold]
      
      let attributedTitle = NSMutableAttributedString(string: Constants.forgotPasswordTitle, attributes: titleAttributes)
      attributedTitle.append(NSAttributedString(string: Constants.getHelpTitle, attributes: titleBoldAttributes))
      
      button.setAttributedTitle(attributedTitle, for: .normal)
      return button
   }()
   
   private lazy var signUpButton: UIButton = {
      let button = UIButton(type: .system)
      button.setTitleColor(ThemeManager.inputFieldSecondaryColor, for: .normal)
      
      let titleAttributes: [NSAttributedString.Key: Any] = [.font: ThemeManager.titleRegular]
      
      let titleBoldAttributes: [NSAttributedString.Key: Any] = [.font: ThemeManager.titleBold]
      
      let attributedTitle = NSMutableAttributedString(string: Constants.dontHaveAccountTitle, attributes: titleAttributes)
      attributedTitle.append(NSAttributedString(string: Constants.signUpTitle, attributes: titleBoldAttributes))
      
      button.setAttributedTitle(attributedTitle, for: .normal)
      return button
   }()
   
   //MARK: - Lifecycle
   override func viewDidLoad() {
      super.viewDidLoad()
      setupViews()
      setupConstraints()
      updateColors()
   }
   
   //MARK: Public Functions
   
   //MARK: Private Functions
}

//MARK: - Appearance & Theming
private extension LoginViewController {
   func updateColors() {
      let gradientLayer = ThemeManager.primaryGradientLayer
      view.layer.insertSublayer(gradientLayer, at: 0)
      gradientLayer.frame = view.frame
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
      
      static let loginButtonCornerRadius: CGFloat = 5
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

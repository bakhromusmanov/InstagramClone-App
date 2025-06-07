//
//  BaseTextField.swift
//  InstagramClone
//
//  Created by Bakhrom Usmanov on 16/04/25.
//

import UIKit

final class BaseTextField: UITextField {
   
   //MARK: - Initialization
   
   init(placeholder: String) {
      super.init(frame: .zero)
      backgroundColor = Constants.backgroundColor
      textColor = Constants.textColor
      font = Constants.textFont
      layer.cornerRadius = Constants.cornerRadius
      setPlaceholder(text: placeholder, color: Constants.placeholderTextColor, font: Constants.textFont)
   }
   
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
   //MARK: - Private Methods
   
   func setPlaceholder(text: String, color: UIColor, font: UIFont) {
      let placeholderAttributes: [NSAttributedString.Key: Any] = [
         .foregroundColor : color,
         .font : font]
      attributedPlaceholder = NSAttributedString(string: text, attributes: placeholderAttributes)
   }
   
   //MARK: - Custom Padding
   
   override func textRect(forBounds bounds: CGRect) -> CGRect {
      return bounds.inset(by: UIEdgeInsets(top: 0, left: Constants.horizontalPadding, bottom: 0, right: Constants.horizontalPadding))
   }
   
   override func editingRect(forBounds bounds: CGRect) -> CGRect {
      return textRect(forBounds: bounds)
   }
   
}

//MARK: - Constants

private extension BaseTextField {
   enum Constants {
      static let cornerRadius: CGFloat = 5
      static let horizontalPadding: CGFloat = 12
      static let backgroundColor = ThemeManager.colors.whiteOpacity10
      static let textFont = ThemeManager.fonts.bodyLargeRegular
      static let textColor = ThemeManager.colors.textPrimaryLight
      static let placeholderTextColor = ThemeManager.colors.textSecondaryLight
   }
}

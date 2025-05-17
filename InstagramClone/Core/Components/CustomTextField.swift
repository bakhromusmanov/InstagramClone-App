//
//  CustomTextField.swift
//  InstagramClone
//
//  Created by Bakhrom Usmanov on 16/04/25.
//

import UIKit

final class CustomTextField: UITextField {
   
   //MARK: - Initialization
   
   init(placeholder: String) {
      super.init(frame: .zero)
      
      borderStyle = .roundedRect
      backgroundColor = ThemeManager.colors.whiteOpacity10
      textColor = ThemeManager.colors.textPrimaryLight
      font = ThemeManager.fonts.bodyLargeRegular
      
      let placeholderAttributes: [NSAttributedString.Key: Any] = [
         .foregroundColor : ThemeManager.colors.textPrimaryLight,
         .font : ThemeManager.fonts.bodyLargeRegular]
      attributedPlaceholder = NSAttributedString(string: placeholder, attributes: placeholderAttributes)
   }
   
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
   //MARK: - Custom Content Inset
   
   override func textRect(forBounds bounds: CGRect) -> CGRect {
      return bounds.inset(by: UIEdgeInsets(top: 0, left: Constants.contentLeftRightInset, bottom: 0, right: Constants.contentLeftRightInset))
   }
   
   override func editingRect(forBounds bounds: CGRect) -> CGRect {
      return textRect(forBounds: bounds)
   }
   
}

//MARK: - Constants

private extension CustomTextField {
   enum Constants {
      static let contentLeftRightInset: CGFloat = 12
   }
}

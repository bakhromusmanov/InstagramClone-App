//
//  CustomButton.swift
//  InstagramClone
//
//  Created by Bakhrom Usmanov on 16/04/25.
//

import UIKit

final class CustomButton: UIButton {
   
   //MARK: - Initialization
   
   override init(frame: CGRect) {
      super.init(frame: frame)
      titleLabel?.font = Constants.textFont
      layer.cornerRadius = Constants.cornerRadius
      setTitleColor(Constants.textColor, for: .normal)
      backgroundColor = Constants.backgroundColor
   }
   
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
   //MARK: - Public Functions
   
   func updateStyle(isValid: Bool) {
      isEnabled = isValid
      alpha = isValid ? Constants.enabledAlpha : Constants.disabledAlpha
   }
}

//MARK: - Constants

private extension CustomButton {
   enum Constants {
      static let textFont = ThemeManager.fonts.bodyLargeBold
      static let textColor = ThemeManager.colors.textPrimaryLight
      static let backgroundColor = ThemeManager.colors.enabledButton
      static let cornerRadius: CGFloat = 5
      static let enabledAlpha: CGFloat = 1.0
      static let disabledAlpha: CGFloat = 0.5
   }
}

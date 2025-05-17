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
      setupButton()
   }
   
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
   //MARK: - Public Functions
   func updateStyle(isValid: Bool) {
      isEnabled = isValid
      alpha = isValid ? Constants.enabledAlpha : Constants.disabledAlpha
   }
   
   //MARK: - Private Functions
   private func setupButton() {
      titleLabel?.font = ThemeManager.fonts.bodyLargeBold
      layer.cornerRadius = Constants.cornerRadius
      setTitleColor(ThemeManager.colors.textPrimaryLight, for: .normal)
      backgroundColor = ThemeManager.colors.enabledButton
   }
}

//MARK: - Constrants
private extension CustomButton {
   enum Constants {
      static let cornerRadius: CGFloat = 5
      static let enabledAlpha: CGFloat = 1.0
      static let disabledAlpha: CGFloat = 0.5
   }
}

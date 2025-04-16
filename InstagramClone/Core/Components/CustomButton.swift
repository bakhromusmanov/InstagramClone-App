//
//  CustomButton.swift
//  InstagramClone
//
//  Created by Bakhrom Usmanov on 16/04/25.
//

import UIKit

class CustomButton: UIButton {
   
   //MARK: - Initialization
   override init(frame: CGRect) {
      super.init(frame: frame)
      titleLabel?.font = ThemeManager.inputFieldBoldFont
      setTitleColor(ThemeManager.inputFieldPrimaryColor, for: .normal)
      backgroundColor = ThemeManager.accentPrimaryColor
      layer.cornerRadius = Constants.cornerRadius
   }
   
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}

//MARK: - Constrants
private extension CustomButton {
   enum Constants {
      static let cornerRadius: CGFloat = 5
   }
}

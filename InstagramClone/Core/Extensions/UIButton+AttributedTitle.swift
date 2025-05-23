//
//  UIButton+AttributedTitle.swift
//  InstagramClone
//
//  Created by Bakhrom Usmanov on 16/04/25.
//

import UIKit

extension UIButton {
   func setDualTitle(regularText: String, boldText: String) {
      let titleAttributes: [NSAttributedString.Key: Any] = [.font: ThemeManager.fonts.bodyMediumRegular]
      
      let titleBoldAttributes: [NSAttributedString.Key: Any] = [.font: ThemeManager.fonts.bodyMediumBold]
      
      let attributedTitle = NSMutableAttributedString(string: "\(regularText) ", attributes: titleAttributes)
      attributedTitle.append(NSAttributedString(string: boldText, attributes: titleBoldAttributes))
      
      setAttributedTitle(attributedTitle, for: .normal)
   }
}

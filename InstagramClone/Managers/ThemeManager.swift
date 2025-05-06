//
//  ThemeManager.swift
//  InstagramClone
//
//  Created by Bakhrom Usmanov on 11/04/25.
//

import UIKit

final class ThemeManager {
   
   private init() { }
   
   //MARK: - Fonts
   
   static let titleBold = UIFont.systemFont(ofSize: 14, weight: .bold)
   static let titleRegular = UIFont.systemFont(ofSize: 14, weight: .regular)
   static let subtitle = UIFont.systemFont(ofSize: 13, weight: .regular)
   static let caption = UIFont.systemFont(ofSize: 12, weight: .regular)
   static let inputFieldRegularFont = UIFont.systemFont(ofSize: 16, weight: .regular)
   static let inputFieldBoldFont = UIFont.systemFont(ofSize: 16, weight: .bold)
   
   //MARK: - Colors
   
   static let backgroundPrimaryColor = UIColor.backgroundPrimary
   static let backgroundSecondaryColor = UIColor.backgroundSecondary
   static let backgroundInputField = UIColor.white.withAlphaComponent(0.1)
   
   static let accentPrimaryColor = UIColor.accentPrimary
   static let accentSecondaryColor = UIColor.accentSecondary
   
   static let textPrimaryColor = UIColor.textPrimary
   static let textSecondaryColor = UIColor.textSecondary
   
   static let inputFieldEnabledTextColor = UIColor.white
   static let inputFieldDisabledTextColor = UIColor.white.withAlphaComponent(0.5)
   
   static let buttonEnabledColor = UIColor.accentPrimary.withAlphaComponent(0.75)
   static let buttonDisabledColor = UIColor.accentSecondary.withAlphaComponent(0.5)
   
   //MARK: - Spacings
   
   static let spacingXS: CGFloat = 4
   static let spacingS: CGFloat = 8
   static let spacingM: CGFloat = 12
   static let spacingL: CGFloat = 16
   static let spacingXL: CGFloat = 20
   
   //MARK: - Sizes
   static let separatorLineHeight: CGFloat = 2
   
}


//
//  ThemeManager.swift
//  InstagramClone
//
//  Created by Bakhrom Usmanov on 11/04/25.
//

import UIKit

enum ThemeManager {
   static let colors = AppColors.self
   static let fonts = AppFonts.self
   static let spacings = AppSpacing.self
   static let sizes = AppSizes.self
}

//MARK: - App Colors

enum AppColors {
   
   /// Primary blue color: #246BFD
   static let primary = UIColor.accentPrimary
   
   /// Primary blue color .withAlphaComponent(0.75)
   static let primaryOpacity75 = primary.withAlphaComponent(0.75)
   
   /// Secondary pink color: #FFD300
   static let secondary = UIColor.accentSecondary
   
   /// Secondary pink color .withAlphaComponent(0.5)
   static let secondaryOpacity50 = primary.withAlphaComponent(0.5)
   
   static let grey100 = UIColor.grey100
   
   static let grey200 = UIColor.grey200
   
   static let grey300 = UIColor.grey300
   
   /// White color: #FFFFFF
   static let white = UIColor.white
   
   /// White color .withAlphaComponent(0.1)
   static let whiteOpacity10 = UIColor.white.withAlphaComponent(0.1)
   
   /// White color .withAlphaComponent(0.5)
   static let whiteOpacity50 = UIColor.white.withAlphaComponent(0.5)
   
   // MARK: Alerts & Status
   
   /// Error color: #F75555
   static let error = UIColor.error
   
   /// Border color: textSecondary
   static let border = textSecondaryDark
   
   /// Disabled color: whiteOpacity50
   static let disabled = whiteOpacity50
   
   /// Disabled button color: secondaryOpacity50
   static let disabledButton = secondaryOpacity50
   
   /// Enabled button color same as primary color: primaryOpacity75
   static let enabledButton = primaryOpacity75
   
   //MARK: Defaults
   
   static let backgroundPrimary = UIColor.backgroundPrimary
   static let backgroundSecondary = UIColor.backgroundSecondary
   
   /// Primary dark item tint color: black
   static let tintPrimaryDark = UIColor.textPrimary
   
   /// Secondary dark item tint color: gray
   static let tintSecondaryDark = UIColor.textSecondary
   
   /// Primary dark text color: black
   static let textPrimaryDark = UIColor.textPrimary
   
   /// Secondary dark text color: gray
   static let textSecondaryDark = UIColor.textSecondary
   
   /// Primary light text color: white
   static let textPrimaryLight = white
   
   /// Secondary light text color: whiteOpacity50
   static let textSecondaryLight = whiteOpacity50
}

//MARK: - App Fonts

enum AppFonts {
   
   //MARK: Headings
   
   /// Heading 1: Bold, 48pt
   static let heading1 = UIFont.systemFont(ofSize: 48, weight: .bold)
   
   /// Heading 2: Bold, 40pt
   static let heading2 = UIFont.systemFont(ofSize: 40, weight: .bold)
   
   /// Heading 3: Bold, 32pt
   static let heading3 = UIFont.systemFont(ofSize: 32, weight: .bold)
   
   /// Heading 4: Bold, 24pt
   static let heading4 = UIFont.systemFont(ofSize: 24, weight: .bold)
   
   /// Heading 5: Bold, 20pt
   static let heading5 = UIFont.systemFont(ofSize: 20, weight: .bold)
   
   //MARK: Body XLarge
   
   /// Body XLarge: Bold, 18pt
   static let bodyXLargeBold = UIFont.systemFont(ofSize: 18, weight: .bold)
   
   /// Body XLarge: SemiBold, 18pt
   static let bodyXLargeSemiBold = UIFont.systemFont(ofSize: 18, weight: .semibold)
   
   /// Body XLarge: Medium, 18pt
   static let bodyXLargeMedium = UIFont.systemFont(ofSize: 18, weight: .medium)
   
   /// Body XLarge: Regular, 18pt
   static let bodyXLargeRegular = UIFont.systemFont(ofSize: 18, weight: .regular)
   
   //MARK: Body Large
   
   /// Body Large: Bold, 16pt
   static let bodyLargeBold = UIFont.systemFont(ofSize: 16, weight: .bold)
   
   /// Body Large: SemiBold, 16pt
   static let bodyLargeSemiBold = UIFont.systemFont(ofSize: 16, weight: .semibold)
   
   /// Body Large: Medium, 16pt
   static let bodyLargeMedium = UIFont.systemFont(ofSize: 16, weight: .medium)
   
   /// Body Large: Regular, 16pt
   static let bodyLargeRegular = UIFont.systemFont(ofSize: 16, weight: .regular)
   
   //MARK: Body Medium
   
   /// Body Medium: Bold, 14pt
   static let bodyMediumBold = UIFont.systemFont(ofSize: 14, weight: .bold)
   
   /// Body Medium: SemiBold, 14pt
   static let bodyMediumSemiBold = UIFont.systemFont(ofSize: 14, weight: .semibold)
   
   /// Body Medium: Medium, 14pt
   static let bodyMediumMedium = UIFont.systemFont(ofSize: 14, weight: .medium)
   
   /// Body Medium: Regular, 14pt
   static let bodyMediumRegular = UIFont.systemFont(ofSize: 14, weight: .regular)
   
   //MARK: Body Small
   
   /// Body Small: Bold, 12pt
   static let bodySmallBold = UIFont.systemFont(ofSize: 12, weight: .bold)
   
   /// Body Small: SemiBold, 12pt
   static let bodySmallSemiBold = UIFont.systemFont(ofSize: 12, weight: .semibold)
   
   /// Body Small: Medium, 12pt
   static let bodySmallMedium = UIFont.systemFont(ofSize: 12, weight: .medium)
   
   /// Body Small: Regular, 12pt
   static let bodySmallRegular = UIFont.systemFont(ofSize: 12, weight: .regular)
   
   //MARK: Body XSmall
   
   /// Body XSmall: Bold, 10pt
   static let bodyXSmallBold = UIFont.systemFont(ofSize: 10, weight: .bold)
   
   /// Body XSmall: SemiBold, 10pt
   static let bodyXSmallSemiBold = UIFont.systemFont(ofSize: 10, weight: .semibold)
   
   /// Body XSmall: Medium, 10pt
   static let bodyXSmallMedium = UIFont.systemFont(ofSize: 10, weight: .medium)
   
   /// Body XSmall: Regular, 10pt
   static let bodyXSmallRegular = UIFont.systemFont(ofSize: 10, weight: .regular)
}

//MARK: - App Spacing

enum AppSpacing {

   /// Extra Small Spacing: 4pt
   static let spacingXS: CGFloat = 4
   
   /// Small Spacing: 8pt
   static let spacingS: CGFloat = 8
   
   /// Medium Spacing: 12pt
   static let spacingM: CGFloat = 12
   
   /// Large Spacing: 16pt
   static let spacingL: CGFloat = 16
   
   /// Extra Large Spacing: 20pt
   static let spacingXL: CGFloat = 20
   
   //MARK: - Defaults
   
   /// Medium Spacing: 12pt spacingM
   static let defaultVerticalPadding = spacingM
   
   /// Medium Spacing: 12pt spacingM
   static let defaultHorizontalPadding = spacingM
}

//MARK: - Sizes

enum AppSizes {
   
   /// Small Size: 40pt
   static let componentHeightS: CGFloat = 40
   
   /// Medium Size: 44pt
   static let componentHeightM: CGFloat = 44
   
   /// Large Size: 48pt
   static let componentHeightL: CGFloat = 48
   
   /// Extra Large Size: 56pt
   static let componentHeightXL: CGFloat = 56
   
   /// Separator Line Height: 1pt
   static let separatorLineHeight: CGFloat = 1
   
   //MARK: - Defaults
   
   /// Small Size: 40pt componentHeightS
   static let defaultSearchBarHeight: CGFloat = componentHeightS
   
   /// Medium Size: 44pt componentHeightM
   static let defaultButtonHeight: CGFloat = componentHeightM
   
   /// Large Size: 48pt componentHeightL
   static let defaultTextFieldHeight: CGFloat = componentHeightL
}

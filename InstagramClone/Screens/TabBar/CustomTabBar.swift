//
//  CustomTabBar.swift
//  InstagramClone
//
//  Created by Bakhrom Usmanov on 11/04/25.
//

import UIKit

final class CustomTabBar: UITabBar {
   
   //MARK: - Properties
   
   var safeAreaBottomInset: CGFloat = 0
   
   // MARK: - Initialization
   
   override init(frame: CGRect) {
      super.init(frame: frame)
      setupTabBar()
   }
   
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
   // MARK: - Setup Tab Bar Appearance
   
   private func setupTabBar() {
      let appearance = UITabBarAppearance()
      
      //Setting tab bar opaque background
      appearance.configureWithOpaqueBackground()
      appearance.backgroundColor = ThemeManager.colors.backgroundSecondary
      
      //Set icon normal and selected colors
      appearance.stackedLayoutAppearance.selected.iconColor = ThemeManager.colors.textPrimaryDark
      appearance.stackedLayoutAppearance.normal.iconColor = ThemeManager.colors.textSecondaryDark
      
      // Adjust image position
      appearance.stackedLayoutAppearance.normal.badgePositionAdjustment = UIOffset(horizontal: 0, vertical: Constants.tabBarTitleOffsetY)
      appearance.stackedLayoutAppearance.selected.badgePositionAdjustment = UIOffset(horizontal: 0, vertical: Constants.tabBarTitleOffsetY)
      
      // Setting cornerRadius of tab bar
      layer.cornerRadius = Constants.tabBarCornerRadius
      layer.masksToBounds = true
      layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
      
      standardAppearance = appearance
      if #available(iOS 15.0, *) {
         scrollEdgeAppearance = appearance
      }
   }
   
   // MARK: - Override Height
   
   override func sizeThatFits(_ size: CGSize) -> CGSize {
      var sizeThatFits = super.sizeThatFits(size)
      sizeThatFits.height = Constants.tabBarHeight + safeAreaBottomInset
      return sizeThatFits
   }
}

// MARK: - Constants

private extension CustomTabBar {
   enum Constants {
      static let tabBarHeight: CGFloat = 64
      static let tabBarBorderWidth: CGFloat = 2
      static let tabBarCornerRadius: CGFloat = 24
      static let tabBarTitleOffsetY: CGFloat = -10
   }
}


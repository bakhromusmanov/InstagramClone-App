//
//  ThemeManager.swift
//  InstagramClone
//
//  Created by Bakhrom Usmanov on 11/04/25.
//

import UIKit

final class ThemeManager {
   
   private init() { }
   
   //MARK: - Style
   
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
   
   static let textPrimaryColor = UIColor.textPrimary
   static let textSecondaryColor = UIColor.textSecondary
   
   static let inputFieldEnabledTextColor = UIColor.white
   static let inputFieldDisabledTextColor = UIColor.white.withAlphaComponent(0.5)
   
   static let buttonEnabledColor = UIColor.accentPrimary.withAlphaComponent(0.75)
   static let buttonDisabledColor = UIColor.accentSecondary.withAlphaComponent(0.5)
   
   static let accentPrimaryColor = UIColor.accentPrimary
   static let accentSecondaryColor = UIColor.accentSecondary

   
   //MARK: - Icons
   static let actionButtonSize: CGFloat = 24
   static let config = UIImage.SymbolConfiguration(pointSize: actionButtonSize, weight: .regular)
   
   static let avatarImageName = "thumbnail"
   static let mediaImageName = "placeholder"
   static let homeSelectedImageName = "house.fill"
   static let homeUnselectedImageName = "house"
   static let searchSelectedImageName = "magnifyingglass"
   static let searchUnselectedImageName = "magnifyingglass"
   static let likeSelectedImageName = "heart.fill"
   static let likeUnselectedImageName = "heart"
   static let profileSelectedImageName = "person.fill"
   static let profileUnselectedImageName = "person"
   static let plusSelectedImageName = "plus.app.fill"
   static let plusUnselectedImageName = "plus.app"
   static let commentSelectedImageName = "message.fill"
   static let commentUnselectedImageName = "message"
   static let shareSelectedImageName = "paperplane.fill"
   static let shareUnselectedImageName = "paperplane"
}


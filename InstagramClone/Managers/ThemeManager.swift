//
//  ThemeManager.swift
//  InstagramClone
//
//  Created by Bakhrom Usmanov on 11/04/25.
//

import UIKit

final class ThemeManager {
   //MARK: - Style
   
   //MARK: - Fonts
   static let title = UIFont.systemFont(ofSize: 14, weight: .bold)
   static let body = UIFont.systemFont(ofSize: 14, weight: .regular)
   static let subtitle = UIFont.systemFont(ofSize: 13, weight: .regular)
   static let caption = UIFont.systemFont(ofSize: 12, weight: .regular)
   
   static func labelHeight(font: UIFont) -> CGFloat {
      return ceil(font.lineHeight)
   }
   
   //MARK: - Colors
   static let backgroundPrimaryColor = UIColor.backgroundPrimary
   static let backgroundSecondaryColor = UIColor.backgroundSecondary
   static let textPrimaryColor = UIColor.textPrimary
   static let textSecondaryColor = UIColor.textSecondary
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

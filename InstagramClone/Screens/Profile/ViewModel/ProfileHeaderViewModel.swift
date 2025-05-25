//
//  ProfileHeaderViewModel.swift
//  InstagramClone
//
//  Created by Bakhrom Usmanov on 14/05/25.
//

import Foundation
import UIKit

struct ProfileHeaderViewModel {
   
   //MARK: Public Properties
   
   var fullName: String
   var profileImageURL: URL?
   var userId: String
   var isFollowed: Bool = false
   var followersCount: Int = 0
   var followingsCount: Int = 0
   var postsCount: Int = 0
   
   var profileButtonState: ProfileButtonState {
      let isCurrentUser = AuthService.shared.currentUserUid == userId
      
      if isCurrentUser {
         return .editProfile
      } else {
         return isFollowed ? .following : .follow
      }
   }
   
   //MARK: Initialization
   
   init(user: UserEntity) {
      fullName = user.fullName
      userId = user.userId
      if let url = user.profileImageURL {
         profileImageURL = URL(string: url)
      }
   }
}

//MARK: ProfileButtonState

extension ProfileHeaderViewModel {
   
   enum ProfileButtonState {
      case editProfile
      case follow
      case following
      
      var title: String {
         switch self {
         case .editProfile:
            return Constants.editButtonText
         case .follow:
            return Constants.followButtonText
         case .following:
            return Constants.followingButtonText
         }
      }
      
      var backgroundColor: UIColor {
         switch self {
         case .editProfile:
            return ThemeManager.colors.whiteOpacity10
         case .follow, .following:
            return ThemeManager.colors.primary
         }
      }
      
      var titleColor: UIColor {
         switch self {
         case .editProfile:
            return ThemeManager.colors.textPrimaryDark
         case .follow, .following:
            return ThemeManager.colors.textPrimaryLight
         }
      }
      
      var borderColor: UIColor {
         switch self {
         case .editProfile:
            return ThemeManager.colors.border
         case .follow, .following:
            return ThemeManager.colors.white
         }
      }
   }
}

//MARK: Constants

private extension ProfileHeaderViewModel {
   enum Constants {
      //Namings
      static let editButtonText = "Edit Profile"
      static let followButtonText = "Follow"
      static let followingButtonText = "Following"
   }
}

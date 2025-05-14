//
//  ProfileHeaderViewModel.swift
//  InstagramClone
//
//  Created by Bakhrom Usmanov on 14/05/25.
//

import Foundation

struct ProfileHeaderViewModel {
   
   var user: UserEntity?
   
   var fullname: String? {
      return user?.fullname
   }
   
   var profileImageURL: URL? {
      guard let profileImageURL = user?.profileImageURL else { return nil }
      return URL(string: profileImageURL)
   }
}


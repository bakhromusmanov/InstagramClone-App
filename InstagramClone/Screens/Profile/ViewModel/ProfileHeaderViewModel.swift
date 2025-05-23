//
//  ProfileHeaderViewModel.swift
//  InstagramClone
//
//  Created by Bakhrom Usmanov on 14/05/25.
//

import Foundation

struct ProfileHeaderViewModel {
   
   var fullName: String
   var profileImageURL: URL?
   
   init(user: UserEntity) {
      fullName = user.fullName
      
      guard let url = user.profileImageURL else { return }
      profileImageURL = URL(string: url)
   }
}


//
//  SearchCellViewModel.swift
//  InstagramClone
//
//  Created by Bakhrom Usmanov on 15/05/25.
//

import Foundation

struct SearchCellViewModel {
   
   var username: String
   var fullName: String
   var profileImageURL: URL?
   
   init(user: UserEntity) {
      username = user.username
      fullName = user.fullName
      
      guard let url = user.profileImageURL else { return }
      profileImageURL = URL(string: url)
   }
   
}


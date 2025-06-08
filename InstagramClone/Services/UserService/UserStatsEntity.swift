//
//  UserStatsEntity.swift
//  InstagramClone
//
//  Created by Bakhrom Usmanov on 26/05/25.
//

import Foundation

struct UserStatsEntity {
   var followersCount: Int = 0
   var followingsCount: Int = 0
   var postsCount: Int = 0
   
   init(user: UserEntity) {
      self.followersCount = user.followersCount
      self.followingsCount = user.followingsCount
      self.postsCount = user.postsCount
   }
}

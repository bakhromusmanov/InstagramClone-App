//
//  AppDataManager.swift
//  InstagramClone
//
//  Created by Bakhrom Usmanov on 08/06/25.
//

import Foundation

final class AppDataManager {
   
   static let shared = AppDataManager()
   private init() { }
   
   private(set) var user: UserEntity?
}

//MARK: - Public Methods

extension AppDataManager {
   func setCurrentUser(_ user: UserEntity) {
      self.user = user
   }
   
   func incrementFollowersCount(by count: Int) {
      user?.followersCount += count
      postDidUpdateUserNotification()
   }
   
   func incrementFollowingsCount(by count: Int) {
      user?.followingsCount += count
      postDidUpdateUserNotification()
   }
   
   func incrementPostsCount(by count: Int) {
      user?.postsCount += count
      postDidUpdateUserNotification()
   }
}

//MARK: - Observers

private extension AppDataManager {
   func postDidUpdateUserNotification() {
      NotificationCenter.default.post(name: .didUpdateCurrentUser, object: nil)
      print("DEBUG: Posted 'didUpdateCurrentUser' Notification ")
   }
}

//MARK: - Constants

private extension AppDataManager {
   enum Constants {

   }
}

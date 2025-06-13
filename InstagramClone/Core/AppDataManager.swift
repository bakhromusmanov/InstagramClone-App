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
      sendUpdateUserStatsNotification()
   }
   
   func incrementFollowingsCount(by count: Int) {
      user?.followingsCount += count
      sendUpdateUserStatsNotification()
   }
   
   func handleUserDidUploadPost() {
      user?.postsCount += 1
      sendDidUploadPostNotification()
   }
}

//MARK: - Observers

private extension AppDataManager {
   func sendUpdateUserStatsNotification() {
      NotificationCenter.default.post(name: .didUpdateCurrentUserStats, object: nil)
      print("DEBUG: Posted 'didUpdateCurrentUserStats' Notification ")
   }
   
   func sendDidUploadPostNotification() {
      NotificationCenter.default.post(name: .didUploadPost, object: nil)
      print("DEBUG: Posted 'didUploadPost' Notification ")
   }
}

//MARK: - Constants

private extension AppDataManager {
   enum Constants {

   }
}

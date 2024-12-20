//
//  MainTabBarController.swift
//  InstagramClone
//
//  Created by Bakhrom Usmanov on 20/12/24.
//

import UIKit

final class MainTabBarController: UITabBarController {
   
   //MARK: Initialization
   override func viewDidLoad() {
      super.viewDidLoad()
      configureControllers()
   }
   
   //MARK: Custom Functions
   private func configureControllers() {
      let feed = navigationController(
         selectedImage: UIImage(systemName: "house.fill") ?? UIImage(),
         unselectedImage: UIImage(systemName: "house") ?? UIImage(),
         rootViewController: FeedController()
      )
      let search = navigationController(
         selectedImage: UIImage(systemName: "magnifyingglass") ?? UIImage(),
         unselectedImage: UIImage(systemName: "magnifyingglass") ?? UIImage(),
         rootViewController: SearchController()
      )
      let imageSelector = navigationController(
         selectedImage: UIImage(systemName: "plus.app.fill") ?? UIImage(),
         unselectedImage: UIImage(systemName: "plus.app") ?? UIImage(),
         rootViewController: ImageSelectorController()
      )
      let notifications = navigationController(
         selectedImage: UIImage(systemName: "heart.fill") ?? UIImage(),
         unselectedImage: UIImage(systemName: "heart") ?? UIImage(),
         rootViewController: NotificationsController()
      )
      let profile = navigationController(
         selectedImage: UIImage(systemName: "person.fill") ?? UIImage(),
         unselectedImage: UIImage(systemName: "person") ?? UIImage(),
         rootViewController: ProfileController()
      )
      
      viewControllers = [feed, search, imageSelector, notifications, profile]
   }
   
   private func navigationController(selectedImage: UIImage, unselectedImage: UIImage, rootViewController: UIViewController) -> UINavigationController {
      let navigationController = UINavigationController(rootViewController: rootViewController)
      navigationController.tabBarItem.selectedImage = selectedImage
      navigationController.tabBarItem.image = unselectedImage
      return navigationController
   }
   
}

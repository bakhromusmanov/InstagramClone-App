//
//  TabBarViewController.swift
//  InstagramClone
//
//  Created by Bakhrom Usmanov on 20/12/24.
//

import UIKit

final class TabBarViewController: UITabBarController {
   
   //MARK: - Lifecycle
   
   override func viewDidLoad() {
      super.viewDidLoad()
      setValue(CustomTabBar(), forKey: "tabBar")
      setupTabBarControllers()
   }
   
   override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)
      checkIfUserIsLoggedIn()
   }
   
   override func viewSafeAreaInsetsDidChange() {
       super.viewSafeAreaInsetsDidChange()
       if let customTabBar = self.tabBar as? CustomTabBar {
           customTabBar.safeAreaBottomInset = view.safeAreaInsets.bottom
       }
   }
   
   //MARK: - Private Functions
   
   private func setupTabBarControllers() {
      
      //MARK: Make HomeModule
      
      let homeViewController = HomeViewController()
      let homeNavigationController = makeNavigationController(
         selectedImage: UIImage(systemName: ThemeManager.homeSelectedImageName) ?? UIImage(),
         unselectedImage: UIImage(systemName: ThemeManager.homeUnselectedImageName) ?? UIImage(),
         rootViewController: homeViewController)
      
      //MARK: Make SearchModule
      
      let searchViewController = SearchViewController()
      let searchNavigationController = makeNavigationController(
         selectedImage: UIImage(systemName: ThemeManager.searchSelectedImageName) ?? UIImage(),
         unselectedImage: UIImage(systemName: ThemeManager.searchUnselectedImageName) ?? UIImage(),
         rootViewController: searchViewController)
      
      //MARK: Make ImageSelectorModule
      
      let imageSelectorViewController = ImageSelectorController()
      let imageSelectorNavigationController = makeNavigationController(
         selectedImage: UIImage(systemName: ThemeManager.plusSelectedImageName) ?? UIImage(),
         unselectedImage: UIImage(systemName: ThemeManager.plusUnselectedImageName) ?? UIImage(),
         rootViewController: imageSelectorViewController)
      
      //MARK: Make NotificationsModule
      
      let notificationsViewController = NotificationsViewController()
      let notificationsNavigationController = makeNavigationController(
         selectedImage: UIImage(systemName: ThemeManager.likeSelectedImageName) ?? UIImage(),
         unselectedImage: UIImage(systemName: ThemeManager.likeUnselectedImageName) ?? UIImage(),
         rootViewController: notificationsViewController)
      
      //MARK: Make ProfileModule
      
      let profileViewController = ProfileViewController()
      let profileNavigationController = makeNavigationController(
         selectedImage: UIImage(systemName: ThemeManager.profileSelectedImageName) ?? UIImage(),
         unselectedImage: UIImage(systemName: ThemeManager.profileUnselectedImageName) ?? UIImage(),
         rootViewController: profileViewController)
      
      viewControllers = [
         homeNavigationController,
         searchNavigationController,
         imageSelectorNavigationController,
         notificationsNavigationController,
         profileNavigationController]
   }
   
   private func makeNavigationController(selectedImage: UIImage, unselectedImage: UIImage, rootViewController: UIViewController) -> UINavigationController {
      let navigationController = UINavigationController(rootViewController: rootViewController)
      navigationController.tabBarItem.selectedImage = selectedImage
      navigationController.tabBarItem.image = unselectedImage
      return navigationController
   }
}


//MARK: - Networking

private extension TabBarViewController {
   func checkIfUserIsLoggedIn() {
      if AuthService.isUserLoggedOut {
         let loginVC = LoginViewController()
         let loginNav = UINavigationController(rootViewController: loginVC)
         loginNav.modalPresentationStyle = .fullScreen
         self.present(loginNav, animated: false)
      }
   }
}


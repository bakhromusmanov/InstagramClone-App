//
//  TabBarViewController.swift
//  InstagramClone
//
//  Created by Bakhrom Usmanov on 20/12/24.
//

import UIKit

final class TabBarViewController: UITabBarController {
   
   //MARK: - Properties
   
   
   //MARK: - Lifecycle
   
   override func viewDidLoad() {
      super.viewDidLoad()
      setValue(CustomTabBar(), forKey: "tabBar")
      setupShimmerView()
      setupObservers()
      fetchUser()
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
}

//MARK: - Public Methods

extension TabBarViewController {
   func navigateToHomeAndRefresh() {
      selectedIndex = TabIndex.home.rawValue
      if let homeNav = viewControllers?[TabIndex.home.rawValue] as? UINavigationController,
         let homeVC = homeNav.viewControllers.first as? HomeViewController {
         homeVC.refreshData()
      }
   }
}

//MARK: - Private Methods

private extension TabBarViewController {
   
   func setupShimmerView() {
      viewControllers = [ShimmerViewController()]
   }
   
   func setupTabBarControllers() {
      
      guard let user = AppDataManager.shared.user else { return }
      
      //MARK: Make HomeModule
      
      let homeViewController = HomeViewController()
      let homeNavigationController = makeNavigationController(
         selectedImage: UIImage(systemName: Constants.homeSelectedImageName) ?? UIImage(),
         unselectedImage: UIImage(systemName: Constants.homeUnselectedImageName) ?? UIImage(),
         rootViewController: homeViewController)
      
      //MARK: Make SearchModule
      
      let searchViewController = SearchViewController()
      let searchNavigationController = makeNavigationController(
         selectedImage: UIImage(systemName: Constants.searchSelectedImageName) ?? UIImage(),
         unselectedImage: UIImage(systemName: Constants.searchUnselectedImageName) ?? UIImage(),
         rootViewController: searchViewController)
      
      //MARK: Make ImageSelectorModule
      
      let uploadPostViewController = UploadPostViewController()
      let uploadPostNavigationController = makeNavigationController(
         selectedImage: UIImage(systemName: Constants.plusSelectedImageName) ?? UIImage(),
         unselectedImage: UIImage(systemName: Constants.plusUnselectedImageName) ?? UIImage(),
         rootViewController: uploadPostViewController)
      
      //MARK: Make NotificationsModule
      
      let notificationsViewController = NotificationsViewController()
      let notificationsNavigationController = makeNavigationController(
         selectedImage: UIImage(systemName: Constants.likeSelectedImageName) ?? UIImage(),
         unselectedImage: UIImage(systemName: Constants.likeUnselectedImageName) ?? UIImage(),
         rootViewController: notificationsViewController)
      
      //MARK: Make ProfileModule
      
      let profileViewController = ProfileViewController(user: user)
      let profileNavigationController = makeNavigationController(
         selectedImage: UIImage(systemName: Constants.profileSelectedImageName) ?? UIImage(),
         unselectedImage: UIImage(systemName: Constants.profileUnselectedImageName) ?? UIImage(),
         rootViewController: profileViewController)
      
      viewControllers = [
         homeNavigationController,
         searchNavigationController,
         uploadPostNavigationController,
         notificationsNavigationController,
         profileNavigationController]
   }
   
   func makeNavigationController(selectedImage: UIImage, unselectedImage: UIImage, rootViewController: UIViewController) -> UINavigationController {
      let navigationController = UINavigationController(rootViewController: rootViewController)
      navigationController.tabBarItem.selectedImage = selectedImage
      navigationController.tabBarItem.image = unselectedImage
      return navigationController
   }
}

//MARK: - Observers

private extension TabBarViewController {
   func setupObservers() {
      NotificationCenter.default.addObserver(self, selector: #selector(handleDidUpdateUserStats), name: .didUpdateCurrentUserStats, object: nil)
      
      NotificationCenter.default.addObserver(self, selector: #selector(handleDidUploadPost), name: .didUploadPost, object: nil)
   }
}

//MARK: - Actions

@objc
private extension TabBarViewController {
   func handleDidUpdateUserStats() {
      guard let profileNavController = viewControllers?[TabIndex.profile.rawValue] as? UINavigationController,
            let profileVC = profileNavController.viewControllers.first as? ProfileViewController,
            let user = AppDataManager.shared.user else { return }
      
      profileVC.updateUserStats(user)
   }
   
   func handleDidUploadPost() {
      guard let profileNavController = viewControllers?[TabIndex.profile.rawValue] as? UINavigationController,
            let profileVC = profileNavController.viewControllers.first as? ProfileViewController, let user = AppDataManager.shared.user else { return }
      
      profileVC.updateUserPosts(user)
   }
}

//MARK: - Networking

private extension TabBarViewController {
   func fetchUser() {
      UserService.shared.fetchUser { [weak self] user in
         guard let self else { return }
         AppDataManager.shared.setCurrentUser(user)
         setupTabBarControllers()
      }
   }
   
   func checkIfUserIsLoggedIn() {
      if AuthService.shared.isUserLoggedOut {
         let loginVC = LoginViewController()
         loginVC.setDelegate(self)
         let loginNav = UINavigationController(rootViewController: loginVC)
         loginNav.modalPresentationStyle = .fullScreen
         present(loginNav, animated: false)
      }
   }
}

//MARK: - UITabBarControllerDelegate

extension TabBarViewController: UITabBarControllerDelegate {
   
}

//MARK: - TabIndex

private enum TabIndex: Int {
   case home = 0
   case search = 1
   case uploadPost = 2
   case notifications = 3
   case profile = 4
}

//MARK: - AuthDelegate

extension TabBarViewController: AuthDelegate {
   func authDidComplete() {
      fetchUser()
   }
}


//MARK: - Constants

private extension TabBarViewController {
   enum Constants {
      //Namings
      static let homeSelectedImageName = "house.fill"
      static let homeUnselectedImageName = "house"
      static let searchSelectedImageName = "magnifyingglass"
      static let searchUnselectedImageName = "magnifyingglass"
      static let plusSelectedImageName = "plus.app.fill"
      static let plusUnselectedImageName = "plus.app"
      static let likeSelectedImageName = "heart.fill"
      static let likeUnselectedImageName = "heart"
      static let profileSelectedImageName = "person.fill"
      static let profileUnselectedImageName = "person"
   }
}

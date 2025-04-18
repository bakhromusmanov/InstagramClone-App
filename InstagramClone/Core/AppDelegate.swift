//
//  AppDelegate.swift
//  InstagramClone
//
//  Created by Bakhrom Usmanov on 20/12/24.
//

import UIKit
import SnapKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
   
   //MARK: - Properties
   var window: UIWindow?

   //MARK: - DidFinishLaunchingWithOptions
   func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      
      let tabViewController = TabBarViewController()
      
      let loginViewController = LoginViewController()
      let loginNavigationController = UINavigationController(rootViewController: loginViewController)
      
      window = UIWindow(frame: UIScreen.main.bounds)
      window?.rootViewController = loginNavigationController
      window?.makeKeyAndVisible()
      
      return true
   }
}


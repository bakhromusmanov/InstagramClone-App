//
//  AppDelegate.swift
//  InstagramClone
//
//  Created by Bakhrom Usmanov on 20/12/24.
//

import UIKit
import SnapKit
import FirebaseCore
import netfox

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
   
   //MARK: - Properties
   
   var window: UIWindow?
   
   //MARK: - DidFinishLaunchingWithOptions
   
   func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      
      setupPods()
      window = UIWindow(frame: UIScreen.main.bounds)
      window?.rootViewController = TabBarViewController()
      window?.makeKeyAndVisible()
      
      return true
   }
   
   private func setupPods() {
      FirebaseApp.configure()
      
      #if DEBUG
      //NFX.sharedInstance().start()
      #endif
   }
}




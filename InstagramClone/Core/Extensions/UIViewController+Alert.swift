//
//  UIViewController+Alert.swift
//  InstagramClone
//
//  Created by Bakhrom Usmanov on 21/04/25.
//

import UIKit

extension UIViewController {
   func showPhotoPicker(onCameraTap: @escaping () -> Void, onLibraryTap: @escaping () -> Void) {
      let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
      
      alert.addAction(UIAlertAction(title: Constants.takePhotoTitle, style: .default, handler: { _ in
         onCameraTap()
      }))
      
      alert.addAction(UIAlertAction(title: Constants.chooseFromLibraryTitle, style: .default, handler: { _ in
         onLibraryTap()
      }))
      
      alert.addAction(UIAlertAction(title: Constants.cancelTitle, style: .cancel))
      
      present(alert, animated: true)
   }
}

//MARK: - Constants

private extension UIViewController {
   enum Constants {
      static let cancelTitle = "Cancel"
      static let takePhotoTitle = "Take Photo"
      static let chooseFromLibraryTitle = "Choose from library"
   }
}

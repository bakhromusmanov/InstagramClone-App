//
//  UIViewController+PhotoPicker.swift
//  InstagramClone
//
//  Created by Bakhrom Usmanov on 21/04/25.
//

import UIKit

extension UIViewController {
   func showPhotoPicker(delegate: UIImagePickerControllerDelegate & UINavigationControllerDelegate) {
      if UIImagePickerController.isSourceTypeAvailable(.camera) {
         showPhotoPickerAlert(
            onCameraTap: { [weak self] in
               self?.takePhotoWithCamera(delegate: delegate) },
            onLibraryTap: { [weak self] in
               self?.choosePhotoFromLibrary(delegate: delegate) }
         )
      } else {
         choosePhotoFromLibrary(delegate: delegate)
      }
   }
   
   private func showPhotoPickerAlert(onCameraTap: @escaping () -> Void, onLibraryTap: @escaping () -> Void) {
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
   
   private func takePhotoWithCamera(delegate: UIImagePickerControllerDelegate & UINavigationControllerDelegate) {
      let imagePicker = UIImagePickerController()
      imagePicker.delegate = delegate
      imagePicker.sourceType = .camera
      imagePicker.allowsEditing = true
      present(imagePicker, animated: true)
   }
   
   private func choosePhotoFromLibrary(delegate: UIImagePickerControllerDelegate & UINavigationControllerDelegate) {
      let imagePicker = UIImagePickerController()
      imagePicker.delegate = delegate
      imagePicker.sourceType = .photoLibrary
      imagePicker.allowsEditing = true
      present(imagePicker, animated: true)
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

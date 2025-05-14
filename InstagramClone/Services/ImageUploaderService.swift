//
//  ImageUploaderService.swift
//  InstagramClone
//
//  Created by Bakhrom Usmanov on 26/04/25.
//

import Foundation
import FirebaseStorage

final class ImageUploaderService {
   
   private init() { }
   
   //MARK: - uploadPostImage
   
   static func uploadPostImage(username: String, image: UIImage, completion: @escaping (String) -> Void) {
      let path = ImageEndpoint.postImage(username: username).path
      upload(image: image, path: path, completion: completion)
   }
   
   //MARK: - uploadProfileImage
   
   static func uploadProfileImage(username: String, image: UIImage, completion: @escaping (String) -> Void) {
      let path = ImageEndpoint.profileImage(username: username).path
      upload(image: image, path: path, completion: completion)
   }
   
   //MARK: - Private Functions
   
   private static func upload(image: UIImage, path: String, completion: @escaping (String) -> Void) {
      guard let imageData = image.jpegData(compressionQuality: Constants.compressionQuality) else { return }
      
      let ref = Storage.storage().reference(withPath: path)
   
      ref.putData(imageData, metadata: nil) { result in
         switch result {
         case .success:
            ref.downloadURL { url, error in
               if let error = error {
                  print("DEBUG: Error while getting downloadURL of image: \(error.localizedDescription)")
                  return
               }
               
               if let url = url {
                  let downloadURL = url.absoluteString
                  completion(downloadURL)
               }
            }
         case .failure(let error):
            print("DEBUG: Error while putting image data into storage: \(error.localizedDescription)")
            return
         }
      }
   }
}

//MARK: - Constants

private extension ImageUploaderService {
   enum Constants {
      static let compressionQuality: CGFloat = 0.8
   }
}

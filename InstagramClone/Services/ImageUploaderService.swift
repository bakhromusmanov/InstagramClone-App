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
   static func uploadPostImage(image: UIImage, completion: @escaping (String) -> Void) {
      let path = ImageUploaderEndpoint.postImage.path
      upload(image: image, path: path, completion: completion)
   }
   
   //MARK: - uploadProfileImage
   static func uploadProfileImage(image: UIImage, completion: @escaping (String) -> Void) {
      let path = ImageUploaderEndpoint.profileImage.path
      upload(image: image, path: path, completion: completion)
   }
   
   //MARK: - Private Functions
   private static func upload(image: UIImage, path: String, completion: @escaping (String) -> Void) {
      guard let imageData = image.jpegData(compressionQuality: Constants.compressionQuality) else { return }
      
      let storage = Storage.storage()
      let storageReference = storage.reference(withPath: path)
   
      storageReference.putData(imageData, metadata: nil) { result in
         switch result {
         case .success:
            storageReference.downloadURL { url, error in
               if let error = error {
                  print(error.localizedDescription)
                  return
               }
               
               if let url = url {
                  let downloadURL = url.absoluteString
                  completion(downloadURL)
               }
            }
         case .failure(let error):
            print(error.localizedDescription)
            return
         }
      }
   }
}

//MARK: - ImageUploaderEndpoint
private enum ImageUploaderEndpoint {
   case profileImage
   case postImage
   
   var path: String {
      switch self {
      case .profileImage:
         let userId = "userId"
         return "/users\(userId)/images/profile_image.jpg"
      case .postImage:
         let userId = "userId"
         let fileName = UUID().uuidString
         return "/users\(userId)/images/post_images/\(fileName).jpg"
      }
   }
}

//MARK: - Constants
private extension ImageUploaderService {
   enum Constants {
      static let compressionQuality: CGFloat = 0.8
   }
}

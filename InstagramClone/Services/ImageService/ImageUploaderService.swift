//
//  ImageUploaderService.swift
//  InstagramClone
//
//  Created by Bakhrom Usmanov on 26/04/25.
//

import Foundation
import FirebaseStorage

final class ImageUploaderService {
   
   static let shared = ImageUploaderService()
   private init() { }
   
   //MARK: - Upload Post Image
   
   func uploadPostImage(username: String, image: UIImage, completion: @escaping (String?) -> Void) {
      let path = ImageEndpoint.postImage(username: username).path
      upload(image: image, path: path, completion: completion)
   }
   
   //MARK: - Upload Profile Image
   
   func uploadProfileImage(username: String, image: UIImage, completion: @escaping (String?) -> Void) {
      let path = ImageEndpoint.profileImage(username: username).path
      upload(image: image, path: path, completion: completion)
   }
   
   //MARK: - Private Methods
   
   private func upload(image: UIImage, path: String, completion: @escaping (String?) -> Void) {
      guard let imageData = image.jpegData(compressionQuality: Constants.compressionQuality) else {
         print(ImageUploaderError.failedToCompressImage)
         completion(nil)
         return
      }
      
      let ref = Storage.storage().reference(withPath: path)
   
      ref.putData(imageData, metadata: nil) { result in
         switch result {
         case .success:
            ref.downloadURL { url, error in
               if let error = error {
                  print(ImageUploaderError.failedToRetrieveDownloadURL(error).localizedDescription)
                  completion(nil)
                  return
               }
               
               if let url = url {
                  let downloadURL = url.absoluteString
                  print(ImageUploaderSuccess.uploadCompleted)
                  completion(downloadURL)
               }
            }
         case .failure(let error):
            print(ImageUploaderError.uploadFailed(error).localizedDescription)
            completion(nil)
            return
         }
      }
   }
}

//MARK: - ImageUploaderError

private enum ImageUploaderError: Error {
    case failedToCompressImage
    case uploadFailed(Error)
    case failedToRetrieveDownloadURL(Error)
    
    var localizedDescription: String {
        switch self {
        case .failedToCompressImage:
            return "DEBUG: Failed to compress the image."
        case .uploadFailed(let error):
            return "DEBUG: Upload to storage failed: \(error.localizedDescription)"
        case .failedToRetrieveDownloadURL(let error):
            return "DEBUG: Failed to retrieve download URL: \(error.localizedDescription)"
        }
    }
}

//MARK: - ImageUploaderSuccess

private enum ImageUploaderSuccess {
    static let uploadCompleted = "DEBUG: Image uploaded successfully."
}

//MARK: - Constants

private extension ImageUploaderService {
   enum Constants {
      static let compressionQuality: CGFloat = 0.8
   }
}

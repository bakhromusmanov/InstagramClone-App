//
//  PostService.swift
//  InstagramClone
//
//  Created by Bakhrom Usmanov on 07/06/25.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

final class PostService {
   
   static let shared = PostService()
   private init() { }
   
   //MARK: - Upload Post
   
   func uploadPost(image: UIImage, caption: String, completion: @escaping (Error?) -> Void) {
      
      guard let user = AppDataManager.shared.user else {
         print(PostServiceError.missingUser.localizedDescription)
         completion(PostServiceError.missingUser)
         return }
      
      ImageUploaderService.shared.uploadPostImage(username: user.username, image: image) { postImageUrl in
         
         guard let postImageUrl = postImageUrl else {
            print(PostServiceError.imageUploadFailed.localizedDescription)
            completion(PostServiceError.imageUploadFailed)
            return }
         
         let documentRef = COLLECTION_POSTS.document()
         
         let post = PostEntity(
            postId: documentRef.documentID,
            userId: user.userId,
            profileImageUrl: user.profileImageURL,
            postImageUrl: postImageUrl,
            username: user.username,
            caption: caption,
            likesCount: 0,
            timestamp: Timestamp(date: Date()))
         
         guard let data = try? Firestore.Encoder().encode(post) else {
            print(PostServiceError.errorEncodingPost.localizedDescription)
            completion(PostServiceError.errorEncodingPost)
            return
         }
         
         documentRef.setData(data, completion: completion)
      }
   }
   
   //MARK: - Fetch User Posts
   
   func fetchUserPosts(completion: @escaping ([PostEntity]?) -> Void) {
      guard let uid = AuthService.shared.currentUserUid else {
         print(PostServiceError.nilUserUID.localizedDescription)
         completion(nil)
         return }
      
      COLLECTION_POSTS
         .whereField(Constants.postEntityUserId, isEqualTo: uid)
         .order(by: Constants.postEntityTimestamp, descending: true)
         .getDocuments { snapshot, error in
         
            if let error = error {
               print(PostServiceError.firestoreError(error).localizedDescription)
               completion(nil)
               return
            }
            
            guard let documents = snapshot?.documents else {
               print(PostServiceError.nilSnapshot.localizedDescription)
               completion(nil)
               return
            }
            
            let posts = documents.compactMap { document in
               document.decode(as: PostEntity.self)
            }
            
            print(PostServiceSuccess.userPostsFetched)
            completion(posts)
         }
   }
}

private enum PostServiceError: Error {
   case firestoreError(Error)
   case nilUserUID
   case nilSnapshot
   case missingUser
   case imageUploadFailed
   case errorEncodingPost
   case failedToUploadPost(Error)
   
   var localizedDescription: String {
      switch self {
      case .firestoreError(let error):
         return "DEBUG: Firestore error: \(error.localizedDescription)"
      case .nilUserUID:
         return "DEBUG: Current user UID is nil."
      case .nilSnapshot:
         return "DEBUG: Snapshot is nil."
      case .missingUser:
         return "DEBUG: Failed to unwrap user is nil."
      case .imageUploadFailed:
         return "DEBUG: Failed to get postImageUrl is nil."
      case .errorEncodingPost:
         return "DEBUG: Failed to encode post entity."
      case .failedToUploadPost(let error):
         return "DEBUG: Failed to upload post to Firestore: \(error.localizedDescription)"
      }
   }
}

private enum PostServiceSuccess {
   static let postUploaded = "DEBUG: SUCCESS Post uploaded successfully!"
   static let userPostsFetched = "DEBUG: SUCCESS Fetching user posts!"
}

//MARK: - Constants

private extension PostService {
   enum Constants {
      static let postEntityUserId = "userId"
      static let postEntityTimestamp = "timestamp"
   }
}

//
//  ImageDownloaderService.swift
//  InstagramClone
//
//  Created by Bakhrom Usmanov on 14/05/25.
//

import Foundation
import UIKit

final class ImageDownloaderService {
   
   //MARK: - Properties
   
   static var shared = ImageDownloaderService()
   private var task: URLSessionDownloadTask?
   
   private init() { }
   
   func loadImage(from url: URL, completion: @escaping (UIImage) -> Void) {
      let session = URLSession.shared
      
      task = session.downloadTask(with: url) { localURL, _, error in
         
         if error != nil {
            print("DEBUG: Error while downloading image from network to local storage.")
            return
         }
         
         guard let localURL = localURL, let data = try? Data(contentsOf: localURL) else {
            print("DEBUG: Error while creating data from local url of image in local storage.")
            return
         }
         
         guard let image = UIImage(data: data) else {
            print("DEBUG: Error while getting image from data in local storage.")
            return
         }
         
         DispatchQueue.main.async {
            completion(image)
         }
      }
      
      task?.resume()
   }
   
   func cancel() {
      task?.cancel()
   }
   
}

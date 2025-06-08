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
   
   static let shared = ImageDownloaderService()
   private var tasks: [URL: URLSessionTask] = [:]
   private let urlSession: URLSession
   private let imageCache = NSCache<NSURL, UIImage>()
   
   //MARK: - Initialization
   
   private init() {
      let config = URLSessionConfiguration.default
      config.requestCachePolicy = .returnCacheDataElseLoad
      self.urlSession = URLSession(configuration: config)
   }
   
   func loadImage(from url: URL, completion: @escaping (UIImage) -> Void) {
      // 1. Check in-memory cache
      if let cachedImage = imageCache.object(forKey: url as NSURL) {
         completion(cachedImage)
         return
      }
      
      // 2. Skip if already downloading
      //if tasks[url] != nil { return }
      
      // 3. Start download
      let task = urlSession.dataTask(with: url) { [weak self] data, response, error in
         
         guard let self else { return }
         defer { self.tasks[url] = nil } // Clean up task
         
         if let error {
            print("DEBUG: Download failed - \(error.localizedDescription)")
            return
         }
         
         guard let data, let image = UIImage(data: data) else {
            print("DEBUG: Invalid image data")
            return
         }
         
         // Store in memory cache
         self.imageCache.setObject(image, forKey: url as NSURL)
         
         DispatchQueue.main.async {
            completion(image)
            return
         }
      }
      
      tasks[url] = task
      task.resume()
   }
   
   func cancelLoading(for url: URL) {
      tasks[url]?.cancel()
      tasks[url] = nil
   }
   
   func clearMemoryCache() {
      imageCache.removeAllObjects()
   }
   
   func clearDiskCache(completion: (() -> Void)? = nil) {
       urlSession.configuration.urlCache?.removeAllCachedResponses()
       completion?()
   }
}

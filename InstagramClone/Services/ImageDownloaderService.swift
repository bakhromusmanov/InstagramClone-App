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
      if tasks[url] != nil { return }

      // 3. Start download
      let task = urlSession.downloadTask(with: url) { [weak self] localURL, _, error in
         defer { self?.tasks[url] = nil }

         guard
            let self = self,
            let localURL = localURL,
            let data = try? Data(contentsOf: localURL),
            let image = UIImage(data: data)
         else {
            print("DEBUG: Error downloading or decoding image.")
            return
         }

         self.imageCache.setObject(image, forKey: url as NSURL)

         DispatchQueue.main.async {
            completion(image)
         }
      }

      tasks[url] = task
      task.resume()
   }
   
   func cancelLoading() {
      tasks.forEach { $0.value.cancel() }
      tasks.removeAll()
   }
   
}

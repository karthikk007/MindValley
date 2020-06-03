//
//  CustomImageView.swift
//  MindValley
//
//  Created by Kumar, Karthik on 29/05/20.
//  Copyright © 2020 Kumar, Karthik. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

class CustomImageView: UIImageView {
    
    var imageUrlString: String?
    
    func loadImage(with urlString: String) {        
        if let url = URL(string: urlString) {
            
            imageUrlString = url.absoluteString
            
//            self.image = nil
            
            if let imageFromCache = imageCache.object(forKey: NSString(string: url.absoluteString)) {
                self.updateImage(with: imageFromCache)
                return
            }
            
            loadFromCache(with: url)
        }
    }
    
    private func loadFromCache(with url: URL) {
        
        DispatchQueue.global(qos: .default).async {
            let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 30)
            
            if let cachedResponse = URLCache.shared.cachedResponse(for: request), let image = UIImage(data: cachedResponse.data) {
                print("Cached data in bytes:", cachedResponse.data)
        
                DispatchQueue.main.async {
                    imageCache.setObject(image, forKey: NSString(string: url.absoluteString))
                    self.updateImage(with: image)
                }
                return
            }
            
            
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                guard error == nil else {
                    print("error")
                    return
                }
                
                let cachedData = CachedURLResponse(response: response!, data: data!)
                URLCache.shared.storeCachedResponse(cachedData, for: request)
                
                DispatchQueue.main.async {
                    if let imageToCache = UIImage(data: data!) {
                        imageCache.setObject(imageToCache, forKey: NSString(string: url.absoluteString))
                        
                        if self.imageUrlString == url.absoluteString {
                            self.updateImage(with: imageToCache)
                        }
                    }
                }
                
            }.resume()
        }

    }
    
    private func updateImage(with image: UIImage) {
        UIView.transition(with: self,
                          duration: 0.5,
                          options: .transitionCrossDissolve,
                          animations: {
                            self.image = image
        })
    }
}

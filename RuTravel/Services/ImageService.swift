//
//  ImageService.swift
//  RuTravel
//
//  Created by kalinin on 23.05.2022.
//

import Foundation
import UIKit

final class ImageService {

    static let shared = ImageService()
    private init() {}

    func loadCityPictures(from imageURLs: [String],
                      completion: @escaping ([UIImage]?) -> Void) {
        let session = URLSession.shared
        let dispatchGroup = DispatchGroup()

        var images = [UIImage]()

        for imageURL in imageURLs {
            guard let URL = URL(string: imageURL) else {
                completion(nil)
                return
            }

            dispatchGroup.enter()

            let task = session.dataTask(with: URL) { (data, response, error) in
                if error != nil {
                    completion(nil)
                    return
                }

                guard let imageData = data else {
                    completion(nil)
                    return
                }

                guard let image = UIImage(data: imageData) else {
                    completion(nil)
                    return
                }

                images.append(image)
                dispatchGroup.leave()
            }
            task.resume()
        }

        dispatchGroup.notify(queue: .main) {
            completion(images)
        }
    }

    func loadPictureFrom(_ stringURL: String,
                          completion: @escaping (UIImage?) -> Void) {
        let session = URLSession.shared

        guard let URL = URL(string: stringURL) else {
            completion(nil)
            return
        }

        let request = URLRequest(url: URL)

        let task = session.dataTask(with: request) { (data, response, error) in
            if error != nil {
                completion(nil)
                return
            }

            guard
                let data = data,
                let image = UIImage(data: data) else {
                completion(nil)
                return
            }

            completion(image)
        }
        task.resume()
    }

}

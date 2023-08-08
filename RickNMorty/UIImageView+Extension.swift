//
//  UIImageView+Extension.swift
//  RickNMorty
//
//  Created by admin on 7.08.2023.
//

import UIKit

extension UIImageView {
    func downloadImage(from urlString: String, completion: @escaping (() -> Void)) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url, completionHandler: ({ data, _, error in
            if let error {
                print(error)
                completion()
            } else {
                if let imageData = data {
                    DispatchQueue.main.async { [weak self] in
                        self?.image = UIImage(data: imageData) ?? UIImage(systemName: "person.fill")
                        completion()
                    }
                }
            }
        })).resume()
    }
}

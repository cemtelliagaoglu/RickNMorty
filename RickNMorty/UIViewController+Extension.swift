//
//  UIViewController+Extension.swift
//  RickNMorty
//
//  Created by admin on 7.08.2023.
//

import UIKit

extension UIViewController {
    func showError(with message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .cancel))
        DispatchQueue.main.async { [weak self] in
            self?.present(alert, animated: true)
        }
    }
}

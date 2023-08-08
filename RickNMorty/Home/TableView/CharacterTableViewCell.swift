//
//  CharacterTableViewCell.swift
//  RickNMorty
//
//  Created by admin on 7.08.2023.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {
    @IBOutlet var characterImageView: UIImageView!
    @IBOutlet var characterNameLabel: UILabel!
    @IBOutlet var loadingIndicator: UIActivityIndicatorView!

    var viewModel: Home.Case.ViewModel? {
        didSet {
            guard let viewModel else { return }
            characterNameLabel.text = viewModel.name
            characterImageView.downloadImage(from: viewModel.imageURLString) {
                DispatchQueue.main.async { [weak self] in
                    self?.loadingIndicator.stopAnimating()
                }
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        loadingIndicator.startAnimating()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}

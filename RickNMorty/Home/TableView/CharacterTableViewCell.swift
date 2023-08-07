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

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}

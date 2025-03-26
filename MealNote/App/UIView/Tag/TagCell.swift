//
//  TagCell.swift
//  MealNote
//
//  Created by mio on 2025/03/04.
//

import UIKit

final class TagCell: UICollectionViewCell {
    @IBOutlet private weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 2
        layer.masksToBounds = true
        backgroundColor = .systemTeal
    }
    
    func setTitle(_ title: String) {
        titleLabel.text = title
        titleLabel.textColor = .white
    }
}

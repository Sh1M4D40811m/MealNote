//
//  CircleButton.swift
//  MealNote
//
//  Created by mio on 2025/03/16.
//

import UIKit

@IBDesignable
class CircleButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        var config = configuration ?? UIButton.Configuration.filled()
        config.cornerStyle = .capsule
        config.baseBackgroundColor = .systemTeal
        configuration = config
        tintColor = .white
    }
}

@IBDesignable
class CircleShadowBaseView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        layer.cornerRadius = min(frame.width, frame.height) / 2
        layer.shadowColor = UIColor.systemGray.cgColor
        layer.shadowOpacity = 0.6
        layer.shadowOffset = CGSize(width: 2, height: 2)
    }
}

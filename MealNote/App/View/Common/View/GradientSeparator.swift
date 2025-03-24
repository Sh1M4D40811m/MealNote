//
//  GradientSeparator.swift
//  MealNote
//
//  Created by mio on 2025/03/18.
//

import UIKit

@IBDesignable
class GradientSeparator: UIView {
    
    enum GradientDirection: Int {
        case topToBottom = 0
        case bottomToTop = 1
    }
    
    @IBInspectable var directionStyle: Int = 0 {
        didSet {
            direction = GradientDirection(rawValue: directionStyle) ?? .topToBottom
        }
    }
    
    private let gradientLayer = CAGradientLayer()
    private let darkColor = UIColor.systemGray2.withAlphaComponent(0.3)
    private let lightColor = UIColor.systemGray5.withAlphaComponent(0)
    private var direction: GradientDirection = .topToBottom {
        didSet { updateLayer() }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if gradientLayer.frame != bounds {
            gradientLayer.frame = bounds
        }
    }
    
    private func setupUI() {
        gradientLayer.colors = [darkColor.cgColor, lightColor.cgColor]
        gradientLayer.frame = bounds
        layer.addSublayer(gradientLayer)
    }
    
    private func updateLayer() {
        layer.sublayers?.removeAll()
        
        switch direction {
        case .topToBottom:
            gradientLayer.colors = [darkColor.cgColor, lightColor.cgColor]
        case .bottomToTop:
            gradientLayer.colors = [lightColor.cgColor, darkColor.cgColor]
        }
        
        gradientLayer.frame = bounds
        layer.addSublayer(gradientLayer)
    }
}

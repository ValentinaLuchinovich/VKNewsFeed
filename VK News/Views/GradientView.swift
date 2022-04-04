//
//  GradientView.swift
//  VK News
//
//  Created by Валентина Лучинович on 04.04.2022.
//

import Foundation
import UIKit

class GradientView: UIView {
    
    @IBInspectable private var startColor: UIColor? {
        didSet {
            setUpGradientColors()
        }
    }
    @IBInspectable private var endColor: UIColor? {
        didSet {
            setUpGradientColors()
        }
    }
    
    private let gradientLayer = CAGradientLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpGradient()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
    
    private func setUpGradient() {
        self.layer.addSublayer(gradientLayer)
        setUpGradientColors()
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
    }
    
    private func setUpGradientColors() {
        if let startColor = startColor, let endColor = endColor {
            gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        }
    }
}

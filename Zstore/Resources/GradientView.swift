//
//  GradientView.swift
//  Zstore
//
//  Created by Saravana Ganesh L on 09/11/23.
//

import UIKit

class GradientView: UIView {
    
    var vertical: Bool = true {
        didSet {
            updateGradientDirection()
        }
    }
    
    lazy var gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.startPoint = CGPoint(x: 0.5, y: 0)
        return layer
    }()
    
    //MARK: -
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        applyGradient()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        applyGradient()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateGradientFrame()
    }
    
    //MARK: -
    
    func applyGradient(with cgColorArr: [CGColor]? = nil) {
        updateGradientDirection()
        gradientLayer.cornerRadius = 20
        gradientLayer.borderColor = UIColor.white.cgColor
        gradientLayer.borderWidth = 0.8
        gradientLayer.colors = cgColorArr
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func updateGradientFrame() {
        gradientLayer.frame = bounds
    }
    
    func updateGradientDirection() {
        gradientLayer.endPoint = vertical ? CGPoint(x: 0.5, y: 1) : CGPoint(x: 1, y: 0)
    }
}

//
//  UIViewController+Gradient.swift
//  InstagramClone
//
//  Created by Bakhrom Usmanov on 16/04/25.
//

import UIKit

extension UIView {
   func setGradientBackground(startColor: UIColor, endColor: UIColor) {
      let gradientLayer = CAGradientLayer()
      gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
      gradientLayer.locations = [0, 1]
      gradientLayer.startPoint = CGPoint(x: 0, y: 0)
      gradientLayer.endPoint = CGPoint(x: 1, y: 1)
      layer.insertSublayer(gradientLayer, at: 0)
      gradientLayer.frame = frame
   }
}

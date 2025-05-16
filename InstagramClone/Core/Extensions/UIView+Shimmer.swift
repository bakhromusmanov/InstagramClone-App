//
//  UIView+Shimmer.swift
//  InstagramClone
//
//  Created by Bakhrom Usmanov on 15/05/25.
//

import UIKit

extension UIView {
   
   //MARK: - Public Functions
   
   func startShimmering() {
      let gradientLayer = addGradientLayer()
      let animation = addAnimation()
      
      gradientLayer.add(animation, forKey: animation.keyPath)
   }
   
   func stopShimmering() {
      layer.sublayers?.forEach {
         if $0.name == Constants.shimmerLayerName {
            $0.removeAllAnimations()
            $0.removeFromSuperlayer()
         }
      }
   }
   
   //MARK: - Private Functions
   
   private func addGradientLayer() -> CAGradientLayer {
      let gradientLayer = CAGradientLayer()
      gradientLayer.name = Constants.shimmerLayerName
      gradientLayer.frame = bounds
      gradientLayer.startPoint = CGPoint(x: 0, y: 1)
      gradientLayer.endPoint = CGPoint(x: 1, y: 1)
      gradientLayer.locations = [0.0, 0.5, 1.0]
      gradientLayer.colors = [
         Constants.secondaryGradientColor,
         Constants.primaryGradientColor,
         Constants.secondaryGradientColor]
      layer.addSublayer(gradientLayer)
      return gradientLayer
   }
   
   private func addAnimation() -> CABasicAnimation {
      let animation = CABasicAnimation(keyPath: "locations")
      animation.fromValue = [-1.0, -0.5, 0.0]
      animation.toValue = [1.0, 1.5, 2.0]
      animation.duration = 1
      animation.repeatCount = .infinity
      return animation
   }
}

//MARK: - Constants

private extension UIView {
   enum Constants {
      static let shimmerLayerName = "shimmerLayer"
      static let primaryGradientColor = ThemeManager.colors.backgroundPrimary.cgColor
      static let secondaryGradientColor = ThemeManager.colors.grey100.cgColor
   }
}

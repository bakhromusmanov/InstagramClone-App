//
//  RectangularDashedView.swift
//  InstagramClone
//
//  Created by Bakhrom Usmanov on 07/06/25.
//

import UIKit

final class RectangularDashedView: UIView {
   
   //MARK: Properties
   
   private var dashedBorder: CAShapeLayer?
   private var dashedBorderStrokeColor: UIColor
   private var dashedBorderLineWidth: CGFloat
   
   //MARK: - Initialization
   
   init(strokeColor: UIColor, lineWidth: CGFloat) {
      dashedBorderStrokeColor = strokeColor
      dashedBorderLineWidth = lineWidth
      super.init(frame: .zero)
   }
   
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
   //MARK: - Lifecycle
   
   override func layoutSubviews() {
      super.layoutSubviews()
      setDashedBorder()
   }
}

//MARK: - Private Methods

private extension RectangularDashedView {
   func setDashedBorder() {
      dashedBorder?.removeFromSuperlayer()
      
      let dashedLayer = CAShapeLayer()
      dashedLayer.fillColor = nil
      dashedLayer.strokeColor = dashedBorderStrokeColor.cgColor
      dashedLayer.lineWidth = dashedBorderLineWidth
      dashedLayer.lineDashPattern = [Constants.dashLength, Constants.betweenDashesSpace]
      dashedLayer.path = layer.cornerRadius > 0 ? UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath : UIBezierPath(rect: bounds).cgPath
      
      dashedBorder = dashedLayer
      layer.addSublayer(dashedLayer)
   }
}

//MARK: - Constants

private extension RectangularDashedView {
   enum Constants {
      static let dashLength: NSNumber = 8
      static let betweenDashesSpace: NSNumber = 4
   }
}



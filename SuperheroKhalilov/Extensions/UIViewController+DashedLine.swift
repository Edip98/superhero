//
//  UIViewController+DashedLine.swift
//  SuperheroKhalilov
//
//  Created by Эдип on 31.03.2022.
//

import UIKit

extension UIViewController {
    
    func drawDashedLine(start p0: CGPoint, end p1: CGPoint, view: UIView) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.white.cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.lineDashPattern = [3, 3]

        let path = CGMutablePath()
        path.addLines(between: [p0, p1])
        shapeLayer.path = path
        view.layer.addSublayer(shapeLayer)
    }
}

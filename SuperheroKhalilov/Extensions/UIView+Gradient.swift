//
//  UIView+Gradient.swift
//  SuperheroKhalilov
//
//  Created by Эдип on 19.02.2022.
//

import UIKit

extension UIView {
    
    func addBlackGradientLayerInForeground(frame: CGRect, colors:[UIColor], startPoint: CGPoint, endPoint: CGPoint) {
        let gradient = CAGradientLayer()
        gradient.frame = frame
        gradient.colors = colors.map{$0.cgColor}
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        self.layer.addSublayer(gradient)
    }
    
    func addBlackGradientLayerInBackground(frame: CGRect, colors:[UIColor], startPoint: CGPoint, endPoint: CGPoint){
        let gradient = CAGradientLayer()
        gradient.frame = frame
        gradient.colors = colors.map{$0.cgColor}
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    func rounded() {
        layer.cornerRadius = bounds.height / 2
        layer.masksToBounds = true
        clipsToBounds = true
    }
}

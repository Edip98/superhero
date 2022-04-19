//
//  UIFont+CustomFont.swift
//  SuperheroKhalilov
//
//  Created by Эдип on 19.02.2022.
//

import UIKit

extension UIFont {
    
    enum FontName: String {
        case SairaRegular = "Saira-Regular"
        case SairaMedium = "Saira-Medium"
        case FuturaBold = "Futura Bold"
        case HelveticaNeue = "HelveticaNeue"
        case HelveticaNeueLight = "HelveticaNeue-Light"
        case GilroySemibold = "Gilroy-Semibold"
        case NunitoLight = "Nunito-Light"
        case NunitoSemiBold = "Nunito-SemiBold"
        case SairaLight = "Saira-Light"
    }
    
    static func font(name: FontName, size: CGFloat) -> UIFont? {
        return UIFont(name: name.rawValue, size: size)
    }
}

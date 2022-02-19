//
//  Storyboarded.swift
//  SuperheroKhalilov
//
//  Created by Эдип on 19.02.2022.
//

import UIKit

protocol Storyboarded {
    static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController{
    static func instantiate() -> Self {
        let storyboardIdentifier = String(describing: self)
        let storyboard = UIStoryboard(name: storyboardIdentifier, bundle: .main)
        return storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as! Self
    }
}

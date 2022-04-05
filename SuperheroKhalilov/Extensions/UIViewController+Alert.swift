//
//  UIViewController+Alert.swift
//  SuperheroKhalilov
//
//  Created by Эдип on 30.03.2022.
//

import UIKit

extension UIViewController {
    
    func presentAlert(title: String, image: String, numberOfLines: Int, timeInterval: Double, completion: (() -> ())?) {
        let alertVC = CustomAlertViewController(title: title, image: image, numberOfLines: numberOfLines)
        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.modalTransitionStyle = .crossDissolve
        self.present(alertVC, animated: true)
        Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: false, block: { _ in alertVC.dismiss(animated: true, completion: completion)})
    }
}

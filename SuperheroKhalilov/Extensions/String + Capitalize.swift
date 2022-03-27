//
//  String + Capitalize.swift
//  SuperheroKhalilov
//
//  Created by Эдип on 21.03.2022.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

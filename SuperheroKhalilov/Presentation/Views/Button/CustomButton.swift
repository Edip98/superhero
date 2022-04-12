//
//  CustomButton.swift
//  SuperheroKhalilov
//
//  Created by Эдип on 27.03.2022.
//

import UIKit

class CustomButton: UIButton {
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        setupUI()
    }

    private func setupUI() {
        rounded()
        titleLabel?.textColor = .black
        backgroundColor = .customYellow
    }
}

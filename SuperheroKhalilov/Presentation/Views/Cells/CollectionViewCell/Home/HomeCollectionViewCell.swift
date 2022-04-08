//
//  HomeCollectionViewCell.swift
//  SuperheroKhalilov
//
//  Created by Эдип on 28.03.2022.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var parameterLabel: UILabel!
    @IBOutlet weak var circleView: UIView!
    @IBOutlet weak var changeValueLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var measurementLabel: UILabel!
    
    static let identifier = "HomeCollectionViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        configureCell()
        configureUI()
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "HomeCollectionViewCell", bundle: nil)
    }
    
    private func configureCell() {
        backgroundColor = .clear
        layer.borderWidth = 1
        layer.borderColor = UIColor.white.cgColor
        layer.cornerRadius = 8
    }
    
    func configure(with viewModel: BodyParameterViewModel) {
        parameterLabel.text = viewModel.bodyPart
        valueLabel.text = String(viewModel.value)
        changeValueLabel.text = viewModel.changeValueText
        circleView.backgroundColor = viewModel.color
        
        if parameterLabel.text == "Weight" {
            measurementLabel.text = "kg"
        }
    }
    
    private func configureUI() {
        circleView.rounded()
        
        valueLabel.font = UIFont.boldSystemFont(ofSize: 24)
        
        changeValueLabel.textColor = .white
        changeValueLabel.font = .font(name: .GilroySemibold, size: 12)
    }
}

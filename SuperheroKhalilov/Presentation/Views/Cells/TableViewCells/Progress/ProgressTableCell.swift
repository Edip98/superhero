//
//  ProgressTableCell.swift
//  SuperheroKhalilov
//
//  Created by Эдип on 30.03.2022.
//

import UIKit

class ProgressTableCell: UITableViewCell {
    
    @IBOutlet weak var bodyPartLabel: UILabel!
    @IBOutlet weak var underlineView: UIView!
    
    static let identifier = "ProgressTableCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        configureBodyPartLabel()
    }

    static func nib() -> UINib {
        return UINib(nibName: "ProgressTableCell", bundle: nil)
    }
    
    func configure(with viewModel: BodyParameterViewModel) {
        bodyPartLabel?.text = viewModel.bodyPart
    }
    
    private func configureBodyPartLabel() {
        bodyPartLabel.textColor = .white
        bodyPartLabel.font = UIFont.systemFont(ofSize: 18)
        underlineView.backgroundColor = .white
    }
}

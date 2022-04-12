//
//  MenuTableCell.swift
//  SuperheroKhalilov
//
//  Created by Эдип on 22.02.2022.
//

import UIKit

class MenuTableCell: UITableViewCell {
    
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var separatorView: UIView!
    
    static let identifier = "MenuTableCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "MenuTableCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        configureUI()
    }
    
    func configure(with viewModel: Any) {
        guard let viewModel = viewModel as? String else { return }
        cellLabel?.text = viewModel
    }
    
    func configureUI() {
        cellLabel.textColor = .white
        cellLabel.font = UIFont.systemFont(ofSize: 18)
        separatorView.backgroundColor = .white
    }
}

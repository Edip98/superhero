//
//  ProfileTableCell.swift
//  SuperheroKhalilov
//
//  Created by Эдип on 10.03.2022.
//

import UIKit

class ProfileTableCell: UITableViewCell {
    
    @IBOutlet weak var optionLabel: UILabel!
    
    static let identifier = "ProfileTableCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
        textLabel?.textColor = .white
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "ProfileTableCell", bundle: nil)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

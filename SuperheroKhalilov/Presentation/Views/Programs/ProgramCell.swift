//
//  ProgramCell.swift
//  SuperheroKhalilov
//
//  Created by Эдип on 18.04.2022.
//

import UIKit

class ProgramCell: UITableViewCell {

    @IBOutlet weak var cellContentView: UIView!
    @IBOutlet weak var programNamelabel: UILabel!
    @IBOutlet weak var accessoryViewImageView: UIImageView!
    
    static let identifier = "ProgramCell"
    var coordinator: MainCoordinator?
    private var programsViewModel: ProgramsViewModel?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        configure()
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "ProgramCell", bundle: nil)
    }
    
    func configure(with viewModel: CreateProgramViewModel) {
        programNamelabel.text = viewModel.labelText
    }
    
    func configure() {
        cellContentView.layer.borderWidth = 1
        cellContentView.layer.borderColor = UIColor.white.cgColor
        cellContentView.layer.cornerRadius = 25
    }
}

//
//  ProfileHeaderView.swift
//  SuperheroKhalilov
//
//  Created by Эдип on 14.03.2022.
//

import UIKit

class ProfileHeaderView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var nameTitle: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var textFieldUnderline: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadNib() {
        let bundle = Bundle(for: ProfileHeaderView.self)
        bundle.loadNibNamed("ProfileHeaderView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
    }
    
    func configureUI() {
        cameraButton.layer.cornerRadius = 8
        cameraButton.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.3)
        
        nameTitle.text = "Name"
        nameTitle.textColor = .white
        nameTitle.font = UIFont(name: UIFont.HelveticaNeue, size: 18)
    
        nameTextField.borderStyle = .none
        nameTextField.backgroundColor = .clear
        nameTextField.textColor = .white
        nameTextField.font = UIFont(name: UIFont.HelveticaNeue, size: 18)
        nameTextField.textAlignment = .left
        nameTextField.autocapitalizationType = .words
        nameTextField.attributedPlaceholder = NSAttributedString(string: "Enter Your Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 1)])
        
        textFieldUnderline.backgroundColor = .white
    }
}

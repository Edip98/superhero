//
//  ProfileFooterView.swift
//  SuperheroKhalilov
//
//  Created by Эдип on 14.03.2022.
//

import UIKit

class ProfileFooterView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var selectLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadNib() {
        let bundle = Bundle(for: ProfileFooterView.self)
        bundle.loadNibNamed("ProfileFooterView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
    }
    
    private func configureUI() {
        selectLabel.text = "Select an option to display on the main screen."
        selectLabel.textColor = .white
        selectLabel.font = UIFont(name: UIFont.sairaRegular, size: 16)
        selectLabel.textColor = UIColor.customGray
    }
}

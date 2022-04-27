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
    
    private var profileViewModel = ProfileViewModel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
        configureUI()
        configureSelectLabel()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureSelectLabel()
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
        selectLabel.text = profileViewModel.footerSelectLabel
    }
    
    private func configureSelectLabel() {
        selectLabel.textColor = .systemGray
        selectLabel.font = .font(name: .SairaRegular, size: 16)
        selectLabel.textColor = UIColor.customGray
    }
}

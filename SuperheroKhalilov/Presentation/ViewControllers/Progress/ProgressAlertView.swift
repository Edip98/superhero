//
//  ProgressAlertView.swift
//  SuperheroKhalilov
//
//  Created by Эдип on 04.04.2022.
//

import UIKit

class ProgressAlertView: UIView {

    @IBOutlet var progressAlertView: UIView!
    @IBOutlet weak var progressAlertLabel: UILabel!
    @IBOutlet weak var progressAlertImageView: UIImageView!
    
    let paragraph = NSMutableParagraphStyle()
    let progressViewModel = ProgressViewModel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
        configureProgressAlertView()
        configureProgressAlertLabel()
        configureProgressAlertImageView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNib()
    }
    
    func loadNib() {
        let viewFromXib = Bundle.main.loadNibNamed("ProgressAlertView", owner: self, options: nil)![0] as! UIView
        viewFromXib.center = self.center
        addSubview(viewFromXib)
    }
    
    func configureProgressAlertView() {
        progressAlertView.layer.borderWidth = 1
        progressAlertView.layer.cornerRadius = 8
        progressAlertView.layer.borderColor = UIColor.white.cgColor
        progressAlertView.backgroundColor = .black
    }
    
    private func configureProgressAlertLabel() {
        paragraph.lineSpacing = 5
        progressAlertLabel.textColor = .white
        progressAlertLabel.numberOfLines = 3
        progressAlertLabel.font = .font(name: .HelveticaNeue, size: 16)
        progressAlertLabel.attributedText = NSAttributedString(
            string: progressViewModel.alertLabelText,
            attributes: [NSAttributedString.Key.paragraphStyle: paragraph]
        )
    }
    
    private func configureProgressAlertImageView() {
        progressAlertImageView.image = UIImage(named: progressViewModel.alertImageName)
        progressAlertImageView.contentMode = .scaleToFill
    }
}

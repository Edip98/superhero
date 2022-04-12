//
//  CustomAlertViewController.swift
//  SuperheroKhalilov
//
//  Created by Эдип on 30.03.2022.
//

import UIKit

class CustomAlertViewController: UIViewController, Storyboarded {
    
    @IBOutlet var alertView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var alertTextLabel: UILabel!
    @IBOutlet weak var alertImageView: UIImageView!
    
    var alertTitle: String?
    var alertImage: String?
    var numberOfLines: Int?
    
    let paragraph = NSMutableParagraphStyle()
    
    init(title: String, image: String, numberOfLines: Int) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = title
        self.alertImage = image
        self.numberOfLines = numberOfLines
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI() {
        paragraph.lineSpacing = 5
        
        alertView.backgroundColor = .black.withAlphaComponent(0.65)
        
        contentView.layer.borderWidth = 1
        contentView.layer.cornerRadius = 8
        contentView.layer.borderColor = UIColor.white.cgColor
        contentView.backgroundColor = .black
        
        alertTextLabel.textColor = .white
        alertTextLabel.numberOfLines = numberOfLines ?? 0
        alertTextLabel.font = .font(name: .HelveticaNeue, size: 16)
        alertTextLabel.attributedText = NSAttributedString(
            string: alertTitle ?? "",
            attributes: [NSAttributedString.Key.paragraphStyle: paragraph]
        )
        alertImageView.image = UIImage(named: alertImage ?? "")
        alertImageView.contentMode = .scaleToFill
    }
}

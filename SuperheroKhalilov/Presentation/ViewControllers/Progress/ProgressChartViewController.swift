//
//  ProgressChartViewController.swift
//  SuperheroKhalilov
//
//  Created by Эдип on 31.03.2022.
//

import UIKit

class ProgressChartViewController: UIViewController, Storyboarded {
    
    
    @IBOutlet weak var bodyNameLabel: UILabel!
    @IBOutlet weak var measurementLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!

    var coordinator: MainCoordinator?
    private var progressViewModel = ProgressViewModel()
    
    var bodyNameLabelText = ""

    override func viewDidLoad() {
        super.viewDidLoad() 
        view.backgroundColor = .black
        configureUI()
    }
    
    func configureUI() {
        bodyNameLabel.text = bodyNameLabelText
        bodyNameLabel.font = .font(name: .SairaRegular, size: 24)
        measurementLabel.font = .font(name: .SairaRegular, size: 24)
        measurementLabel.text = progressViewModel.measurementLabelText
        
        if bodyNameLabelText == "Weight" {
            measurementLabel.text = "kg"
        }
        
        textLabel.text = progressViewModel.textLabelText
        textLabel.textColor = .customGray
        textLabel.numberOfLines = 2
        textLabel.font = .font(name: .SairaRegular, size: 18)
    }
}


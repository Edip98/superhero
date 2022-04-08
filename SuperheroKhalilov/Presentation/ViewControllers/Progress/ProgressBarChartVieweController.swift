//
//  ProgressBarChartVieweController.swift
//  SuperheroKhalilov
//
//  Created by Эдип on 06.04.2022.
//

import UIKit

class ProgressBarChartViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var barChartView: BarChartView!
    @IBOutlet weak var bodyNameLabel: UILabel!
    @IBOutlet weak var measurementLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    var coordinator: MainCoordinator?
    var progressViewModel = ProgressViewModel()
    
    var bodyNameLabelText = ""
    var date = Date()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        configureUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        drawBarChart()
    }
    
    private func drawBarChart() {
        if progressViewModel.bodyParameterViewModel.isEmpty == false {
            UIView.animate(withDuration: 2) {
                self.barChartView.dataEntries = self.progressViewModel.createDataEntries()
            }
        }
    }
    
    private func configureUI() {
        barChartView.backgroundColor = .clear
        
        bodyNameLabel.text = bodyNameLabelText
        bodyNameLabel.font = .font(name: .SairaRegular, size: 24)
        
        if bodyNameLabelText == "Weight" {
            measurementLabel.text = "kg"
        }
        
        measurementLabel.font = .font(name: .SairaRegular, size: 24)
        measurementLabel.text = progressViewModel.measurementLabelText
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.YYYY"
        let startDate = formatter.string(from: date)
      
        descriptionLabel .text = "\(progressViewModel.textLabelText)" + " " + "\(startDate)"
        descriptionLabel .textColor = .customGray
        descriptionLabel .numberOfLines = 2
        descriptionLabel .font = .font(name: .SairaMedium, size: 18)
    }
}

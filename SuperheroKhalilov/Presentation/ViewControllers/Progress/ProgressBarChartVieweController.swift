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

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = progressViewModel.configureTitle()
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
        
        bodyNameLabel.text = progressViewModel.configureBodyNameLabel()
        bodyNameLabel.font = .font(name: .SairaRegular, size: 24)
        
        descriptionLabel .text = progressViewModel.configureDescriptionLabel()
        descriptionLabel .textColor = .customGray
        descriptionLabel .numberOfLines = 2
        descriptionLabel .font = .font(name: .SairaMedium, size: 18)
    }
}

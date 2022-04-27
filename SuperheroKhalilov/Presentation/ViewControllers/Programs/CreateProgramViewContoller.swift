//
//  CreateProgramViewContoller.swift
//  SuperheroKhalilov
//
//  Created by Эдип on 18.04.2022.
//

import Foundation
import UIKit

class CreateProgramViewContoller: UIViewController, Storyboarded {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addExerciseButton: UIButton!
    @IBOutlet weak var buttonView: UIView!
    
    var coordinator: MainCoordinator?
    var createProgramViewModel: CreateProgramViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = createProgramViewModel?.navigationBarTitle
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: createProgramViewModel?.rightBarButtonItemTitle, style: .plain, target: self, action: #selector(saveButtonPressed))
        navigationItem.rightBarButtonItem?.isEnabled = false
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 80, right: 0)
        configureTableView()
        configureButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func configureTableView() {
        tableView.register(CreateProgramCell.nib(), forCellReuseIdentifier: CreateProgramCell.identifier)
        tableView.register(UINib(nibName: CreateProgramHeader.identifier, bundle: nil), forHeaderFooterViewReuseIdentifier: CreateProgramHeader.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
    }
    
    func configureButton() {
        buttonView.backgroundColor = .clear
        buttonView.addBlackGradientLayerInBackground(
            frame: buttonView.bounds,
            colors: [.black.withAlphaComponent(1), .black.withAlphaComponent(0.7)],
            startPoint: .init(x: 0.5, y: 1.0),
            endPoint: .init(x: 0.5, y: 0.0)
        )
    }
    
    @IBAction func addButtonAction(_ sender: CustomButton) {
        coordinator?.presentMusclesViewController(delegate: self)
    }
    
    @objc func saveButtonPressed() {
        createProgramViewModel?.saveButtonTapped()
        presentAlert(title: createProgramViewModel?.alertTitle ?? "", image: createProgramViewModel?.alertImageName ?? "", numberOfLines: 1, timeInterval: 2) {
            self.coordinator?.back()
        }
    }
}

extension CreateProgramViewContoller: ExerciseSelectionProtocol {
    
    func didSelectExercises(exercises: [ExerciseViewModel]) {
        createProgramViewModel?.changeExercises(exercises)
        navigationItem.rightBarButtonItem?.isEnabled = createProgramViewModel?.isSaveButtonEnable ?? true
    }
}

extension CreateProgramViewContoller: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let createProgramHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: CreateProgramHeader.identifier) as! CreateProgramHeader
        guard let viewModel = createProgramViewModel else { return nil}
        createProgramHeader.configure(with: viewModel)
        createProgramHeader.delegate = self
        return createProgramHeader
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 294
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return createProgramViewModel?.inputProgram.exercises.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CreateProgramCell.identifier, for: indexPath) as? CreateProgramCell, let viewModel = createProgramViewModel else { return UITableViewCell() }
        cell.configure(with: viewModel.inputProgram.exercises[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            print("Deleted")
        }
    }
}

extension CreateProgramViewContoller: CreateProgramHeaderDelegate {
    
    func nameTFEditingChanged(_ text: String) {
        createProgramViewModel?.changedName(text)
        navigationItem.rightBarButtonItem?.isEnabled = createProgramViewModel?.isSaveButtonEnable ?? true
    }
    
    func descriptionTFEditingChanged(_ text: String) {
        createProgramViewModel?.changedDescription(text)
        createProgramViewModel?.saveButtonTapped()
        navigationItem.rightBarButtonItem?.isEnabled = createProgramViewModel?.isSaveButtonEnable ?? true
    }
}

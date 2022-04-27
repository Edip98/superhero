//
//  ProgramsViewController.swift
//  SuperheroKhalilov
//
//  Created by Эдип on 22.02.2022.
//

import UIKit

class ProgramsViewController: BaseViewController {
    
    @IBOutlet weak var yourProgramsLabel: UILabel!
    @IBOutlet weak var programsTableView: UITableView!
    @IBOutlet weak var createNewProgramButton: CustomButton!
    @IBOutlet weak var buttonView: UIView!
    
    var coordinator: MainCoordinator?
    var programsViewModel = ProgramsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureYourProgramsLabel()
        configureProgramsTableView()
        configureCreateNewProgramButton()
        configureCreateNewProgramButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        programsViewModel.updatePrograms()
        programsTableView.reloadData()
        programsTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 80, right: 0)
    }

    func configureYourProgramsLabel() {
        yourProgramsLabel.text = programsViewModel.labelText
        yourProgramsLabel.textColor = .white
        yourProgramsLabel.font = .font(name: .SairaRegular, size: 24)
    }
    
    func configureProgramsTableView() {
        programsTableView.register(ProgramCell.nib(), forCellReuseIdentifier: ProgramCell.identifier)
        programsTableView.delegate = self
        programsTableView.dataSource = self
        programsTableView.backgroundColor = .clear
        
    }
    
    func configureCreateNewProgramButton() {
        buttonView.backgroundColor = .clear
        buttonView.addBlackGradientLayerInBackground(
            frame: buttonView.bounds,
            colors: [.black.withAlphaComponent(1), .black.withAlphaComponent(0.7)],
            startPoint: .init(x: 0.5, y: 1.0),
            endPoint: .init(x: 0.5, y: 0.0)
        )
        
        createNewProgramButton.setTitle(programsViewModel.buttonTitle, for: .normal)
        createNewProgramButton.titleLabel?.font = .font(name: .SairaRegular, size: 16)
    }
    
    @IBAction func buttonAction(_ sender: UIButton) {
        coordinator?.presentCreateProgramViewContoller(with: .create)
    }
}

extension ProgramsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return programsViewModel.programs.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 69
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = programsTableView.dequeueReusableCell(withIdentifier: ProgramCell.identifier, for: indexPath) as? ProgramCell else { return UITableViewCell() }
        cell.configure(with: programsViewModel.createProgramViewModel()[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.moveToProgram(with: .edit(program: programsViewModel.programs[indexPath.row]))
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            programsViewModel.programs.remove(at: indexPath.row)
            programsTableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

//
//  ProgramManager.swift
//  SuperheroKhalilov
//
//  Created by Эдип on 19.04.2022.
//

import Foundation

class ProgramManager {
    
    static let sharedInstance = ProgramManager()
    
    private var programsData: String {
        return getDirectoryPath().appendingPathComponent("ProgramData").path
    }
    
    lazy var programs: [ProgramModel] = {
        return fetchPrograms()
    }()
    
    func saveProgram(_ program: ProgramModel) {
        programs.append(program)
        saveToArchive()
    }
    
    func updateProgram(oldProgram: ProgramModel, newProgram: ProgramModel) {
        if let index = programs.firstIndex(where: { $0.programID == oldProgram.programID }) {
            programs[index] = newProgram
        }
        saveToArchive()
    }
    
//    func deleteFromArchive() {
//
//        do {
//            try FileManager.default.removeItem(atPath: programsData)
//        } catch {
//            print("error is: \(error.localizedDescription)")
//        }
//    }
    
    private func fetchPrograms() -> [ProgramModel] {
        
        guard let unarchiveData = NSKeyedUnarchiver.unarchiveObject(withFile: programsData) as? Data else { return [] }
        
        do {
            self.programs = try PropertyListDecoder().decode([ProgramModel].self, from: unarchiveData)
        } catch {
            print("error is: \(error.localizedDescription)")
            return []
        }
        return programs
    }
    
    private func saveToArchive() {
        
        do {
            let data = try PropertyListEncoder().encode(programs)
            NSKeyedArchiver.archiveRootObject(data, toFile: programsData)
        } catch {
            print("error is: \(error.localizedDescription)")
        }
    }

    private func getDirectoryPath() -> URL {
        let arrayPaths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return arrayPaths[0]
    }
}

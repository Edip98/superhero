//
//  ExerciseStorage.swift
//  SuperheroKhalilov
//
//  Created by Эдип on 14.04.2022.
//

import Foundation

class ExerciseStorage {
    
    func fetchExercisesByMyscleTypes() -> [Muscle] {
        let fileData = readLocalFile(forName: "Exercises")
        let results: [Muscle] = parseJSON(jsonData: fileData)
        return results
    }
    
    private func parseJSON<T: Decodable>(jsonData: Data) -> T {
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: jsonData)
            return decodedData
        } catch {
            fatalError("Decode error")
        }
    }
    
    private func readLocalFile(forName name: String) -> Data {
        do {
            guard let bundlePath = Bundle.main.path(forResource: name, ofType: "json"),
                  let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) else  { fatalError("Failed to read json data") }
            return jsonData
        } catch {
            fatalError("Failed to read local file")
        }
    }
}

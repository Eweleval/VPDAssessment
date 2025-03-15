//
//  UserDefault+Extension.swift
//  VPDAssessment
//
//  Created by Wellz Val on 3/15/25.
//

import Foundation

extension UserDefaults {
    enum UserDefaultKeys: String {
        case userDetails
        case userCommits
        case repos
    }
    
    var offLineRepo: GitResponse? {
        get{
            get(key: UserDefaultKeys.repos.rawValue, type: [Repositories].self)
        }
        set {
            set(key: UserDefaultKeys.repos.rawValue, newValue: newValue, type: [Repositories].self)
        }
    }
    
    private func get<T: Codable>(key: String, type: T.Type) -> T? {
        if let savedData = object(forKey: key) as? Data {
            do {
                return try JSONDecoder().decode(T.self, from: savedData)
            } catch {
                print(error)
                return nil
            }
        }
        return nil
    }
    private func set<T: Codable>(key: String, newValue: T?, type: T.Type) {
        if newValue == nil {
            removeObject(forKey: key)
            return
        }
        do {
            let encoded: Data = try JSONEncoder().encode(newValue)
            set(encoded, forKey: key)
        } catch {
            print(error)
        }
    }
    
}

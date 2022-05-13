//
//  UserDefaultsManager.swift
//  ProjectForAcademyIOS
//
//  Created by Nikita on 14.04.2022.
//

import UIKit

class DataBaseUserDefaults {
    
    static let shared = DataBaseUserDefaults()
    
    enum SettingKeys: String {
        case users
        case activeUser
        case logoutUser
    }
    
    let defaults = UserDefaults.standard
    let userKey = SettingKeys.users.rawValue
    let activeUserKey = SettingKeys.activeUser.rawValue
    let logoutUserKey = SettingKeys.logoutUser.rawValue
    
    var users: [User] {
        get {
            if let data = defaults.value(forKey: userKey) as? Data {
                return try! PropertyListDecoder().decode([User].self, from: data)
            } else {
                return [User]()
            }
        }
        
        set {
            if let data = try? PropertyListEncoder().encode(newValue) {
                defaults.set(data, forKey: userKey)
            }
        }
    }
    
    func saveUser(login: String, password: String){
        
        let user = User(login: login, password: password)
        users.insert(user, at: 0)
    }
    
}
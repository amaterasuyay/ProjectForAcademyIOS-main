//
//  UserDefaultsManager.swift
//  ProjectForAcademyIOS
//
//  Created by Nikita on 14.04.2022.
//

import UIKit

final class DataBaseUserDefaults {
    
    static let shared = DataBaseUserDefaults()
    
    private enum SettingKeys: String {
        case users
        case isLoggedIn
    }
    
    private let defaults = UserDefaults.standard
    private let userKey = SettingKeys.users.rawValue
    private let isLoggedInKey = SettingKeys.isLoggedIn.rawValue
    let inLogin = UserDefaults.standard.bool(forKey: "isLoggedIn")
    
    func setIsLoggedIn(value: Bool) {
        defaults.set(value, forKey: isLoggedInKey)
        defaults.synchronize()
    }
    
    func isLogged() -> Bool {
        return defaults.bool(forKey: isLoggedInKey)
    }
    
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

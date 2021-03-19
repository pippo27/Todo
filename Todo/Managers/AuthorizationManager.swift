//
//  AuthorizationManager.swift
//  Todo
//
//  Created by Arthit Thongpan on 19/3/2564 BE.
//

import Foundation

class AuthorizationManager {
    static let shared = AuthorizationManager()
    
    fileprivate let USER_KEY = "user"
    fileprivate let TOKEN_KEY = "token"

    var user: User? {
        set {
            guard let value = newValue else {
                clearUser()
                return
            }
            
            setUser(value)
        }
        
        get {
            let defaults = UserDefaults.standard
            guard let userData = defaults.object(forKey: USER_KEY) as? Data else { return nil }
            
            let decoder = JSONDecoder()
            let user = try? decoder.decode(User.self, from: userData)
            return user
        }
    }
    
    var token: String? {
        set {
            guard let value = newValue else {
                clearToken()
                return
            }
            
            setToken(value)
        }
        
        get {
            return UserDefaults.standard.string(forKey: TOKEN_KEY)
        }
    }
    
    // MARK: - User
    
    fileprivate func setUser(_ user: User) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(user) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: USER_KEY)
            print("Save user: \(user)")
        }
    }
    
    fileprivate func clearUser() {
        print("Clear user")
        UserDefaults.standard.removeObject(forKey: USER_KEY)
        UserDefaults.standard.synchronize()
    }
    
    // MARK: - Token
    
    fileprivate func setToken(_ token: String) {
        print("Save Token: (\(token)")
        UserDefaults.standard.set(token, forKey: TOKEN_KEY)
        UserDefaults.standard.synchronize()
    }
    
    fileprivate func clearToken() {
        print("Clear Token")
        UserDefaults.standard.removeObject(forKey: TOKEN_KEY)
        UserDefaults.standard.synchronize()
    }
}

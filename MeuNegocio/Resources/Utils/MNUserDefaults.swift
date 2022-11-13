//
//  UserDefaultsMN.swift
//  MeuNegocio
//
//  Created by Renilson Moreira on 27/10/22.
//

import Foundation

public class MNUserDefaults {
    private static let defaults = UserDefaults.standard
    
    // MARK: Check
    public static func checkExistenceKey(key: String) -> Bool {
        return defaults.object(forKey: key) != nil
    }
    
    // MARK: Set
    public static func set(value: Bool, forKey key: String) {
        defaults.set(value, forKey: key)
        defaults.synchronize()
    }
    
    public static func set(value: String, forKey key: String) {
        defaults.set(value, forKey: key)
        defaults.synchronize()
    }
    
    public static func set(value: Int, forKey key: String) {
        defaults.set(value, forKey: key)
        defaults.synchronize()
    }
    
    // MARK: - Get
    public static func get(intForKey: String) -> Int? {
        if checkExistenceKey(key: intForKey) == false {
            return nil
        }
        return defaults.integer(forKey: intForKey)
    }
    
    public static func get(boolForKey: String) -> Bool? {
        if checkExistenceKey(key: boolForKey) == false {
            return nil
        }
        return defaults.bool(forKey: boolForKey)
    }
    
    public static func get(stringForKey: String) -> String? {
        if checkExistenceKey(key: stringForKey) == false {
            return nil
        }
        return defaults.string(forKey: stringForKey)
    }
    
    // MARK: - Remove
    public static func remove(key: String) {
        defaults.removeObject(forKey: key)
        defaults.synchronize()
    }
}

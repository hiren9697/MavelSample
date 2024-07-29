//
//  DictionaryExtension.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 14/07/24.
//

import Foundation

extension NSDictionary {
    
    func getAllKeysSorted() -> [Int] {
        var keys: [Int] = []
        for key in allKeys {
            if let number = key as? NSNumber {
                keys.append(number.intValue)
            } else if let str = key as? NSString {
                keys.append(str.integerValue)
            }
        }
        return keys.sorted()
    }
    
    func getAllKeys() -> [String] {
        var keys: [String] = []
        for key in allKeys {
            if let number = key as? NSNumber {
                keys.append(number.stringValue)
            } else if let str = key as? String {
                keys.append(str)
            }
        }
        return keys.sorted()
    }
    
    func getDoubleValue(key: String) -> Double {
        if let any = object(forKey: key){
            if let number = any as? NSNumber {
                return number.doubleValue
            } else if let str = any as? NSString {
                return str.doubleValue
            }
        }
        return 0
    }
    
    func getDoubleValueOptional(key: String) -> Double? {
        if let any = object(forKey: key){
            if let number = any as? NSNumber {
                return number.doubleValue
            } else if let str = any as? NSString {
                return str.doubleValue
            }
        }
        return nil
    }
    
    func getFloatValue(key: String) -> Float{
        if let any = object(forKey: key){
            if let number = any as? NSNumber{
                return number.floatValue
            }else if let str = any as? NSString{
                return str.floatValue
            }
        }
        return 0
    }
    
    func getIntValue(key: String) -> Int{
        if let any = object(forKey: key){
            if let number = any as? NSNumber{
                return number.intValue
            }else if let str = any as? NSString{
                return str.integerValue
            }
        }
        return 0
    }
    
    func getIntArray(key: String) -> [Int] {
        var numbers: [Int] = []
        if let arr = object(forKey: key) as? NSArray {
            for any in arr {
                if let number = any as? NSNumber {
                    numbers.append(number.intValue)
                } else if let str = any as? NSString {
                    numbers.append(str.integerValue)
                }
            }
        }
        return numbers
    }

    func getInt32Value(key: String) -> Int32{
        if let any = object(forKey: key){
            if let number = any as? NSNumber{
                return number.int32Value
            }else if let str = any as? NSString{
                return str.intValue
            }
        }
        return 0
    }
    
    func getInt16Value(key: String) -> Int16{
        if let any = object(forKey: key){
            if let number = any as? NSNumber{
                return number.int16Value
            }else if let str = any as? NSString{
                return Int16(str.intValue)
            }
        }
        return 0
    }
    
    func getStringValue(key: String) -> String {
        if let any = object(forKey: key){
            if let number = any as? NSNumber{
                return number.stringValue
            }else if let str = any as? String{
                return str
            }
        }
        return ""
    }
    
    func getOptionalStringValue(key: String) -> String? {
        if let any = object(forKey: key){
            if let number = any as? NSNumber{
                return number.stringValue
            }else if let str = any as? String{
                return str
            }
        }
        return nil
    }
    
    func getStringArray(key: String) -> [String] {
        var strings: [String] = []
        if let arr = object(forKey: key) as? NSArray {
            for any in arr {
                if let number = any as? NSNumber{
                    strings.append(number.stringValue)
                } else if let str = any as? String{
                    strings.append(str)
                }
            }
        }
        return strings
    }
    
    func getBooleanValue(key: String) -> Bool {
        if let any = object(forKey: key) {
            if let num = any as? NSNumber {
                return num.boolValue
            } else if let str = any as? NSString {
                return str.boolValue
            }
        }
        return false
    }
    
    func getOptionalBooleanValue(key: String)-> Bool? {
        if let any = object(forKey: key) {
            if let num = any as? NSNumber {
                return num.boolValue
            } else if let str = any as? NSString {
                return str.boolValue
            }
        }
        return nil
    }
}

extension Dictionary {
    
    mutating func merge(with dictionary: Dictionary) {
        dictionary.forEach { updateValue($1, forKey: $0) }
    }
    
    func merged(with dictionary: Dictionary) -> Dictionary {
        var dict = self
        dict.merge(with: dictionary)
        return dict
    }
}


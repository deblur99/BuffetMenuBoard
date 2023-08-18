//
//  User.swift
//  BuffetMenuBoard
//
//  Created by 한현민 on 2023/08/18.
//

import Foundation

enum UserType: String {
    case none
    case owner
    case customer
    
    static func getUserTypeFromString(_ string: String) -> UserType {
        switch string {
        case "owner":
            return .owner
        case "customer":
            return .customer
        default:
            return .none
        }
    }
}

// collection ->
struct User: Identifiable {
    var id = UUID().uuidString
    var name: String
    var userType: UserType
    
    var userTypeString: String {
        switch userType {
        case .owner:
            return "owner"
        case .customer:
            return "customer"
        case .none:
            return "others"
        }
    }
}

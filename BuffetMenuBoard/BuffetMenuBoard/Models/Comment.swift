//
//  Comment.swift
//  BuffetMenuBoard
//
//  Created by 한현민 on 2023/08/18.
//

import Foundation

struct Comment {
    var id: String = UUID().uuidString
    var user: User
    var text: String
    var createdAt: Double = Date().timeIntervalSince1970
    
    var createdDate: String {
        let dateCreatedAt: Date = .init(timeIntervalSince1970: createdAt)
        
        let dateFormatter: DateFormatter = .init()
        dateFormatter.locale = .init(identifier: "ko_kr")
        dateFormatter.timeZone = .init(abbreviation: "KST")
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        
        return dateFormatter.string(from: dateCreatedAt)
    }
}

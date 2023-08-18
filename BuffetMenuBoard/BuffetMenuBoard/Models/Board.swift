//
//  Board.swift
//  BuffetMenuBoard
//
//  Created by 한현민 on 2023/08/18.
//

import Foundation

struct Board {
    var articles: [Article]
}

struct Article: Identifiable {
    var id = UUID().uuidString
    var username: String               // 작성자
    var menuList: [String]         // 메뉴 목록
    var content: String          // 본문
    var createdAt: Double = Date().timeIntervalSince1970    // 작성 시간
    var likes: Int       // 좋아요 수
    
    var createdDate: String {
        let dateCreatedAt: Date = .init(timeIntervalSince1970: createdAt)
        
        let dateFormatter: DateFormatter = .init()
        dateFormatter.locale = .init(identifier: "ko_kr")
        dateFormatter.timeZone = .init(abbreviation: "KST")
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        
        return dateFormatter.string(from: dateCreatedAt)
    }
}

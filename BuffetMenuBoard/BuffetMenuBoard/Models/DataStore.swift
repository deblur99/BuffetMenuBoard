//
//  BoardStore.swift
//  BuffetMenuBoard
//
//  Created by 한현민 on 2023/08/18.
//

import FirebaseFirestore
import Foundation

class UserStore: ObservableObject {
    @Published var users: [User] = UserStore.sampleData
    
    let dbRef = Firestore.firestore().collection("Users")
    
    func fetchUsers() {
        dbRef.getDocuments { snapshot, _ in
            self.users.removeAll()
            
            if let snapshot {
                var tempUsers: [User] = []
                
                for document in snapshot.documents {
                    let docData: [String: Any] = document.data()
                    let id: String = docData["id"] as? String ?? ""
                    let name: String = docData["name"] as? String ?? ""
                    let userType = UserType.getUserTypeFromString(docData["userType"] as! String)
                    
                    tempUsers.append(User(id: id, name: name, userType: userType))
                }
                
                self.users = tempUsers
            }
        }
    }
    
    func addUser(_ user: User) {
        dbRef.document(user.id)
            .setData([
                "id": user.id,
                "name": user.name,
                "userType": user.userTypeString
            ])
    }
    
    func removeUser(_ user: User) {
        dbRef.document(user.id).delete()
        fetchUsers()
    }
}

extension UserStore {
    static let sampleData: [User] = [
        User(id: "1A", name: "Shim", userType: .owner),
        User(id: "2A", name: "Han", userType: .customer)
    ]
}

class BoardStore: ObservableObject {
    @Published var board: Board = BoardStore.sampleData
    
    let dbRef = Firestore.firestore().collection("Board")
    
    func fetchBoard() {
        dbRef.getDocuments { snapshot, _ in
            self.board.articles.removeAll()
            
            if let snapshot {
                var tempArticles: [Article] = []
                
                for document in snapshot.documents {
                    let docData: [String: Any] = document.data()
                    
                    let username: String = docData["username"] as? String ?? ""
                    
                    let menuList: [String] = docData["menuList"] as! [String]
                    
                    let content: String = docData["content"] as? String ?? ""
                    
                    let createdAt: Double = docData["createdAt"] as? Double ?? 0.0
                    
                    let likes: Int = docData["likes"] as? Int ?? 0
                   
                    tempArticles.append(Article(username: username, menuList: menuList, content: content, createdAt: createdAt, likes: likes))
                }
                
                self.board.articles = tempArticles
            }
        }
    }
    
    func addArticle(_ article: Article) {
        dbRef.document(article.id)
            .setData([
                "username": article.username,
                "menuList": article.menuList,
                "content": article.content,
                "createdAt": article.createdAt,
                "likes": article.likes
            ])
    }
    
    func removeArticle(_ article: Article) {
        dbRef.document(article.id).delete()
        fetchBoard()
    }
    
    func updateArticle(_ article: Article) {
        dbRef.document(article.id).updateData([
            "username": article.username,
            "menuList": article.menuList,
            "content": article.content,
            "createdAt": article.createdAt,
            "likes": article.likes
        ])
        fetchBoard()
    }
}

extension BoardStore {
    static let sampleData: Board = .init(articles: [
        Article(username: "Shim", menuList: ["수육"], content: "날씨 더운 날 수육 드시러 오세요~~", likes: 25)
    ])
}

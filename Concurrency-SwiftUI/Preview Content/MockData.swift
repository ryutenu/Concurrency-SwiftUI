//
//  MockData.swift
//  Concurrency-SwiftUI
//
//  Created by Alan Liu on 2023/04/11.
//

import Foundation

extension User {
    static var mockUsers: [User] {
        Bundle.main.decode([User].self, from: "users.json")
    }
    
    static var mockSingleUser: User {
        mockUsers[0]
    }
}

extension Post {
    static var mockPosts: [Post] {
        Bundle.main.decode([Post].self, from: "posts.json")
    }
    
    static var mockSinglePost: Post {
        mockPosts[0]
    }
    
    static var mockSingleUsersPostsArray: [Post] {
        mockPosts.filter { $0.userId == 1 }
    }
}

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
    
    static var mockSingleUserPosts: [Post] {
        mockPosts.filter { $0.userId == 1 }
    }
}

extension UserAndPosts {
    static var mockUsersAndPosts: [UserAndPosts] {
        var usersAndPosts: [UserAndPosts] = []
        
        for user in User.mockUsers {
            let userAndPosts = UserAndPosts(user: user, posts: Post.mockPosts.filter { $0.userId == user.id })
            usersAndPosts.append(userAndPosts)
        }
        
        return usersAndPosts
    }
}

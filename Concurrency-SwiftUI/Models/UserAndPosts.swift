//
//  UserAndPosts.swift
//  Concurrency-SwiftUI
//
//  Created by Alan Liu on 2023/04/14.
//

import Foundation

struct UserAndPosts: Identifiable {
    var id = UUID()
    let user: User
    let posts: [Post]
    var numberOfPosts: Int { posts.count }
}

//
//  UserListViewModel.swift
//  Concurrency-SwiftUI
//
//  Created by Alan Liu on 2023/04/11.
//

import Foundation

class UserListViewModel: ObservableObject {
    @Published var usersAndPosts: [UserAndPosts] = []
    @Published var isLoading = false
    @Published var showAlert = false
    @Published var errorMessage: String?
    
    @MainActor
    func fetchUsers() async {
        let apiService1 = APIService(urlString: "https://jsonplaceholder.typicode.com/users")
        let apiService2 = APIService(urlString: "https://jsonplaceholder.typicode.com/posts")
        
        isLoading.toggle()
        
        defer {
            isLoading.toggle()
        }
        
        do {
            async let users: [User] = try await apiService1.getJSON()
            async let posts: [Post] = try await apiService2.getJSON()
            
            let (fetchedUsers, fetchedPosts) = await (try users, try posts)
            
            for user in fetchedUsers {
                let userPosts = fetchedPosts.filter { $0.userId == user.id }
                let userAndPosts = UserAndPosts(user: user, posts: userPosts)
                usersAndPosts.append(userAndPosts)
            }
        } catch {
            showAlert = true
            errorMessage = error.localizedDescription + "\nPlease contact the developer and provide this error and the steps to reproduce."
        }
    }
}

extension UserListViewModel {
    convenience init(forPreview: Bool = false) {
        self.init()
        
        if forPreview {
            usersAndPosts = UserAndPosts.mockUsersAndPosts
        }
    }
}

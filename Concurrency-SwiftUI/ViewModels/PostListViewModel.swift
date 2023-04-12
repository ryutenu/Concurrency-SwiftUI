//
//  PostListViewModel.swift
//  Concurrency-SwiftUI
//
//  Created by Alan Liu on 2023/04/12.
//

import Foundation

class PostListViewModel: ObservableObject {
    @Published var posts: [Post] = []
    @Published var isLoading = false
    @Published var showAlert = false
    @Published var errorMessage: String?
    var userId: Int?
    
    @MainActor
    func fetchPosts() async {
        guard let userId else { return }
        
        let apiService = APIService(urlString: "https://jsonplaceholder.typicode.com/users/\(userId)/posts")
        
        isLoading.toggle()
        
        defer {
            isLoading.toggle()
        }
        
        do {
            posts = try await apiService.getJSON()
        } catch {
            showAlert = true
            errorMessage = error.localizedDescription + "\nPlease contact the developer and provide this error and the steps to reproduce."
        }
    }
}

extension PostListViewModel {
    convenience init(forPreview: Bool = false) {
        self.init()
        
        if forPreview {
            posts = Post.mockPosts
        }
    }
}

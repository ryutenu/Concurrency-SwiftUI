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
    
    func fetchPosts() {
        guard let userId else { return }
        
        let apiService = APIService(urlString: "https://jsonplaceholder.typicode.com/users/\(userId)/posts")
        
        isLoading.toggle()
        
        apiService.getJSON { (result: Result<[Post], APIError>) in
            defer {
                DispatchQueue.main.async {
                    self.isLoading.toggle()
                }
            }
            
            switch result {
            case .success(let posts):
                DispatchQueue.main.async {
                    self.posts = posts
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showAlert = true
                    self.errorMessage = error.localizedDescription + "\nPlease contact the developer and provide this error and the steps to reproduce."
                }
            }
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

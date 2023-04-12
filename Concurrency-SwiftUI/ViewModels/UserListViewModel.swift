//
//  UserListViewModel.swift
//  Concurrency-SwiftUI
//
//  Created by Alan Liu on 2023/04/11.
//

import Foundation

class UserListViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var isLoading = false
    @Published var showAlert = false
    @Published var errorMessage: String?
    
    @MainActor
    func fetchUsers() async {
        let apiService = APIService(urlString: "https://jsonplaceholder.typicode.com/users")
        
        isLoading.toggle()
        
        defer {
            isLoading.toggle()
        }
        
        do {
            users = try await apiService.getJSON()
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
            users = User.mockUsers
        }
    }
}

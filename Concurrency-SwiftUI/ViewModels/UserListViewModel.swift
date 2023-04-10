//
//  UserListViewModel.swift
//  Concurrency-SwiftUI
//
//  Created by Alan Liu on 2023/04/11.
//

import Foundation

class UserListViewModel: ObservableObject {
    @Published var users: [User] = []
    
    func fetchUsers() {
        let apiService = APIService(urlString: "https://jsonplaceholder.typicode.com/users")
        
        apiService.getJSON { (result: Result<[User], APIError>) in
            switch result {
            case .success(let users):
                DispatchQueue.main.async {
                    self.users = users
                }
            case .failure(let error):
                print(error)
            }
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

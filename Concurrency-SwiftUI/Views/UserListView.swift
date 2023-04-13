//
//  UserListView.swift
//  Concurrency-SwiftUI
//
//  Created by Alan Liu on 2023/04/10.
//

import SwiftUI

struct UserListView: View {
    @StateObject var vm = UserListViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(vm.usersAndPosts) { userAndPost in
                        NavigationLink {
                            PostListView(posts: userAndPost.posts)
                        } label: {
                            VStack(alignment: .leading) {
                                HStack {
                                    Text(userAndPost.user.name ?? "")
                                        .font(.title)
                                    Spacer()
                                    Text("(\(userAndPost.numberOfPosts))")
                                }
                                
                                Text(userAndPost.user.email ?? "")
                                Rectangle()
                                    .foregroundColor(.gray)
                                    .frame(height: 0.5)
                            }
                            .foregroundColor(.black)
                        }
                    }
                }
                .padding()
            }
            .overlay(content: {
                if vm.isLoading { ProgressView() }
            })
            .alert("Application Error", isPresented: $vm.showAlert, actions: {
                Button("OK") {}
            }, message: {
                if let errorMessage = vm.errorMessage {
                    Text(errorMessage)
                }
            })
            .navigationTitle("Users")
            .listStyle(.plain)
            .task {
                await vm.fetchUsers()
            }
        }
    }
}

struct UserListView_Previews: PreviewProvider {
    static var previews: some View {
        UserListView()
    }
}

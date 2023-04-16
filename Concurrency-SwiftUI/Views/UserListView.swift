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
        NavigationView {
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(vm.users) { user in
                        NavigationLink {
                            PostListView(userId: user.id)
                        } label: {
                            VStack(alignment: .leading) {
                                Text(user.name ?? "")
                                    .font(.title)
                                Text(user.email ?? "")
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
            .overlay(Group {
                if vm.isLoading { ProgressView() }
            })
            .alert(isPresented: $vm.showAlert, content: {
                Alert(title: Text("Application Error"), message: Text(vm.errorMessage ?? "Something wrong"))
            })
            .navigationTitle("Users")
            .listStyle(.plain)
            .onAppear {
                vm.fetchUsers()
            }
        }
    }
}

struct UserListView_Previews: PreviewProvider {
    static var previews: some View {
        UserListView()
    }
}

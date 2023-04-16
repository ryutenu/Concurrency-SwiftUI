//
//  PostListView.swift
//  Concurrency-SwiftUI
//
//  Created by Alan Liu on 2023/04/12.
//

import SwiftUI

struct PostListView: View {
    @StateObject var vm = PostListViewModel()
    var userId: Int?
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(vm.posts) { post in
                        VStack(alignment: .leading) {
                            Text(post.title ?? "")
                                .font(.headline)
                            Text(post.body ?? "")
                                .font(.callout)
                                .foregroundColor(.secondary)
                            Rectangle()
                                .foregroundColor(.gray)
                                .frame(height: 0.5)
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
            .navigationTitle("Posts")
            .navigationBarTitleDisplayMode(.automatic)
            .listStyle(.plain)
            .onAppear {
                vm.userId = userId
                vm.fetchPosts()
            }
        }
    }
}

struct PostListView_Previews: PreviewProvider {
    static var previews: some View {
        PostListView()
    }
}


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
        NavigationStack {
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
            .navigationTitle("Posts")
            .navigationBarTitleDisplayMode(.inline)
            .listStyle(.plain)
            .task {
                vm.userId = userId
                await vm.fetchPosts()
            }
        }
    }
}

struct PostListView_Previews: PreviewProvider {
    static var previews: some View {
        PostListView()
    }
}


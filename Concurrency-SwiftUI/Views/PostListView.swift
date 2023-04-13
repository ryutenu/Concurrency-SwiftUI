//
//  PostListView.swift
//  Concurrency-SwiftUI
//
//  Created by Alan Liu on 2023/04/12.
//

import SwiftUI

struct PostListView: View {
    var posts: [Post]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(posts) { post in
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
            .navigationTitle("Posts")
            .navigationBarTitleDisplayMode(.inline)
            .listStyle(.plain)
        }
    }
}

struct PostListView_Previews: PreviewProvider {
    static var previews: some View {
        PostListView(posts: Post.mockSingleUserPosts)
    }
}


//
//  Post.swift
//  Concurrency-SwiftUI
//
//  Created by Alan Liu on 2023/04/10.
//

import Foundation

struct Post: Codable, Identifiable {
    var userId: Int?
    var id: Int?
    var title: String?
    var body: String?
}

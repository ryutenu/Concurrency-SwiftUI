//
//  User.swift
//  Concurrency-SwiftUI
//
//  Created by Alan Liu on 2023/04/10.
//

import Foundation

struct User: Codable, Identifiable {
    var id: Int?
    var name: String?
    var username: String?
    var email: String?
}

//
//  Concurrency_SwiftUIApp.swift
//  Concurrency-SwiftUI
//
//  Created by Alan Liu on 2023/04/10.
//

import SwiftUI

@main
struct Concurrency_SwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            UserListView()
                .onAppear {
                    UserDefaults.standard.setValue(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
                }
        }
    }
}

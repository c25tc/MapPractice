//
//  practiceApp.swift
//  practice
//
//  Created by Theodore Chan on 1/5/23.
//

import SwiftUI

@main
struct practiceApp: App {
    @StateObject private var vm = LocationsViewModel()

    var body: some Scene {
        WindowGroup {
            LocationsView()
                .environmentObject(vm)
        }
    }
}

//
//  WorkoutGeneratorApp.swift
//  WorkoutGenerator
//
//  Created by Sydney Allison on 9/18/23.
//

import SwiftUI

@main
@MainActor
struct WorkoutGeneratorApp: App {
    @State private var model: Model = Model()
    var body: some Scene {
        WindowGroup {
            
            HomeScreen()
                .environment(model)
        }
    }
}

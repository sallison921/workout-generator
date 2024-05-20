//
//  ContentView.swift
//  WorkoutGenerator
//
//  Created by Sydney Allison on 9/18/23.
//

import SwiftUI

struct HomeScreen: View {
    @State private var selectedTab: Int = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            GeneratePlan()
                .tabItem {
                    Label("Generate", systemImage: "paintpalette.fill")
                }
                .tag(0)
            SavedWorkouts()
                .tabItem {
                    Label("Saved", systemImage: "pencil")
                }
                .tag(1)
        }
    }
}


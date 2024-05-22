//
//  GeneratePlan.swift
//  WorkoutGenerator
//
//  Created by Sydney Allison on 9/18/23.
//

import SwiftUI
import Foundation

@MainActor
struct GeneratePlan: View {
    @Environment(Model.self) var model
    let encoder = JSONEncoder()
    let defaults = UserDefaults.standard
    
    @State var selectedType: WorkoutType = .pull
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Generate a workout")
                LazyVGrid(columns: [.init(.fixed(100)), .init(.adaptive(minimum: 100))], content: {
                    ForEach(Model.workoutTypes, id: \.self) { type in
                        generateWorkoutButtonView(for: type)
                    }
                })
            }
            .frame(width: 250)
        }
    }
    
    private func generateWorkoutButtonView(for workout: WorkoutType) -> some View {
        NavigationLink(
            destination: { PreviewWorkoutView(workoutType: workout) },
            label: {
                Text(workout.rawValue)
                    .frame(width: 100, height: 100)
                    .foregroundColor(.black)
                    .background(Color(cgColor: .init(gray: 0.8, alpha: 1)))
            })
    }
    
    func saveWorkout(workout: Workout, key: String) -> Void {
        
        if let encoded = try? encoder.encode(workout) {
            defaults.set(encoded, forKey: key)
        } else {
            print("no")
        }
    }
    
}

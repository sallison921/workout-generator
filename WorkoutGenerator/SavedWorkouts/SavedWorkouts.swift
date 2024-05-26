//
//  SavedWorkouts.swift
//  WorkoutGenerator
//
//  Created by Sydney Allison on 9/18/23.
//

import SwiftUI
import AVKit
struct SavedWorkouts: View {
    @Environment(Model.self) private var model
    @State var workouts: [WorkoutType: [Exercise]] = [:]
    let defaults = UserDefaults.standard
    let decoder = JSONDecoder()
    
    var body: some View {
 
        NavigationStack {
            List(Array(workouts.keys), id: \.self) { workoutType in
                Section("\(workoutType.rawValue) Workout"){
                    ForEach(workouts[workoutType] ?? [], id: \.self){ item in
                        NavigationLink(item.name ?? "none", value: item)
                    }
                }
            }
            .refreshable {
                Model.workoutTypes.map { findWorkout(for: $0) }
            }
            .onAppear {
                Model.workoutTypes.map { findWorkout(for: $0) }
            }
            .navigationDestination(for: Exercise.self) { exercise in
                // Shows the GIF and the name. TODO: add instructions
                GIFView(exercise: exercise)
            }
        }
    }
    
    func findWorkout(for type: WorkoutType) {
        if let savedWorkouts = defaults.object(forKey: type.rawValue) as? Data {
            if let loadedWorkout = try? decoder.decode(Workout.self, from: savedWorkouts) {
                workouts[type] = loadedWorkout.exercises
            }
        }
    }
}

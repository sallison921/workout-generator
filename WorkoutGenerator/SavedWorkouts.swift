//
//  SavedWorkouts.swift
//  WorkoutGenerator
//
//  Created by Sydney Allison on 9/18/23.
//

import SwiftUI

struct SavedWorkouts: View {
    @Environment(Model.self) private var model
    @State var workouts: [WorkoutType: [Exercise]] = [:]
    let defaults = UserDefaults.standard
    let decoder = JSONDecoder()
    
    var body: some View {
        List(Array(workouts.keys), id: \.self) { workoutType in
            Section("\(workoutType.rawValue) Workout"){
                ForEach(workouts[workoutType] ?? [], id: \.self){ item in
                    Text(item.name ?? "none")
                }
            }
        }
        .refreshable {
            Model.workoutTypes.map { findWorkout(for: $0) }
        }
        .onAppear {
            Model.workoutTypes.map { findWorkout(for: $0) }
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

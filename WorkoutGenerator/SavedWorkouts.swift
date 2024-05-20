//
//  SavedWorkouts.swift
//  WorkoutGenerator
//
//  Created by Sydney Allison on 9/18/23.
//

import SwiftUI

struct SavedWorkouts: View {
    @Environment(Model.self) private var model
    @State private var savedPullExercises: [Exercise] = []
    @State private var savedPushExercises: [Exercise] = []
    @State private var savedQuadExercises: [Exercise] = []
    @State private var savedGluteExercises: [Exercise] = []
    @State private var savedGluteHamExercises: [Exercise] = []
    let defaults = UserDefaults.standard
    let decoder = JSONDecoder()
    
    var body: some View {
//        List(model.workoutList, id: \.self) { workout in
//            //https://forums.swift.org/t/concrete-type-conformance-to-hashable-protocol/20443/5
//                //may need to use enums ugh
//        }
        List {
            Section("Quad Workout"){
                ForEach(savedQuadExercises, id: \.self){ item in
                    Text(item.name ?? "none")
                }
            }
            Section("Pull Workout") {
                ForEach(savedPullExercises, id: \.self){ item in
                    Text(item.name ?? "none")
                }
            }
            Section("Glute Workout"){
                ForEach(savedGluteExercises, id: \.self){ item in
                    Text(item.name ?? "none")
                }
            }
            Section("Push Workout") {
                ForEach(savedPushExercises, id: \.self){ item in
                    Text(item.name ?? "none")
                }
            }
            Section("Glutes and Hamstrings Workout"){
                ForEach(savedGluteHamExercises, id: \.self){ item in
                    Text(item.name ?? "none")
                }
            }
            
            
        }
        .refreshable {
            findPullWorkouts()
            findPushWorkouts()
            findGluteWorkout()
            findGluteHamWorkout()
            findQuadWorkout()
        }
        .onAppear {
            findPullWorkouts()
            findPushWorkouts()
            findGluteWorkout()
            findGluteHamWorkout()
            findQuadWorkout()
        }
    }
    
    func findPullWorkouts() -> Void {
        if let savedPullWorkouts = defaults.object(forKey: "savedPullWorkouts") as? Data {
            if let loadedWorkout = try? decoder.decode(PullWorkout.self, from: savedPullWorkouts) {
                savedPullExercises = loadedWorkout.exercises
            }
        }
    }
    func findPushWorkouts() -> Void {
        if let savedPushWorkouts = defaults.object(forKey: "savedPushWorkouts") as? Data {
            if let loadedWorkout = try? decoder.decode(PushWorkout.self, from: savedPushWorkouts) {
                savedPushExercises = loadedWorkout.exercises
            }
        }
    }
    func findQuadWorkout() -> Void {
        if let savedQuadWorkouts = defaults.object(forKey: "savedQuadWorkouts") as? Data {
            if let loadedWorkout = try? decoder.decode(QuadWorkout.self, from: savedQuadWorkouts) {
                savedQuadExercises = loadedWorkout.exercises
            }
        }
    }
    func findGluteWorkout() -> Void {
        if let savedGluteWorkouts = defaults.object(forKey: "savedGluteWorkouts") as? Data {
            if let loadedWorkout = try? decoder.decode(GluteWorkout.self, from: savedGluteWorkouts) {
                savedGluteExercises = loadedWorkout.exercises
            }
        }
    }
    func findGluteHamWorkout() -> Void {
        if let savedGluteHamWorkouts = defaults.object(forKey: "savedGluteHamWorkouts") as? Data {
            if let loadedWorkout = try? decoder.decode(GluteHamWorkout.self, from: savedGluteHamWorkouts) {
                savedGluteHamExercises = loadedWorkout.exercises
            }
        }
    }
    

}
        
        
        
        
        
        
//    @State private var chosenItem: ExerciseType?
//    @AppStorage("pull") var savedPullWorkout: PullWorkout = PullWorkout()
        //            List(model.workouts) { workout in
        //                NavigationLink(workout.title, value: workout)
        //            }
        //show custom exercise
        //            .navigationDestination(for: Workout.self){
        //                workout in
        //                VStack {
        //                    Text(workout.title)
        //                    HStack {
        //                        VStack {
        //                            Text(workout.reps?.description ?? "0")
        //                            Text("Reps")
        //                        }
        //                        VStack {
        //                            Text(workout.weight?.description ?? "0")
        //                            Text("weight")
        //                        }
        //                    }
        //                }
        //            }
        //            .toolbar { //add a new exercise
        //                ToolbarItem {
        //                    Menu {
        //                        Button("Legs") {
        //                            chosenItem = ExerciseType.legs
        //                        }
        //                        Button("Push") {
        //                            chosenItem = ExerciseType.push
        //                        }
        //                        Button("Pull") {
        //                            chosenItem = ExerciseType.pull
        //                        }
        //                    }
        //                    label: {
        //                        Image(systemName: "plus")
        //                    }
        //                    .sheet(item: $chosenItem){item in
        //                        WorkoutSheet(item: item)
        //                            .interactiveDismissDisabled()
        //                    }
        //                }
        //            }
        //        }
        //        .onAppear {
        
        // }
        
        //}

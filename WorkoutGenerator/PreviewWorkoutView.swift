//
//  PreviewWorkoutView.swift
//  WorkoutGenerator
//
//  Created by Olivia Schotz on 5/21/24.
//

import Foundation
import SwiftUI
import Lottie

/// View to show the proposed generated workout
/// Allows a user to see the workout and replace exercises and/or save the workout to their list
struct PreviewWorkoutView: View {
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    let defaults = UserDefaults.standard
    /// view model
    @Environment(Model.self) var model
    /// Indicates whether to show the loading animation overlay
    @State var showLoading: Bool = false
    
    /// the type of workout to be generated
    let workoutType: WorkoutType
    /// the generated workout
    @State var workout: Workout?
    
    /// Indicates which exercise the user is editing
    @State var selectedExerciseIndex: Int? = nil
    /// Used as a binding to show/hide the bottom sheet
    @State var showBottomSheet: Bool = false
    
    public init(workoutType: WorkoutType) {
        self.workoutType = workoutType
    }
    
    var body: some View {
        VStack {
            Text("Preview \(workoutType.rawValue) Workout")
                .font(.title)
            Spacer()
            if let workout {
                List(Array(workout.exercises.enumerated()), id: \.element.id) { index, exercise in
                    HStack {
                        Text(exercise.name ?? "exercise")
                        Spacer()
                        Image(systemName: "ellipsis")
                            .onTapGesture {
                                selectedExerciseIndex = index
                                showBottomSheet = true
                            }
                    }
                }
            }
            Spacer()
            Button("Save") {
                saveWorkout(workout: workout, key: workoutType.rawValue)
            }
        }
        .onAppear {
            generateWorkout()
        }
        .confirmationDialog("Replace exercise", isPresented: $showBottomSheet, actions: {
            Button("Choose an exercise...") { /* TODO */ }
            Button("Generate new") {
                generateNewExercise()
            }
        })
        .overlay {
            if showLoading {
                ZStack {
                    Rectangle()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .foregroundColor(Color(cgColor: .init(gray: 0.8, alpha: 0.7)))
                    LottieView(animation: LottieAnimation.named("Loading"))
                        .playing(loopMode: .loop)
                        .frame(width: 100, height: 100)
                }
            }
        }
    }
    
    private func generateWorkout() {
        showLoading = true
        // ---- NOTE: Commented out for testing
//        Task {
//            do {
//                //for each enum (one of each of the above muscles) in the pull workout structure, an exercise is added to the exercises array of the pull workout model.
//                var exercises: [Exercise] = []
//                for exercise in self.workoutType.structure {
//                    exercises.append(try await model.getExercisesFor(muscle: exercise.rawValue))
//                }
//                self.workout = Workout(type: self.workoutType, exercises: exercises)
//            }
//            catch {
//                print("failed")
//            }
//        }
        if let savedWorkouts = defaults.object(forKey: self.workoutType.rawValue) as? Data {
            if let loadedWorkout = try? decoder.decode(Workout.self, from: savedWorkouts) {
                self.workout = loadedWorkout
                showLoading = false
            }
        }
    }
    
    /// Generates a new exercise for the selected index and replaces the existing exercise
    /// Uses the index to get the muscle type from `WorkoutType.structure`
    /// Sets the state `workout` object to refresh the view after the exercise has been replaced
    private func generateNewExercise() {
        showLoading = true
        Task {
            do {
                if let selectedExerciseIndex,
                   var currentExercises = self.workout?.exercises,
                   selectedExerciseIndex < currentExercises.count {
                    let exerciseType = self.workoutType.structure[selectedExerciseIndex]
                    let newExercise = try await model.getExercisesFor(muscle: exerciseType.rawValue)
                    currentExercises[selectedExerciseIndex] = newExercise
                    let newWorkout = Workout(type: self.workoutType, exercises: currentExercises)
                    self.workout = newWorkout
                    showLoading = false
                }
            }
            catch {
                print("failed")
            }
        }
    }
    
    /// Saves the workout to the user's saved workouts in `UserDefaults`
    func saveWorkout(workout: Workout?, key: String) -> Void {
        guard let workout else { return }
        if let encoded = try? encoder.encode(workout) {
            defaults.set(encoded, forKey: key)
        } else {
            print("no")
        }
    }
}

//
//  PreviewWorkoutViewModel.swift
//  WorkoutGenerator
//
//  Created by Olivia Schotz on 5/22/24.
//

import Foundation
import Observation

@Observable
class PreviewWorkoutViewModel {
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    let defaults = UserDefaults.standard
    
    var model: Model
    /// the type of workout to be generated
    let workoutType: WorkoutType
    /// the generated workout
    var workout: Workout?
    /// Indicates which exercise the user is editing
    var selectedExerciseIndex: Int? = nil
    
    public init(model: Model, workoutType: WorkoutType) {
        self.model = model
        self.workoutType = workoutType
    }
    
    func generateWorkout(_ onSuccess: (() -> Void)? = nil) {
        // ---- NOTE: Commented out for testing
//        Task {
//            do {
//                //for each enum (one of each of the above muscles) in the pull workout structure, an exercise is added to the exercises array of the pull workout model.
//                var exercises: [Exercise] = []
//                for exercise in self.workoutType.structure {
//                    exercises.append(try await model.getExercisesFor(muscle: exercise.rawValue))
//                }
//                self.workout = Workout(type: self.workoutType, exercises: exercises)
//                onSuccess?()
//            }
//            catch {
//                print("failed")
//            }
//        }
        if let savedWorkouts = defaults.object(forKey: self.workoutType.rawValue) as? Data {
            if let loadedWorkout = try? decoder.decode(Workout.self, from: savedWorkouts) {
                self.workout = loadedWorkout
                onSuccess?()
            }
        }
    }
    
    /// Generates a new exercise for the selected index and replaces the existing exercise
    /// Uses the index to get the muscle type from `WorkoutType.structure`
    /// Sets the state `workout` object to refresh the view after the exercise has been replaced
    func generateNewExercise(_ onSuccess: (() -> Void)? = nil) {
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
                    onSuccess?()
                }
            }
            catch {
                print("failed")
            }
        }
    }
    
    /// Saves the workout to the user's saved workouts in `UserDefaults`
    func saveWorkout() -> Void {
        guard let workout else { return }
        if let encoded = try? encoder.encode(workout) {
            defaults.set(encoded, forKey: workoutType.rawValue)
        } else {
            print("no")
        }
    }
}

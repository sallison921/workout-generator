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
    
    var body: some View {
        VStack {
            Button("generate a pull workout") {
                /*
                 5 exercises
                 - 1 lat pulldown
                 - 1 bicep
                 - 1 middle back
                 - single arm back (add supserset later)
                 - 1 bicep
                 */
                Task {
                    do {
                        //for each enum (one of each of the above muscles) in the pull workout structure, an exercise is added to the exercises array of the pull workout model.
                        model.pullWorkout.exercises = []
                        for exercise in model.pullWorkout.structure {
                            model.pullWorkout.exercises.append(try await model.getExercisesFor(muscle: exercise.rawValue))
                        }
                        saveWorkout(workoutType: model.pullWorkout, key: "savedPullWorkouts")
                        
                    }
                    catch {
                        print("failed")
                    }
                }
            }
           
            Button("generate a push workout") {
                /*
                 5 exercises
                 - 2 chest
                 - 1 shoulder
                 - 2 tricep
                 */
                Task {
                    do {
                        //for each enum (one of each of the above muscles) in the pull workout structure, an exercise is added to the exercises array of the pull workout model.
                        model.pushWorkout.exercises = []
                        for exercise in model.pushWorkout.structure {
                            model.pushWorkout.exercises.append(try await model.getExercisesFor(muscle: exercise.rawValue))
                        }
                        saveWorkout(workoutType: model.pushWorkout, key: "savedPushWorkouts")
                        
                    }
                    catch {
                        print("failed")
                    }
                }
                
            }
            Button("generate a glute workout") {
              
                Task {
                    do {
                        //for each enum (one of each of the above muscles) in the pull workout structure, an exercise is added to the exercises array of the pull workout model.
                        model.gluteWorkout.exercises = []
                        for exercise in model.gluteWorkout.structure {
                            model.gluteWorkout.exercises.append(try await model.getExercisesFor(muscle: exercise.rawValue))
                        }
                        saveWorkout(workoutType: model.gluteWorkout, key: "savedGluteWorkouts")
                        
                    }
                    catch {
                        print("failed")
                    }
                }
                
            }
            Button("generate a quad workout") {
                Task {
                    do {
                        //for each enum (one of each of the above muscles) in the pull workout structure, an exercise is added to the exercises array of the pull workout model.
                        model.quadWorkout.exercises = []
                        for exercise in model.quadWorkout.structure {
                            model.quadWorkout.exercises.append(try await model.getExercisesFor(muscle: exercise.rawValue))
                        }
                        saveWorkout(workoutType: model.quadWorkout, key: "savedQuadWorkouts")
                    }
                    catch {
                        print("failed")
                    }
                }
                
            }
            Button("generate a hamstring workout") {
                Task {
                    do {
                        //for each enum (one of each of the above muscles) in the pull workout structure, an exercise is added to the exercises array of the pull workout model.
                        model.hamstringWorkout.exercises = []
                        for exercise in model.hamstringWorkout.structure {
                            model.hamstringWorkout.exercises.append(try await model.getExercisesFor(muscle: exercise.rawValue))
                        }
                        saveWorkout(workoutType: model.hamstringWorkout, key: "savedGluteHamWorkouts")
                    }
                    catch {
                        print("failed")
                    }
                }
            }
        }
    }
    
    func saveWorkout(workoutType: any Workout, key: String) -> Void {
        
        if let encoded = try? encoder.encode(workoutType) {
            defaults.set(encoded, forKey: key)
        } else {
            print("no")
        }
    }
    
}

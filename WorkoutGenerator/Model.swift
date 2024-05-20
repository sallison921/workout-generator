//
//  Model.swift
//  WorkoutGenerator
//
//  Created by Sydney Allison on 9/18/23.
//

import SwiftUI
import Observation


@Observable
actor Model {
    
     let session = URLSession.shared
    var workoutList: [any Workout] = [PullWorkout(), PushWorkout(), GluteWorkout(), GluteHamWorkout(), QuadWorkout()]
    var pullWorkout: PullWorkout = PullWorkout()
    var pushWorkout: PushWorkout = PushWorkout()
    var gluteWorkout: GluteWorkout = GluteWorkout()
    var hamstringWorkout: GluteHamWorkout = GluteHamWorkout()
    var quadWorkout: QuadWorkout = QuadWorkout()
    
        let headers = [
            "X-RapidAPI-Key": "096ae51849msh8370387b1025b38p14ecddjsn9b00b742e1b0",
            "X-RapidAPI-Host": "exercisedb.p.rapidapi.com"
        ]
    
    actor ExerciseActor {
        var exerciseList: [Exercise] = []
        func addExercise(newExercise: Exercise) {
            exerciseList.append(newExercise)
          }
    }
    
    func getExercisesFor(muscle: String) async throws -> Exercise {
        let chosenMuscle = muscle.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: "https://exercisedb.p.rapidapi.com/exercises/target/\(chosenMuscle!)?limit=10")!
        let request = NSMutableURLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        let (data, _) = try await URLSession.shared.data(for: request as URLRequest)
        
        
        
        do {
            let decodedJSON = try JSONDecoder().decode([Exercise].self, from: data)
            ///this finds one single one out of the 10.
            let randomNum = Int.random(in: 0..<decodedJSON.count)
            return decodedJSON[randomNum]
            
        }
        catch let err as DecodingError {
           print(err)
            fatalError()
        }
        
    }
}

    
enum WorkoutAPIMuscle: String, Codable {
    case abductors, abs, adductors, biceps, calves, delts, forearms, glutes, hamstrings, lats, pectorals, quads, spine, traps, triceps
    case levator_scapulae = "levator scapulae"
    case cardiovascular_system = "cardiovascular system"
    case serratus_anterior = "serratus anterior"
    case upper_back = "upper back"
}


struct Exercise: Codable, Hashable {
    var bodyPart: String?
    var equipment: String?
    var gifUrl: String?
    var id: String?
    var name: String?
    var target: String?
    var secondaryMuscles: [String]?
    var instructions: [String]?
}



/*
 6 exercises
 - 1 lat pulldown
 - 1 bicep
 - 1 middle back
 - single arm back (add supserset later)
 - 1 bicep
 */
struct PullWorkout: Workout {
    var name = "Pull Workout"
    var exercises: [Exercise] = []
    var structure: [WorkoutAPIMuscle] = [.lats, .biceps, .upper_back, .biceps]
}
/*
  6 exercises:
 - 2 bench press
 - 1 accessory fly
 - shoulder press
 - single arm shoulder
 - tricep
 - tricep
 */
//WHATTT SHOULDER DOESNT EXIST
struct PushWorkout: Workout {
    var name = "Push Workout"
    var exercises: [Exercise] = []
    var structure: [WorkoutAPIMuscle] = [.pectorals, .pectorals, .delts, .triceps, .triceps]
}
struct QuadWorkout: Workout {
    var name = "Quad Workout"
    var exercises: [Exercise] = []
    var structure: [WorkoutAPIMuscle] = [.quads, .quads, .glutes, .glutes]
}
struct GluteWorkout: Workout {
    var name = "Glute Workout"
    
    var exercises: [Exercise] = []
    var structure: [WorkoutAPIMuscle] = [.glutes, .glutes, .glutes, .glutes, .glutes]
}
struct GluteHamWorkout: Workout {
    var name: String = "Glute and Hams Workout"
    var exercises: [Exercise] = []
    var structure: [WorkoutAPIMuscle] = [.glutes, .glutes, .hamstrings, .hamstrings]
}
protocol Workout: Hashable, Codable, Encodable {
    // Define anything in common between objects
    // Example:
    var exercises: [Exercise] { get set }
    var name: String { get set }
    var structure: [WorkoutAPIMuscle] { get set }
}

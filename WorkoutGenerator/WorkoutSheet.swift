////
////  WorkoutSheet.swift
////  WorkoutGenerator
////
////  Created by Sydney Allison on 9/18/23.
////
//
//import SwiftUI
//import Observation
//
//struct WorkoutSheet: View {
//    var item: ExerciseType
//    
//    @Environment(Model.self) private var model
//    @Environment(\.dismiss) var dismiss
//    @State private var titleText: String = ""
//    @State private var typeText: String = ""
//    @State private var repsText: Int?
//    @State private var weightText: Float?
//    @State private var pushPickerSelection: PushExercises?
//    @State private var legPickerSelection: LegExercises?
//    @State private var pullPickerSelection: PullExercises?
//    
//    let formatter: NumberFormatter = {
//        let formatter = NumberFormatter()
//        formatter.numberStyle = .decimal
//        return formatter
//    }()
//    
//    var body: some View {
//        NavigationStack {
//            Form {
//                TextField("Title", text: $titleText)
//               
//              
//                
//                //put in what type: ex -> hip thrust is a thrust
//                
//                TextField("Reps", value: $repsText, formatter: formatter)
//                    .keyboardType(.decimalPad)
//                TextField("Weight", value: $weightText, formatter: formatter)
//                    .keyboardType(.decimalPad)
//            }
//            Button("Save") {
//                let newWorkout = Workout(title: titleText)
//                
//                model.save(workout: newWorkout)
//                dismiss()
//            }
//            .navigationTitle("\(item.rawValue) exercise")
//        }
//    }
//}
//
//
//
//

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
    @State private var viewModel: PreviewWorkoutViewModel
    /// Indicates whether to show the loading animation overlay
    @State var showLoading: Bool = false
    /// Used as a binding to show/hide the bottom sheet
    @State var showBottomSheet: Bool = false
    
    /// Indicates which tab is currently selected
    @Binding var selectedTab: Int
    public init(model: Model, workoutType: WorkoutType, selectedTab: Binding<Int>) {
        self.viewModel = PreviewWorkoutViewModel(model: model, workoutType: workoutType)
        self._selectedTab = selectedTab
    }
    
    var body: some View {
        VStack {
            Text("Preview \(viewModel.workoutType.rawValue) Workout")
                .font(.title)
            Spacer()
            ZStack(alignment: .bottom) {
                if let workout = viewModel.workout {
                    List(Array(workout.exercises.enumerated()), id: \.element.id) { index, exercise in
                        HStack {
                            Text(exercise.name ?? "exercise")
                            Spacer()
                            Image(systemName: "ellipsis")
                                .onTapGesture {
                                    viewModel.selectedExerciseIndex = index
                                    showBottomSheet = true
                                }
                        }
                    }
                    
                }
                Button {
                    viewModel.saveWorkout {
                        // Move to the saved workouts tab on save
                        selectedTab = 1
                    }
                } label: {
                    RoundedRectangle(cornerRadius: 20)
                        .overlay {
                            Text("Save workout")
                                .foregroundStyle(.white)
                        }
                        .frame(width: 300, height: 50)
                    
                }
                .padding()
            }
            
            Spacer()
        }
        
//        .background(.gray)
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
    
    /// Wrapper function to update the `showLoading` state
    private func generateWorkout() {
        showLoading = true
        viewModel.generateWorkout() {
            showLoading = false
            
        }
    }
    
    /// Wrapper function to update the `showLoading` state
    private func generateNewExercise() {
        showLoading = true
        viewModel.generateNewExercise() {
            showLoading = false
        }
    }
}

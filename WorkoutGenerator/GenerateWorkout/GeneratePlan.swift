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
    @State var selectedType: WorkoutType = .pull
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Generate a workout")
                    .font(.title)
                ScrollView {
                    VStack(spacing: 32) {
                        ForEach(Model.workoutTypes, id: \.self) { workoutType in
                            generateWorkoutButtonView(for: workoutType)
                        }
                    }
                }
                Spacer()
            }
        }
    }
    
    private func generateWorkoutButtonView(for workout: WorkoutType) -> some View {
        NavigationLink(
            destination: { PreviewWorkoutView(model: model, workoutType: workout) },
            label: {
                Text(workout.rawValue)
                    .font(.title3)
                    .bold()
                    .frame(width: UIScreen.main.bounds.width - 32, height: 100)
                    .foregroundColor(.white)
                    .background {
                        imageBackgroundView(workoutType: workout)
                    }
                    .cornerRadius(12)
            })
    }
    
    /// Background static image view for each workout type option
    private func imageBackgroundView(workoutType: WorkoutType) -> some View {
        Image(workoutType.imageName, bundle: Bundle.main)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .opacity(0.8)
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(.gray)
                    .opacity(0.5)
            }
    }
}

#Preview {
    GeneratePlan()
        .environment(Model())
}

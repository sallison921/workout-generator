//
//  GIFView.swift
//  WorkoutGenerator
//
//  Created by Sydney A on 5/25/24.
//

import SwiftUI

struct GIFView: View {
    let exercise: Exercise
    
    var body: some View {
        VStack {
            Text(exercise.name ?? "none")
                .font(.largeTitle)
            GIFViewRepresentable(gifName: exercise.gifUrl!)
        }
    }
}

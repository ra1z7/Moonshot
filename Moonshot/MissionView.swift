//
//  MissionView.swift
//  Moonshot
//
//  Created by Purnaman Rai (College) on 13/09/2025.
//

import SwiftUI

struct MissionView: View {
    let mission: Mission
    
    var body: some View {
        ScrollView {
            VStack {
                Image(mission.imageName)
                    .resizable()
                    .scaledToFit()
                    .containerRelativeFrame(.horizontal) { parentContainerWidth, _ in
                        parentContainerWidth * 0.5
                    }
                    .shadow(color: .white.opacity(0.3), radius: 15)
                    .padding(.vertical)
                
                VStack(alignment: .leading) {
                    Text("Mission Highlights")
                        .font(.title.bold())
                        .padding(.vertical, 5)
                    Text(mission.description)
                }
            }
            .padding()
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")

    return MissionView(mission: missions[0])
        .preferredColorScheme(.dark)
}

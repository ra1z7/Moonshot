//
//  MissionView.swift
//  Moonshot
//
//  Created by Purnaman Rai (College) on 13/09/2025.
//

import SwiftUI

struct MissionView: View {
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    
    let mission: Mission
    let astronauts: [String: Astronaut]
    let crew: [CrewMember] // these are the fully resolved, role + astronaut pairings
    
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
                
                HStack(alignment: .firstTextBaseline, spacing: 15) {
                    Image(systemName: "calendar.badge.checkmark")
                    Text(mission.formattedLaunchDate)
                }
                .font(.headline.monospaced())
                .foregroundStyle(.white.opacity(0.5))
                .padding(.top)
                
//                Divider() // not customizable, so custom divider:
                CustomDivider()
                
                VStack(alignment: .leading) {
                    Text("Mission Highlights")
                        .font(.title.bold())
                        .padding(.vertical, 5)
                    
                    Text(mission.description)
                    
                    CustomDivider()
                    
                    Text("Crew Members")
                        .font(.title.bold())
                }
            }
            .padding()
            
            CrewMembersScrollView(crew: crew)
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
    
    init(mission: Mission, astronauts: [String : Astronaut]) {
        self.mission = mission
        self.astronauts = astronauts
        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing astronaut: \(member.name)")
            }
        }
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")

    return MissionView(mission: missions[1], astronauts: astronauts)
        .preferredColorScheme(.dark)
}

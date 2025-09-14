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
                
//                Divider() // not customizable, so custom divider:
                Rectangle()
                    .frame(height: 2)
                    .foregroundStyle(.lightBackground)
                    .padding(.vertical)
                
                VStack(alignment: .leading) {
                    Text("Mission Highlights")
                        .font(.title.bold())
                        .padding(.vertical, 5)
                    
                    Text(mission.description)
                    
                    Rectangle()
                        .frame(height: 2)
                        .foregroundStyle(.lightBackground)
                        .padding(.vertical)
                    
                    Text("Crew Members")
                        .font(.title.bold())
                }
            }
            .padding()
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(crew, id: \.role) { member in
                        NavigationLink {
                            AstronautView(astronaut: member.astronaut)
                        } label: {
                            HStack {
                                Image(member.astronaut.id)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 104, height: 72)
                                    .clipShape(.capsule)
                                    .overlay {
                                        Capsule()
//                                            .strokeBorder(.white, lineWidth: 1) // draws stroke fully inside capsule's edge
                                            .stroke(.white, lineWidth: 1) // draws stroke centered on capsule's edge - half the line width is inside, half is outside the capsule’s boundary.
                                    }
                                
                                VStack(alignment: .leading) {
                                    Text(member.astronaut.name)
                                        .font(.headline)
                                        .foregroundStyle(.white)
                                    Text(member.role)
                                        .foregroundStyle(.white.opacity(0.5))
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                }
            }
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

    return MissionView(mission: missions[0], astronauts: astronauts)
        .preferredColorScheme(.dark)
}

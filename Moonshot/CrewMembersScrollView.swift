//
//  CrewMembersScrollView.swift
//  Moonshot
//
//  Created by Purnaman Rai (College) on 14/09/2025.
//

import SwiftUI

struct CrewMembersScrollView: View {
    let crew: [MissionView.CrewMember]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(crew, id: \.role) { member in
                    NavigationLink(value: member.astronaut) {
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
        .navigationDestination(for: Astronaut.self) { selectedAstronaut in
            AstronautView(astronaut: selectedAstronaut)
        }
    }
}

#Preview {
    let mission: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    var crew: [MissionView.CrewMember] {
        return mission[0].crew.map { member in
            if let astronaut = astronauts[member.name] {
                return MissionView.CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing astronaut: \(member.name)")
            }
        }
    }
    
    return CrewMembersScrollView(crew: crew)
        .preferredColorScheme(.dark)
}

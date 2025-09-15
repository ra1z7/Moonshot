//
//  ContentView.swift
//  Moonshot
//
//  Created by Purnaman Rai (College) on 07/09/2025.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    // Notice the type annotations (: [String: Astronaut], : [Mission]). That’s how Swift knows what T should be in each call.
    
    @State private var showingAsGrid = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                if showingAsGrid {
                    MissionGridView(missions: missions, astronauts: astronauts)
                        .transition(.slide)
                } else {
                    MissionListView(missions: missions, astronauts: astronauts)
                        .transition(.slide)
                }
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar {
                Button {
                    withAnimation() {
                        showingAsGrid.toggle()
                    }
                } label: {
                    if showingAsGrid {
                        Image(systemName: "list.bullet")
                            .transition(.scale)
                    } else {
                        Image(systemName: "square.grid.2x2")
                            .transition(.scale)
                    }
                }
            }
        }
    }
}

struct MissionGridView: View {
    let missions: [Mission]
    let astronauts: [String: Astronaut]
    
    let adaptiveColumnsLayout = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        LazyVGrid(columns: adaptiveColumnsLayout) {
            ForEach(missions) { mission in
                NavigationLink {
                    MissionView(mission: mission, astronauts: astronauts)
                } label: {
                    VStack {
                        Image(mission.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .padding()
                            .shadow(color: .white.opacity(0.3), radius: 15)
                        
                        VStack {
                            Text(mission.displayName)
                                .font(.headline)
                                .foregroundStyle(.white)
                            Text(mission.formattedLaunchDate)
                                .font(.caption)
                                .foregroundStyle(.white.opacity(0.5))
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.lightBackground)
                    }
                    .clipShape(.rect(cornerRadius: 15))
                    .overlay {
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(.lightBackground, lineWidth: 2)
                    }
                }
            }
        }
        .padding()
    }
}

struct MissionListView: View {
    let missions: [Mission]
    let astronauts: [String: Astronaut]
    
    var body: some View {
        VStack(spacing: 15) {
            ForEach(missions) { mission in
                NavigationLink {
                    MissionView(mission: mission, astronauts: astronauts)
                } label: {
                    HStack {
                        Image(mission.imageName)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 65, height: 65)
                            .shadow(color: .white.opacity(0.3), radius: 10)
                            .padding(.horizontal, 20)
                        
                        VStack(alignment: .leading) {
                            Text(mission.displayName)
                                .font(.headline)
                            Text(mission.formattedLaunchDate)
                            Text(mission.description)
                                .foregroundStyle(.white.opacity(0.5))
                                .multilineTextAlignment(.leading)
                                .lineLimit(3)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.lightBackground)
                        .font(.caption)
                        .foregroundStyle(.white)
                    }
                    .clipShape(.rect(cornerRadius: 15))
                    .overlay {
                        RoundedRectangle(cornerRadius: 15)
                            .strokeBorder(.lightBackground, lineWidth: 2)
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

//
//  ContentView.swift
//  Moonshot
//
//  Created by Purnaman Rai (College) on 07/09/2025.
//

import SwiftUI

struct ContentView: View {
    let astronauts = Bundle.main.decode("astronauts.json")
    
    var body: some View {
        Text(String(astronauts.count))
    }
}

#Preview {
    ContentView()
}

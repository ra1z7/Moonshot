//
//  CustomDivider.swift
//  Moonshot
//
//  Created by Purnaman Rai (College) on 14/09/2025.
//

import SwiftUI

struct CustomDivider: View {
    var body: some View {
        Rectangle()
            .frame(height: 2)
            .foregroundStyle(.lightBackground)
            .padding(.vertical)
    }
}

#Preview {
    CustomDivider()
}

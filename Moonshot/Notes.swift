//
//  Notes.swift
//  Moonshot
//
//  Created by Purnaman Rai (College) on 07/09/2025.
//

import SwiftUI

struct ImageDemo: View {
    var body: some View {
        // When we create an Image view in SwiftUI, it will automatically size itself according to the dimensions of its contents. So, if the picture is 1000x500, the Image view will also be 1000x500.
//        Image("SwiftUI")
        
        // Tip: When you're using fixed image names such as this one, Xcode generates constant names for them, that you can use in place of strings which is much safer.
//        Image(.swiftUI)
//            .frame(width: 300, height: 200)
//            .clipped()
        
        Image(.swiftUI)
            .resizable()
            .scaledToFit() // or scaledToFill()
            .frame(width: 300, height: 200)
    }
}

// All this works great if we want fixed-sized images, but when you want images that automatically scale up to fill more of the screen in one or both dimensions. That is, rather than hard-coding a width of 300, “make this image fill 80% of the width of the screen.”
struct ContainerRelativeFrameDemo: View {
    var body: some View {
        Image(.swiftUI)
            .resizable()
            .scaledToFit()
            .containerRelativeFrame(.horizontal) { size, axis in
                size * 0.8
            } // we want to give this image a frame relative to the horizontal size of its parent view
    }
}

#Preview {
    ContainerRelativeFrameDemo()
}

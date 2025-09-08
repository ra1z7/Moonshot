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




struct CustomText: View {
    let text: String
    
    var body: some View {
        Text(text)
    }
    
    init(text: String) {
        print("Creating CustomText: \(text)") // this will be printed twice per view because SwiftUI doesn't build this CustomText struct just once, but rebuild multiple times to: calculate layout, handle scrolling etc. In this case, it printed the first time when SwiftUI builds the view tree to measure/layout and second time, when SwiftUI builds again for actual rendering (Or for similar reasons).
        self.text = text
    }
}

struct ScrollViewDemo: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 10) { // When VStack is used, SwiftUI won’t wait until you scroll down to see them, it will just create all the views immediately. SOLUTION: LazyVStack and LazyHStack. These can be used in exactly the same way as regular stacks but will load their content on-demand – they won’t create views until they are actually shown, which minimizes the amount of system resources being used.
                ForEach(0 ..< 100) {
                    CustomText(text: "Item \($0)")
                }
            }
            .frame(maxWidth: .infinity) // not needed when LazyVStack is used.
        }
    }
    
    // DIFFERENCE between Regular and Lazy stacks?
    // Lazy stacks always take up as much as room as is available in our layouts, whereas Regular stacks take up only as much space as is needed. This is intentional, because it stops lazy stacks having to adjust their size if a new view is loaded that wants more space than previously loaded view.
}

#Preview {
    ScrollViewDemo()
}

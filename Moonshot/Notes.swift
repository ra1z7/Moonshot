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
            .scaledToFit()  // or scaledToFill()
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
            }  // we want to give this image a frame relative to the horizontal size of its parent view
    }
}

struct CustomText: View {
    let text: String

    var body: some View {
        Text(text)
    }

    init(text: String) {
        print("Creating CustomText: \(text)")  // this will be printed twice per view because SwiftUI doesn't build this CustomText struct just once, but rebuild multiple times to: calculate layout, handle scrolling etc. In this case, it printed the first time when SwiftUI builds the view tree to measure/layout and second time, when SwiftUI builds again for actual rendering (Or for similar reasons).
        self.text = text
    }
}

struct ScrollViewDemo: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {  // When VStack is used, SwiftUI won’t wait until you scroll down to see them, it will just create all the views immediately. SOLUTION: LazyVStack and LazyHStack. These can be used in exactly the same way as regular stacks but will load their content on-demand – they won’t create views until they are actually shown, which minimizes the amount of system resources being used.
                ForEach(0..<100) {
                    CustomText(text: "Item \($0)")
                }
            }
            .frame(maxWidth: .infinity)  // not needed when LazyVStack is used.
        }
    }

    // DIFFERENCE between Regular and Lazy stacks?
    // Lazy stacks always take up as much as room as is available in our layouts, whereas Regular stacks take up only as much space as is needed. This is intentional, because it stops lazy stacks having to adjust their size if a new view is loaded that wants more space than previously loaded view.
}

struct NavigationLinkDemo1: View {
    var body: some View {
        NavigationStack {
            NavigationLink("Show Details") {
                Text("Detail View")  // Destination View Here
            }
            .navigationTitle("Home")
        }
    }
}

struct NavigationLinkDemo2: View {
    var body: some View {
        NavigationStack {
            NavigationLink {
                Text("Detail View")
            } label: {  // Custom Label
                VStack {
                    Text("This is")
                    Text("Custom Label")
                    Image(systemName: "face.smiling")
                }
                .font(.title)

            }
            .navigationTitle("Home")
        }
    }
}

struct NavigationLinkDemo3: View {
    var body: some View {
        NavigationStack {
            // Using NavigationLink with List is most common
            List(0..<20) { rowNumber in
                NavigationLink("Row \(rowNumber)") {
                    Text("Detail View for Row \(rowNumber)")
                }
            }
            .navigationTitle("NavLink with List")
        }
    }
}




struct User: Codable { // Swift is saying “I know how to turn this 'User' type into JSON and back again.”
    let name: String
    let address: Address
}

struct Address: Codable {
    let street: String
    let city: String
}

struct HierarchicalCodableData: View {
    var body: some View {
        Button("Decode JSON") {
            let inputJSON = """
                {
                    "name": "Taylor Swift",
                    "address": {
                        "street": "555, Taylor Swift Avenue",
                        "city": "Nashville"
                    }
                }
            """
            // This JSON string matches the User type - that's why en/decoding works automatically

            let data = Data(inputJSON.utf8) // converting our inputJSON string to the 'Data' type (which is what Codable works with, Codable needs Data (raw bytes), not plain strings.)
            if let user = try? JSONDecoder().decode(User.self, from: data) { // “Take this JSON data, and try to build me a 'User' struct.”
                
                // If decoding succeeds, you get a fully initialized User object with real Swift properties.
                print(user.address.street)
            }
        }
    }
}
// Why Codable is powerful here?
//     You didn’t write any parsing code yourself.
//     You didn’t manually extract "name" or "address".
//     Codable + JSONDecoder did all the work because the struct hierarchy matched the JSON hierarchy.




// SwiftUI’s List view is a great way to show scrolling rows of data, but sometimes you also want columns of data – a grid of information, that is able to adapt to show more data on larger screens.
struct LazyGridDemo: View {
    let fixedColumnLayout = [ // we need to define the rows or columns we want – we only define one of the two, depending on which kind of grid we want, LazyHGrid for showing horizontal data, and LazyVGrid for showing vertical data.
        GridItem(.fixed(100)),
        GridItem(.fixed(100)),
        GridItem(.fixed(100))
    ] //  we want our data laid out in 3 columns, exactly 100 points wide
    
    let adaptiveColumnLayout = [
        GridItem(.adaptive(minimum: 80, maximum: 100))
    ] // tells SwiftUI we’re happy to fit in as many columns as possible, as long as they are at least 90 points and at most 100 points in width - Try in landscape mode to see
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: adaptiveColumnLayout, spacing: 20) {
                ForEach(0..<1000) {
                    Text("Item \($0)")
                }
            }
        }
    }
    // Content scrolls
    // - left to right in LazyHGrid
    // - top to bottom in LazyVGrid
    
    // GridItem defines the size/behavior of each column or row:
    //    .fixed(x) -> always x points wide/tall.
    //    .adaptive(minimum, maximum?) -> fit as many as possible.
    //    .flexible(minimum, maximum?) -> expand to fill available space.
}

#Preview {
    LazyGridDemo()
}

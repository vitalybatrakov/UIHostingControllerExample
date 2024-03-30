import SwiftUI

struct SwiftUIView: View {
    @State var flag = true
    
    var onUpdateContent: (() -> Void)?
    
    var body: some View {
        HStack {
            if flag {
                Text("Hello, World!")
                    .background(Color.purple)
            } else {
                Text(
                    "Hello, World! Hello, World! Hello, World! Hello, World! Hello, World! Hello, World! Hello, World! Hello, World! Hello, World! Hello, World!"
                )
                .background(Color.blue)
            }
            
            Button("Change size") {
                flag.toggle()
            }
            
            Spacer()
        }
        .onChange(of: flag) { _ in
            onUpdateContent?()
        }
        .onAppear {
            onUpdateContent?()
        }
    }
}

#Preview {
    SwiftUIView()
}

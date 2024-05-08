// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI

public struct PopupLoadingIndicatorView: View {
    
    @State private var isRotating = 0.0
    
    let icon: String
    let speed: TimeInterval
    
    public init(
        icon: String = "rays",
        speed: TimeInterval = 2
    ) {
        self.icon = icon
        self.speed = speed
    }
    
    public var body: some View {
        
        let animation = Animation.linear(duration: speed).repeatForever(autoreverses: false)
        
        Label {
            Text("Loading")
                .foregroundStyle(.secondary)
        } icon: {
            Image(systemName: icon)
                .foregroundStyle(.tertiary)
                .rotationEffect(.degrees(isRotating))
                .animation(animation, value: isRotating)
                .frame(width: 26)
        }
        .onAppear {
            isRotating = 360.0
        }
    }
}

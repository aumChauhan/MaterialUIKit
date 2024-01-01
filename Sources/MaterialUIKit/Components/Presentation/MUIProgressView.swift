//
// MUIProgressView.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 30/12/23
//

import SwiftUI

// MARK: - MUIOutlineCircleShape

/// A custom shape for the `MUIProgressView`.
@available(iOS 17.0, *)
private struct MUIOutlineCircleShape: Shape {
    
    func path(in rect: CGRect) -> Path {
        let radius = min(rect.width, rect.height) / 2
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let startAngle: Angle = .degrees(0)
        let endAngle: Angle = .degrees(360 * 0.8) // 80% of the circle
        
        var path = Path()
        path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        
        return path
    }
}

// MARK: - MUIProgressView

/// A SwiftUI view representing a MaterialUI style progress view.
@available(iOS 17.0, *)
public struct MUIProgressView: View {
    
    // MARK: - Properties
    
    public let lineWidth: CGFloat
    
    @State private var rotationAngle: Double = 0
    private let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    @Environment(\.colorScheme) private var colorScheme
    
    // MARK: - Initializer
    
    /// Creates a MaterialUI style progress view with default line width.
    public init() {
        lineWidth = 3
    }
    
    /// Creates a MaterialUI style progress view with a custom line width.
    ///
    /// - Parameters:
    ///    - lineWidth: Sets the stroke of progress view.
    public init(lineWidth: CGFloat) {
        self.lineWidth = lineWidth
    }
    
    // MARK: - View Body
    
    public var body: some View {
        MUIOutlineCircleShape()
            .stroke(MaterialUI.tint.accent(colorScheme), lineWidth: lineWidth)
            .frame(width: 35, height: 35)
            .rotationEffect(Angle(degrees: rotationAngle))
            .onReceive(timer) { _ in
                withAnimation {
                    rotationAngle += 40
                }
            }
    }
}

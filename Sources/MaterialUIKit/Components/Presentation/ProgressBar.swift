//
// ProgressBar.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 30/12/23
//

import SwiftUI

// MARK: - PUBLIC

/// Represents a Material UI styled progress indicator for showing ongoing processes or loading states.
@available(iOS 15.0, *)
public struct ProgressBar: View {
    
    // MARK: - PROPERTIES
    
    private let lineWidth: CGFloat
    
    @State private var rotationAngle: Double = 0
    private let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    // MARK: - INITIALIZER
    
    /// Creates a progress view with default line width of 2 points.
    public init() {
        lineWidth = 2
    }
    
    /// Creates a progress view with a custom line width.
    ///
    /// - Parameters:
    ///    - lineWidth: Sets the stroke of progress view.
    public init(lineWidth: CGFloat) {
        self.lineWidth = lineWidth
    }
    
    // MARK: - VIEW BODY

    public var body: some View {
        MaterialProgressArc()
            .stroke(.materialUIAccent, lineWidth: lineWidth)
            .frame(width: 35, height: 35)
            .rotationEffect(Angle(degrees: rotationAngle))
            .onReceive(timer) { _ in
                withMaterialAnimation {
                    rotationAngle += 40
                }
            }
    }
}

// MARK: - FILE PRIVATE

/// A custom shape for the `ProgressBar`.
fileprivate struct MaterialProgressArc: Shape {
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

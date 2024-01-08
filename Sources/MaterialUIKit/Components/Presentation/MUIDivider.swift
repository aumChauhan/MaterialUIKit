//
// MUIDivider.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 30/12/23
//

import SwiftUI

/// Enum to specify the orientation of the divider.
@available(iOS 17.0, *)
public enum MUIDividerOrientation {
    /// A horizontal divider.
    case horizontal
    
    /// A vertical divider.
    case vertical
}

/// A SwiftUI view representing a MaterialUI style divider.
@available(iOS 17.0, *)
public struct MUIDivider: View {
    
    // MARK: - Properties
    
    public let orientation: MUIDividerOrientation
    
    // MARK: - Initializer
    
    /// Creates a MaterialUI style divider with the horizontal orientation.
    public init() {
        self.orientation = .horizontal
    }
    
    /// Creates a MaterialUI style divider with the specified orientation.
    /// - Parameter orientation: The orientation of the divider.
    public init(orientation: MUIDividerOrientation) {
        self.orientation = orientation
    }
    
    // MARK: - View Body
    
    public var body: some View {
        switch orientation {
        case .horizontal:
            horizontalDivider()
            
        case .vertical:
            verticalDivider()
        }
    }
}

// MARK: - Extension MUIDivider

@available(iOS 17.0, *)
extension MUIDivider {
    
    /// Creates a MaterialUI style divider with the horizontal orientation.
    private func horizontalDivider() -> some View {
        HStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(height: 1)
                .frame(maxWidth: .infinity)
                .padding(5)
                .foregroundColor(MaterialUI.tint.secondaryTitle().opacity(0.5))
        }
    }
    
    /// Creates a MaterialUI style divider with the vertical orientation.
    private func verticalDivider() -> some View {
        HStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 1)
                .frame(maxHeight: .infinity)
                .padding(5)
                .foregroundColor(MaterialUI.tint.secondaryTitle().opacity(0.5))
        }
    }
}

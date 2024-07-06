//
// MaterialDivider.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 30/12/23
//

import SwiftUI

/// A Material UI style divider.
@available(iOS 15.0, *)
public struct MaterialDivider: View {
    
    // MARK: - Properties
    
    private let orientation: MaterialDividerOrientation
    
    // MARK: - Initializer
    
    /// Creates a divider with default horizontal orientation.
    public init() {
        self.orientation = .horizontal
    }
    
    /// Creates a divider with the specified orientation.
    ///
    /// - Parameter orientation: The orientation of the divider.
    public init(orientation: MaterialDividerOrientation) {
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
    
    // MARK: - Helpers
    
    /// Returns horizontal oriented divider.
    private func horizontalDivider() -> some View {
        HStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(height: 1)
                .frame(maxWidth: .infinity)
                .padding(5)
                .foregroundStyle(.muiSecondaryTitle.opacity(0.5))
        }
    }
    
    /// Returns vertical oriented divider.
    private func verticalDivider() -> some View {
        HStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 1)
                .frame(maxHeight: .infinity)
                .padding(5)
                .foregroundStyle(.muiSecondaryTitle.opacity(0.5))
        }
    }
}
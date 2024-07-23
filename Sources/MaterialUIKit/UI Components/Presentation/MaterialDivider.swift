//
// MaterialDivider.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 30/12/23
//

import SwiftUI

/// A Material UI style divider.
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
        RoundedRectangle(cornerRadius: MaterialUIKit.configuration.cornerRadius)
            .frame(
                width: orientation == .vertical ? MaterialUIKit.configuration.borderWidth : nil,
                height: orientation == .horizontal ? MaterialUIKit.configuration.borderWidth : nil
            )
            .frame(maxWidth: orientation == .horizontal ? .infinity : nil, maxHeight: orientation == .vertical ? .infinity : nil)
            .padding(2)
            .foregroundStyle(.materialSeparator)
    }
}

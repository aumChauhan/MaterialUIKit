//
// Separator.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 30/12/23
//

import SwiftUI

/// A Material UI style section-separator.
public struct Separator: View {
    
    // MARK: - Properties
    
    private let orientation: MUISeparatorOrientation
    
    // MARK: - Initializer
    
    /// Creates a separator with default horizontal orientation.
    public init() {
        self.orientation = .horizontal
    }
    
    /// Creates a separator with the specified orientation.
    ///
    /// - Parameter orientation: The orientation of the divider.
    public init(orientation: MUISeparatorOrientation) {
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
            .foregroundStyle(.materialUISeparator)
    }
}

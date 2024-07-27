//
// Separator.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 30/12/23
//

import SwiftUI

/// Represents a Material UI styled separator for dividing content or sections within a view.
@available(iOS 15.0, *)
public struct Separator: View {
    
    // MARK: - PROPERTIES
    
    private let orientation: SeparatorOrientationStyle
    
    // MARK: - INITIALIZER
    
    /// Creates a separator with default horizontal orientation.
    public init() {
        self.orientation = .horizontal
    }
    
    /// Creates a separator with the specified orientation.
    ///
    /// - Parameter orientation: The orientation of the separator.
    public init(orientation: SeparatorOrientationStyle) {
        self.orientation = orientation
    }
    
    // MARK: - VIEW BODY
    
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

//
// NavigationRoute.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 24/07/24
//

import SwiftUI

/// Represents a Material UI-styled navigation route for transitioning between views.
@available(iOS 15.0, *)
public struct NavigationRoute<Label, Destination>: View where Label: View, Destination: View {
    
    // MARK: - PROPERTIES
    
    private let destination: Destination
    private let label: Label
    
    // MARK: - INITIALIZER
    
    /// Creates a `NavigationRoute` with the specified destination and label.
    ///
    /// - Parameters:
    ///   - destination: A closure that returns the view to navigate to.
    ///   - label: A closure that returns the view used as the navigation trigger.
    public init(@ViewBuilder destination: () -> Destination, @ViewBuilder label: () -> Label) {
        self.destination = destination()
        self.label = label()
    }
    
    // MARK: - VIEW BODY
    
    public var body: some View {
        NavigationLink {
            destination
                .navigationBarHidden(true)
        } label: {
            label
        }
    }
}

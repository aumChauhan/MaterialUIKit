//
// NavigationRoute.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 24/07/24
//

import SwiftUI

/// A navigation route that wraps the destination in a MaterialUI-styled navigation container.
public struct NavigationRoute<Label, Destination>: View where Label: View, Destination: View {
    
    // MARK: - PROPERTIES
    
    private let destination: Destination
    private let label: Label
    
    // MARK: - INITIALIZER
    
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

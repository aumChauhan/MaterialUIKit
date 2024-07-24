//
// Container.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 16/04/24
//

import SwiftUI

/// A empty view container with default MaterialUI styling.
public struct Container<Content>: View where Content: View {
    
    // MARK: - PROPERTIES
    
    private let content: Content
    
    // MARK: - INITIALIZER
    
    /// Creates a empty container view.
    ///
    /// - Parameter content: The content to be wrapped in the container view.
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    // MARK: - VIEW BODY
    
    public var body: some View {
        ZStack {
            Color.materialUIPrimaryBackground.ignoresSafeArea(.all)
            
            VStack(spacing: MaterialUIKit.configuration.verticalStackSpacing) {
                content
            }
            .padding(MaterialUIKit.configuration.contentPadding)
        }
    }
}

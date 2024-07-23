//
// MaterialContainer.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 16/04/24
//

import SwiftUI

/// A view container with default MaterialUI styling.
public struct MaterialContainer<Content>: View where Content: View {
    
    // MARK: - Properties
    
    private let content: Content
    
    // MARK: - Initializer
    
    /// Creates a empty container view.
    ///
    /// - Parameter content: The content to be wrapped in the container view.
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    // MARK: - View Body
    
    public var body: some View {
        ZStack {
            Color.materialPrimaryBackground.ignoresSafeArea(.all)
            
            VStack(spacing: MaterialUIKit.configuration.verticalStackSpacing) {
                content
            }
            .padding(MaterialUIKit.configuration.contentPadding)
        }
    }
}

//
// Container.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 16/04/24
//

import SwiftUI

/// Represents a Material UI styled container that wraps and aligns its child elements.
@available(iOS 15.0, *)
public struct Container<Content>: View where Content: View {
    
    // MARK: - PROPERTIES
    
    private let content: Content
    
    // MARK: - INITIALIZER
    
    /// Creates an empty container view.
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

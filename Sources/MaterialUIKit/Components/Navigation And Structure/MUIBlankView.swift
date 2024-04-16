//
// MUIView.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 16/04/24
//

import SwiftUI

/// A blank-view with default MaterialUIKit styling including background and padding.
@available(iOS 15.0, *)
public struct MUIBlankView<Content>: View where Content: View {
    
    // MARK: - Properties
    
    private let content: Content
    
    // MARK: - Initializer
    
    /// Creates a empty view with default MaterialUIKit styling including background and padding.
    /// - Parameter content: The content to be wrapped in the blank view.
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    // MARK: - View Body
    
    public var body: some View {
        ZStack {
            // Background
            MaterialUIKit.tint.primaryBackground().ignoresSafeArea(.all)
            
            // Content
            VStack {
                content
            }
                .padding(MUIConstants.insideMargin)
        }
    }
}

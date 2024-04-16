//
// MUIFloatingButton.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 30/12/23
//

import SwiftUI

// MARK: - MUIFloatingButton

/// A SwiftUI button designed for floating action button (FAB) functionality with various initialization options.
@available(iOS 15.0, *)
public struct MUIFloatingButton: View {
    
    // MARK: - Properties
    
    public let systemSymbol: String?
    public let image: String?
    public let title: String
    public let action: () -> Void
    
    // MARK: - Initializers
    
    /// Creates a floating button with a system symbol, title, and an action.
    ///
    /// - Parameters:
    /// - `systemSymbol`:  SF Symbol string for system-provided icons.
    /// - `title`:  Optional title for a textual label beside the button.
    /// - `action`: The closure to execute when the button is pressed.
    public init(systemSymbol: String, title: String, _ action: @escaping () -> Void) {
        self.systemSymbol = systemSymbol
        self.title = title
        self.action = action
        self.image = nil
    }
    
    /// Creates a floating button with a custom image, title, and an action.
    ///
    /// - Parameters:
    /// - `image`:  Custom SwiftUI `Image` for a personalized button icon.
    /// - `title`:  Optional title for a textual label beside the button.
    /// - `action`: The closure to execute when the button is pressed.
    public init(image: String, title: String, _ action: @escaping () -> Void) {
        self.image = image
        self.title = title
        self.action = action
        self.systemSymbol = nil
    }
    
    // MARK: - View Body
    
    public var body: some View {
        Button(action: action) {
            HStack {
                // Button Symbol
                if let systemSymbol = systemSymbol {
                    Image(systemName: systemSymbol)
                } else if let image = image {
                    Image(image)
                        .resizable()
                        .renderingMode(.template)
                } else {
                    EmptyView()
                }
                
                // Button title
                Text(title)
            }
            .foregroundColor(.muiAccent)
            .frame(minWidth: 30)
            .frame(height: 35)
            .elevatedButtonStyle()
            .shadow(color: .black.opacity(0.1), radius: 1, x: 0, y: 1)
            .shadow(color: .black.opacity(0.1), radius: 3, x: 0, y: 3)
        }
        .buttonStyle(MUIButtonTapStyle())
    }
}

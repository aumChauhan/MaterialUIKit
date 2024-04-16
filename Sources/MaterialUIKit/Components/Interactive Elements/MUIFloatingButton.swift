//
// MUIFloatingButton.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 30/12/23
//

import SwiftUI

// MARK: - Extension View

@available(iOS 15.0, *)
extension View {
    
    ///  Presents a Material-UI style floating button to the view with a `bottomTrailing` alignment.
    ///
    /// - Parameters
    ///   - systemSymbol: The system symbol name for the button icon.
    ///   - title: The title text displayed on the button.
    ///   - action: A closure to be executed when the button is tapped.
    public func muiFloatingButton(
        systemSymbol: String,
        title: String,
        action: @escaping () -> Void) -> some View {
            self.modifier(
                MUIFloatingButtonModifier(systemSymbol: systemSymbol, title: title, action: action)
            )
        }
}

// MARK: - MUIFloatingButtonModifier

/// A view modifier that adds a floating button with specified system symbol and title aligned at the bottom of the screen.
@available(iOS 15.0, *)
private struct MUIFloatingButtonModifier: ViewModifier {
    
    // MARK: - Properties
    
    public let systemSymbol: String
    public let title: String
    public let action: () -> Void
    
    // MARK: - Body
    
    func body(content: Content) -> some View {
        content.overlay(
            MUIFloatingButton(systemSymbol: systemSymbol, title: title, action)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                .padding(20)
        )
    }
}

// MARK: - MUIFloatingButton

/// A SwiftUI button designed for floating action button (FAB) functionality with various initialization options.
@available(iOS 15.0, *)
private struct MUIFloatingButton: View {
    
    // MARK: - Properties
    
    private let systemSymbol: String?
    private let image: String?
    private let title: String
    private let action: () -> Void
    
    // MARK: - Initializers
    
    /// Creates a floating button with a system symbol, title, and an action.
    ///
    /// - Parameters:
    /// - `systemSymbol`:  SF Symbol string for system-provided icons.
    /// - `title`:  Optional title for a textual label beside the button.
    /// - `action`: The closure to execute when the button is pressed.
    init(systemSymbol: String, title: String, _ action: @escaping () -> Void) {
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
    init(image: String, title: String, _ action: @escaping () -> Void) {
        self.image = image
        self.title = title
        self.action = action
        self.systemSymbol = nil
    }
    
    // MARK: - View Body
    
    var body: some View {
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
            .foregroundStyle(.muiAccent)
            .frame(minWidth: 30)
            .frame(height: 35)
            .elevatedButtonStyle()
            .shadow(color: .black.opacity(0.1), radius: 1, x: 0, y: 1)
            .shadow(color: .black.opacity(0.1), radius: 3, x: 0, y: 3)
        }
        .buttonStyle(MUIButtonTapStyle())
    }
}

//
// MaterialFloatingButton.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 30/12/23
//

import SwiftUI

extension View {
    
    /// Presents a Material designed styled FAB to the view with a bottom trailing alignment.
    ///
    /// - Parameters:
    ///   - systemSymbol: The system symbol name for the button icon.
    ///   - title: The title text displayed on the button.
    ///   - action: A closure to be executed when the button is tapped.
    public func materialFAB(
        systemName: String,
        title: String,
        action: @escaping () -> Void
    ) -> some View {
        self.modifier(
            MaterialFABModifier(systemName: systemName, title: title, action: action)
        )
    }
}

// MARK: - MaterialFABModifier

/// A view modifier that adds a floating button with specified system symbol and title aligned at the bottom of the screen.
fileprivate struct MaterialFABModifier: ViewModifier {
    
    // MARK: - Properties
    
    let systemName: String
    let title: String
    let action: () -> Void
    
    // MARK: - Body
    
    func body(content: Content) -> some View {
        content.overlay(
            MaterialFAB(systemName: systemName, title: title, action)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                .padding(20)
        )
    }
}

// MARK: - MaterialFAB

/// A Material design styled FAB.
@available(iOS 15.0, *)
fileprivate struct MaterialFAB: View {
    
    // MARK: - Properties
    
    let systemName: String
    let image: String?
    let title: String
    let action: () -> Void
    
    // MARK: - Initializers
    
    /// Creates a FAB with a system symbol, title, and an action.
    init(systemName: String, title: String, _ action: @escaping () -> Void) {
        self.systemName = systemName
        self.title = title
        self.action = action
        self.image = nil
    }
    
    // MARK: - View Body
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: systemName)
                Text(title)
            }
            .foregroundStyle(.muiAccent)
            .frame(minWidth: 30)
            .frame(height: 35)
            .elevatedStyledBackground()
            .shadow(color: .black.opacity(0.1), radius: 1, x: 0, y: 1)
            .shadow(color: .black.opacity(0.1), radius: 3, x: 0, y: 3)
        }
        .buttonStyle(ShrinkFadeButtonStyle())
    }
}

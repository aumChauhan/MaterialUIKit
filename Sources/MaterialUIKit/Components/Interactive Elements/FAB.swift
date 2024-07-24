//
// FAB.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 30/12/23
//

import SwiftUI

// MARK: - PUBLIC

extension View {
    
    /// Presents a Material UI style FAB to the view with a bottom trailing alignment.
    ///
    /// - Parameters:
    ///   - systemImage: The system symbol name for the button icon.
    ///   - titleKey: The title key displayed on the button.
    ///   - action: A closure to be executed when the button is tapped.
    public func floatingActionButton(
        systemImage: String,
        titleKey: String,
        action: @escaping () -> Void
    ) -> some View {
        self.modifier(
            FABViewModifier(systemImage: systemImage, titleKey: titleKey, cornerRadius: nil, action: action)
        )
    }
    /// Presents a Material UI style FAB to the view with a bottom trailing alignment and a customizable corner radius.
    ///
    /// - Parameters:
    ///   - systemImage: The system symbol name for the button icon.
    ///   - titleKey: The title key displayed on the button.
    ///   - cornerRadius: The corner radius to apply to the button.
    ///   - action: A closure to be executed when the button is tapped.
    public func floatingActionButton(
        systemImage: String,
        titleKey: String,
        cornerRadius: CGFloat,
        action: @escaping () -> Void
    ) -> some View {
        self.modifier(
            FABViewModifier(systemImage: systemImage, titleKey: titleKey, cornerRadius: cornerRadius, action: action)
        )
    }
}

// MARK: - FILE PRIVATE

/// A view modifier that adds a floating action button with specified system symbol and title aligned at the bottom of the screen.
fileprivate struct FABViewModifier: ViewModifier {
    let systemImage: String
    let titleKey: String
    let cornerRadius: CGFloat?
    let action: () -> Void
        
    func body(content: Content) -> some View {
        content.overlay(
            FAB(systemImage: systemImage, titleKey: titleKey, action, cornerRadius: cornerRadius)
                .align(.bottomTrailing)
                .padding(MaterialUIKit.configuration.contentPadding)
        )
    }
}

/// A Material UI style FAB.
fileprivate struct FAB: View {
    
    // MARK: - PROPERTIES
    
    let systemImage: String
    let image: String?
    let titleKey: String
    let cornerRadius: CGFloat?
    let action: () -> Void
    
    // MARK: - INITIALIZERS
    
    /// Creates a FAB with a system symbol, title, and an action.
    init(systemImage: String, titleKey: String, _ action: @escaping () -> Void, cornerRadius: CGFloat?) {
        self.systemImage = systemImage
        self.titleKey = titleKey
        self.action = action
        self.cornerRadius = cornerRadius
        self.image = nil
    }
    
    // MARK: - VIEW BODY
    
    var body: some View {
        Button {
            action()
            hapticFeedback()
        }label: {
            HStack {
                Image(systemName: systemImage)
                Text(titleKey)
                    .font(MaterialUIKit.configuration.h4)
            }
            .fontWeightWithFallback(.medium)
            .filledStyledBackground()
            .cornerRadius(cornerRadius ?? MaterialUIKit.configuration.cornerRadius)
        }
        .buttonStyle(MUIActionButtonAnimationStyle())
    }
}

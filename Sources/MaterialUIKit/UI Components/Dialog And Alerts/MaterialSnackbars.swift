//
// MaterialSnackbars.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 30/12/23
//

import SwiftUI

extension View {
    
    /// Presents a Material UI style snackbar with a description message with a default time of 5s.
    ///
    /// - Parameters:
    ///   - isPresented: A binding to control the presentation state of the snackbar.
    ///   - message: The message displayed in the snackbar.
    ///
    /// - Returns: A view presenting a Material Design styled snackbar.
    public func materialSnackbar(
        isPresented: Binding<Bool>,
        message: String
    ) -> some View {
        self.modifier(
            MaterialSnackbarModifier(
                isPresented: isPresented,
                message: message,
                duration: nil,
                primaryButtonTitle: nil,
                primaryAction: nil
            )
        )
    }
    
    /// Presents a Material UI style snackbar with a message, duration, and optional button.
    ///
    /// - Parameters:
    ///   - isPresented: A binding to control the presentation state of the snackbar.
    ///   - message: The message displayed in the snackbar.
    ///   - duration: The duration (in seconds) for which the snackbar is visible before automatically hiding. Defaults to `nil`.
    ///   - buttonTitleKey: The title of the primary button. If `nil`, no button is displayed. Defaults to `nil`.
    ///   - action: The action to perform when the primary button is tapped. Defaults to `nil`.
    ///
    /// - Returns: A view presenting a Material Design styled snackbar.
    public func materialSnackbar(
        isPresented: Binding<Bool>,
        message: String,
        duration: Double,
        buttonTitleKey: String,
        action: (() -> Void)?
    ) -> some View {
        self.modifier(
            MaterialSnackbarModifier(
                isPresented: isPresented,
                message: message,
                duration: duration,
                primaryButtonTitle: buttonTitleKey,
                primaryAction: action
            )
        )
    }
}

// MARK: - MaterialSnackbarModifier

/// A view modifier that adds snackbar presentation behavior to any view.
fileprivate struct MaterialSnackbarModifier: ViewModifier {
    
    @Binding var isPresented: Bool
    let message: String
    let duration: Double?
    let primaryButtonTitle: String?
    let primaryAction: (() -> Void)?
    
    func body(content: Content) -> some View {
        content.overlay(
            MaterialSnackbarView(
                isPresented: $isPresented,
                message: message,
                duration: duration,
                primaryButtonTitle: primaryButtonTitle,
                primaryAction: primaryAction
            )
        )
    }
}

// MARK: - MaterialSnackbarView

/// Represents Material Design styled snackbar.
fileprivate struct MaterialSnackbarView: View {
    
    // MARK: Properties
    
    @Binding var isPresented: Bool
    @State private var animationFlag: Bool = false
    
    let message: String
    let duration: Double?
    let defaultDuration = 5.0
    let primaryButtonTitle: String?
    let primaryAction: (() -> Void)?
    
    // MARK: - View Body
    
    var body: some View {
        HStack(spacing: MaterialUIKit.configuration.horizontalStackSpacing) {
            Text(message)
                .font(MaterialUIKit.configuration.h4)
                .fontWeightWithFallback(.medium)
                .foregroundStyle(.materialSecondaryTitle)
                .align(.leading)
            
            if let primaryButtonTitle = primaryButtonTitle {
                Button {
                    primaryAction?()
                    
                    withMaterialAnimation {
                        isPresented = false
                    }
                } label: {
                    Text(primaryButtonTitle)
                        .font(MaterialUIKit.configuration.h4)
                        .fontWeightWithFallback(.semibold)
                }
                .tint(.materialAccent)
                .align(.trailing)
            }
        }
        .lineLimit(1)
        .secondaryBackground()
        .align(.bottom)
        .frame(width: UIScreen.main.bounds.width/1.1)
        .offset(y: animationFlag ? 0 : UIScreen.main.bounds.height)
        .onChangeWithFallback(of: isPresented) { _ , _ in
            withMaterialAnimation {
                animationFlag = isPresented
                toggleOffSnackbar(isPresented: $isPresented, duration: duration)
            }
        }
    }
    
    /// Toggles off the snackbar after a specified duration.
    private func toggleOffSnackbar(isPresented: Binding<Bool>, duration: Double?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + (duration ?? defaultDuration)) {
            withMaterialAnimation {
                isPresented.wrappedValue = false
            }
        }
    }
}

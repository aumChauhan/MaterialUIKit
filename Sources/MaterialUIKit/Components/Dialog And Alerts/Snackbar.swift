//
// Snackbar.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 30/12/23
//

import SwiftUI

// MARK: - PUBLIC

extension View {
    
    /// Presents a snackbar with a description message with a default time of 5s.
    ///
    /// - Parameters:
    ///   - isPresented: A binding to control the presentation state of the snackbar.
    ///   - message: The message displayed in the snackbar.
    @available(iOS 15.0, *)
    public func snackbar(
        isPresented: Binding<Bool>,
        message: String
    ) -> some View {
        self.modifier(
            SnackbarViewModifier(
                isPresented: isPresented,
                message: message,
                duration: nil,
                actionButtonKey: nil,
                action: nil
            )
        )
    }
    
    /// Presents a snackbar with a message, duration, and optional button.
    ///
    /// - Parameters:
    ///   - isPresented: A binding to control the presentation state of the snackbar.
    ///   - message: The message displayed in the snackbar.
    ///   - duration: The duration (in seconds) for which the snackbar is visible before automatically hiding. Defaults to `nil`.
    ///   - actionButtonKey: The title key of the action button. If `nil`, no button is displayed. Defaults to `nil`.
    ///   - action: The action to perform when the primary button is tapped. Defaults to `nil`.
    @available(iOS 15.0, *)
    public func snackbar(
        isPresented: Binding<Bool>,
        message: String,
        duration: Double,
        actionButtonKey: String,
        action: (() -> Void)?
    ) -> some View {
        self.modifier(
            SnackbarViewModifier(
                isPresented: isPresented,
                message: message,
                duration: duration,
                actionButtonKey: actionButtonKey,
                action: action
            )
        )
    }
}

// MARK: - FILE PRIVATE

/// Adds snackbar presentation over the current view.
fileprivate struct SnackbarViewModifier: ViewModifier {
    
    @Binding var isPresented: Bool
    let message: String
    let duration: Double?
    let actionButtonKey: String?
    let action: (() -> Void)?
    
    func body(content: Content) -> some View {
        content.overlay(
            Snackbar(
                isPresented: $isPresented,
                message: message,
                duration: duration,
                actionButtonKey: actionButtonKey,
                action: action
            )
        )
    }
}

/// Represents Material Design styled snackbar.
fileprivate struct Snackbar: View {
    
    // MARK: PROPERTIES
    
    @Binding var isPresented: Bool
    @State private var animationFlag: Bool = false
    
    let message: String
    let duration: Double?
    let defaultDuration = 5.0
    let actionButtonKey: String?
    let action: (() -> Void)?
    
    // MARK: - VIEW_BODY
    
    var body: some View {
        HStack(spacing: MaterialUIKit.configuration.horizontalStackSpacing) {
            Text(message)
                .font(MaterialUIKit.configuration.h4)
                .fontWeightWithFallback(.medium)
                .foregroundStyle(.materialUISecondaryTitle)
                .align(.leading)
            
            if let actionButtonKey = actionButtonKey {
                Button {
                    action?()
                    
                    withMaterialAnimation {
                        isPresented = false
                    }
                    
                    hapticFeedback()
                } label: {
                    Text(actionButtonKey)
                        .font(MaterialUIKit.configuration.h4)
                        .fontWeightWithFallback(.semibold)
                }
                .tint(.materialUIAccent)
                .align(.trailing)
            }
        }
        .lineLimit(1)
        .tertiaryBackground()
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

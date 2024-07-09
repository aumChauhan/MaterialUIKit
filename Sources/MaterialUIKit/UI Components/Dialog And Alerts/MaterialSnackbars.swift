//
// MaterialSnackbars.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 30/12/23
//

import SwiftUI

extension View {
    
    /// Presents a Material UI style snackbar with a description message.
    ///
    /// - Parameters:
    ///   - isPresented: A binding to control the presentation state of the snackbar.
    ///   - message: The message displayed in the snackbar.
    ///
    /// - Returns: A view presenting a Material Design styled snackbar.
    public func materialDesignSnackbar(
        isPresented: Binding<Bool>,
        message: String
    ) -> some View {
        self.modifier(
            MaterialDesignSnackbarModifier(
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
    public func materialDesignSnackbar(
        isPresented: Binding<Bool>,
        message: String,
        duration: Double? = nil,
        buttonTitleKey: String? = nil,
        action: (() -> Void)? = nil
    ) -> some View {
        self.modifier(
            MaterialDesignSnackbarModifier(
                isPresented: isPresented,
                message: message,
                duration: duration,
                primaryButtonTitle: buttonTitleKey,
                primaryAction: action
            )
        )
    }
}

// MARK: - MaterialDesignSnackbarModifier

/// A view modifier that adds snackbar presentation behavior to any view.
fileprivate struct MaterialDesignSnackbarModifier: ViewModifier {
    
    @Binding var isPresented: Bool
    let message: String
    let duration: Double?
    let primaryButtonTitle: String?
    let primaryAction: (() -> Void)?
    
    func body(content: Content) -> some View {
        content.overlay(
            MaterialDesignSnackbarView(
                isPresented: $isPresented,
                message: message,
                duration: duration,
                primaryButtonTitle: primaryButtonTitle,
                primaryAction: primaryAction
            )
        )
    }
}

// MARK: - MaterialDesignSnackbarView

/// Represents Material Design styled snackbar.
fileprivate struct MaterialDesignSnackbarView: View {
    
    // MARK: Properties
    
    @Binding var isPresented: Bool
    @State private var animationFlag: Bool = false
    let message: String
    let duration: Double?
    let primaryButtonTitle: String?
    let primaryAction: (() -> Void)?
    
    // MARK: - View Body
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            
            HStack {
                Text(message)
                    .font(.headline)
                    .foregroundStyle(.materialPrimaryTitle)
                    .fontWeightWithFallback(.medium)
                
                Spacer()
                
                if let primaryButtonTitle = primaryButtonTitle {
                    Button {
                        primaryAction?()
                        withAnimation {
                            isPresented = false
                        }
                    } label: {
                        Text(primaryButtonTitle)
                            .buttonStyle(.borderedProminent)
                            .font(.headline)
                            .fontWeightWithFallback(.semibold)
                    }
                }
            }
            .lineLimit(1)
            .padding(20)
            .background(.materialTertiaryBackground)
            .cornerRadius(20)
            .shadow(color: .black.opacity(0.15), radius: 3, x: 0, y: 2)
        }
        .frame(width: UIScreen.main.bounds.width / 1.1)
        .offset(y: animationFlag ? 0 : UIScreen.main.bounds.height)
        .onChangeWithFallback(of: isPresented) { oldValue, newValue in
            withAnimation(.bouncy) {
                animationFlag = isPresented
                toggleOffSnackbar()
            }
        }
    }
    
    // MARK: - Helpers
    
    /// Toggles off the snackbar after a specified duration.
    private func toggleOffSnackbar() {
        guard let duration = duration else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            withAnimation {
                isPresented = false
            }
        }
    }
}

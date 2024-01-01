//
// MUISnackbars.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 30/12/23
//

import SwiftUI

// MARK: - Extension View

@available(iOS 17.0, *)
extension View {
    
    /// A custom MaterialUI style snackbar that can be displayed at the bottom of the screen.
    ///
    /// - Parameters:
    ///   - isPresented: Binding to control the presentation state of the alert.
    ///   - message: The message displayed in the alert.
    ///   - duration: The duration(in seconds) for which the snackbar is visible before automatically toggling off.
    ///   - primaryButtonTitle: The title of the primary (main) button.
    ///   - primaryAction: The action to be executed when the primary button is tapped.
    public func mUISnackbar(
        isPresented: Binding<Bool>,
        message: String,
        duration: Double? = nil,
        primaryButtonTitle: String? = nil,
        primaryAction: (() -> Void)? = nil) -> some View {
            self.modifier(
                MUISnackbarModifier(
                    isPresented: isPresented,
                    message: message,
                    duration: duration,
                    primaryButtonTitle: primaryButtonTitle ?? nil,
                    primaryAction: primaryAction ?? nil
                )
            )
        }
}

// MARK: - MUISnackbarModifier

/// A view modifier that adds the MaterialUI style snackbar presentation behavior to any view.
@available(iOS 17.0, *)
private struct MUISnackbarModifier: ViewModifier {
    
    // MARK: - Properties
    
    @Binding public var isPresented: Bool
    public let message: String
    public let duration: Double?
    public let primaryButtonTitle: String?
    public let primaryAction: (() -> Void)?
    
    // MARK: - Body
    
    func body(content: Content) -> some View {
        content.overlay(
            MUISnackbarView(
                isPresented: $isPresented,
                message: message,
                duration: duration,
                primaryButtonTitle: primaryButtonTitle,
                primaryAction: primaryAction
            )
        )
    }
}

// MARK: - MUISnackbarView

/// A custom MaterialUI style snackbar that can be displayed at the bottom of the screen.
@available(iOS 17.0, *)
private struct MUISnackbarView: View {
    
    // MARK: - Properties
    
    @Binding public var isPresented: Bool
    @State private var animationFlag: Bool = false
    @Environment(\.colorScheme) private var colorScheme

    public let message: String
    public let duration: Double?
    public let primaryButtonTitle: String?
    public let primaryAction: (() -> Void)?
    
    // MARK: - View Body
    
    var body: some View {
        ZStack {
            // Backgorund
            Color.gray.opacity(0.0)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading) {
                Spacer()
                
                HStack {
                    // Snackbar message
                    Text(message)
                        .foregroundColor(MaterialUI.tint.primaryTitle(colorScheme))
                        .font(.system(.headline, weight: .medium))
                    
                    Spacer()
                    
                    // Optional action button
                    if let primaryButtonTitle {
                        Button {
                            primaryAction?()
                        } label: {
                            Text(primaryButtonTitle)
                                .textButtonStyle(0, colorScheme)
                                .font(.system(.headline, weight: .semibold))
                        }
                    }
                }
                .lineLimit(1)
                .padding(20)
                .background(MaterialUI.tint.tertiaryBackground(colorScheme))
                .cornerRadius(20)
                .shadow(color: .black.opacity(0.15), radius: 3, x: 0, y: 2)
            }
            .frame(width: UIScreen.main.bounds.width/1.1)
            .padding(.bottom, 75)
        }
        // In-animation
        .offset(y: animationFlag ? 0 : UIScreen.main.bounds.height)
        // To toggle of snackbar
        .onChange(of: isPresented) { oldValue, newValue in
            withAnimation(.bouncy) {
                animationFlag = isPresented
                toggleOffSnackbar(isPresented: $isPresented, duration: duration)
            }
        }
    }
}

// MARK: - Extension MUISnackbarView

@available(iOS 17.0, *)
extension MUISnackbarView {
    
    /// A function to toggle off the snackbar in specific time interval.
    /// - Parameters:
    ///   - isPresented: Binding to control the visibility state of the snackbar.
    ///   - duration: The duration for which the snackbar is visible before automatically toggling off.
    private func toggleOffSnackbar(isPresented: Binding<Bool>, duration: Double?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + (duration ?? 5)) {
            withAnimation {
                isPresented.wrappedValue = false
            }
        }
    }
}

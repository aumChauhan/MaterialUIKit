//
// MUIAlert.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 30/12/23
//

import SwiftUI

// MARK: - Extension View

@available(iOS 17.0, *)
extension View {
    
    /// Presents a MaterialUI style alert over the current view.
    ///
    /// - Parameters:
    ///   - isPresented: Binding to control the presentation state of the alert.
    ///   - title: The title of the alert.
    ///   - message: The message displayed in the alert.
    ///   - primaryButtonTitle: The title of the primary (main) button.
    ///   - secondaryButtonTitle: The title of the secondary button (optional).
    ///   - primaryAction: The action to be executed when the primary button is tapped.
    ///   - secondaryAction: The action to be executed when the secondary button is tapped (optional).
    public func mUIAlert(
        isPresented: Binding<Bool>,
        title: String,
        message: String,
        primaryButtonTitle: String,
        primaryAction: @escaping () -> Void,
        secondaryButtonTitle: String? = nil,
        secondaryAction: (() -> Void)? = nil) -> some View {
            self.modifier(
                MUIAlertModifier(
                    isPresented: isPresented,
                    title: title,
                    message: message,
                    primaryButtonTitle: primaryButtonTitle,
                    primaryAction: primaryAction,
                    secondaryButtonTitle: secondaryButtonTitle,
                    secondaryAction: secondaryAction
                )
            )
        }
}

// MARK: - MUIAlertModifier

/// A view modifier that adds the MaterialUI style alert presentation behavior to any view.
@available(iOS 17.0, *)
private struct MUIAlertModifier: ViewModifier {
    
    // MARK: - Properties
    
    @Binding public var isPresented: Bool
    public let title: String
    public let message: String?
    public let primaryButtonTitle: String
    public let primaryAction: () -> Void
    public let secondaryButtonTitle: String?
    public let secondaryAction: (() -> Void)?
    
    // MARK: - Body
    
    func body(content: Content) -> some View {
        content.overlay(
            MUIAlertView(
                isPresented: $isPresented,
                title: title,
                message: message,
                primaryButtonTitle: primaryButtonTitle,
                primaryAction: primaryAction,
                secondaryButtonTitle: secondaryButtonTitle,
                secondaryAction: secondaryAction
            )
        )
    }
}

// MARK: - MUIAlertView

/// A custom Material UI style alert view that can be presented over other views.
@available(iOS 17.0, *)
private struct MUIAlertView: View {
    
    // MARK: - Properties
    
    @Binding public var isPresented: Bool
    @State private var animationFlag: Bool = false
    @Environment(\.colorScheme) private var colorScheme

    public let title: String
    public let message: String?
    public let primaryButtonTitle: String
    public let primaryAction: () -> Void
    public let secondaryButtonTitle: String?
    public let secondaryAction: (() -> Void)?
    
    // MARK: - View Body
    
    var body: some View {
        ZStack {
            // Backgorund
            Color.gray.opacity(0.0)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading, spacing: 10) {
                // Alert tittle
                Text(title)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(MaterialUI.tint.primaryTitle(colorScheme))
                    .lineLimit(1)
                
                // Alert message
                if let message {
                    Text(message)
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(MaterialUI.tint.secondaryTitle(colorScheme))
                        .multilineTextAlignment(.leading)
                }
                
                // Alert buttons
                HStack {
                    Spacer()
                    // Secondary button
                    if let secondaryButtonTitle = secondaryButtonTitle {
                        Button {
                            secondaryAction?()
                            withAnimation(.bouncy) {
                                isPresented = false
                            }
                        } label: {
                            Text(secondaryButtonTitle)
                                .textButtonStyle(10, colorScheme)
                        }
                    }
                    
                    // Primary button
                    Button {
                        primaryAction()
                        
                        // Dismiss the alert box if secondaryButton is nil.
                        if secondaryAction == nil {
                            withAnimation(.bouncy) {
                                isPresented = false
                            }
                        }
                    } label: {
                        Text(primaryButtonTitle)
                            .filledButtonStyle(colorScheme)
                            .cornerRadius(100)
                    }
                }
            }
            .frame(width: UIScreen.main.bounds.width/1.3)
            .padding(20)
            .background(MaterialUI.tint.iconColor(colorScheme))
            .cornerRadius(25)
            .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 1)
        }
        // In-Out animation
        .scaleEffect(animationFlag ? 1 : 0)
        .opacity(animationFlag ? 1 : 0)
        .onChange(of: isPresented) { oldValue, newValue in
            withAnimation(.bouncy) {
                animationFlag = isPresented
            }
        }
    }
}


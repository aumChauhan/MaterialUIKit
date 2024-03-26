//
// MUIAlert.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 30/12/23
//

import SwiftUI

// MARK: - Extension View

@available(iOS 15.0, *)
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
    public func muiAlert(
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
@available(iOS 15.0, *)
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
@available(iOS 15.0, *)
private struct MUIAlertView: View {
    
    // MARK: - Properties
    
    @Binding public var isPresented: Bool
    @State private var animationFlag: Bool = false

    public let title: String
    public let message: String?
    public let primaryButtonTitle: String
    public let primaryAction: () -> Void
    public let secondaryButtonTitle: String?
    public let secondaryAction: (() -> Void)?
    
    // MARK: - View Body
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: MUIConstants.verticalContentPadding) {
                // Alert tittle
                Text(title)
                    .font(.title3)
                    .fontWeightWithFallback(.medium)
                    .foregroundColor(MaterialUIKit.tint.primaryTitle())
                    .lineLimit(1)
                
                // Alert message
                if let message {
                    Text(message)
                        .font(.headline)
                        .fontWeightWithFallback(.medium)
                        .foregroundColor(MaterialUIKit.tint.secondaryTitle())
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
                                .textButtonStyle(10)
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
                            .filledButtonStyle()
                            .cornerRadius(100)
                    }
                }
            }
            // Alert box width & style
            .frame(width: UIScreen.main.bounds.width/1.3)
            .padding(20)
            .background(MaterialUIKit.tint.background())
            .cornerRadius(25)
            // Stroke
            .padding(0.8)
            .background(MaterialUIKit.tint.secondaryTitle().opacity(0.4))
            .cornerRadius(MUIConstants.cornerRadius)
            // Scale-In animation
            .scaleEffect(animationFlag ? 1 : 0)
        }
        // Fullscreen backdrop
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.45))
        // Opacity animation
        .opacity(animationFlag ? 1 : 0)
        .onChangeWithFallback(of: isPresented) { oldValue, newValue in
            withAnimation(.bouncy) {
                animationFlag = isPresented
            }
        }
    }
}


//
// MaterialAlert.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 30/12/23
//

import SwiftUI

extension View {
    
    /// Presents a Material UI style alert with a title and message.
    ///
    /// - Parameters:
    ///   - isPresented: A binding to a Boolean value that determines whether to present the alert.
    ///   - titleKey: The title of the alert.
    ///   - message: The message displayed in the alert.
    ///
    /// - Returns: A view that presents a Material Design styled alert.
    public func materialAlert(
        isPresented: Binding<Bool>,
        titleKey: String,
        message: String
    ) -> some View {
        self.materialAlert(
            isPresented: isPresented,
            titleKey: titleKey,
            message: message,
            primaryButtonTitle: "Cancel",
            primaryAction: {}
        )
    }
    
    /// Presents a Material UI style alert with a title, message, and primary button.
    ///
    /// - Parameters:
    ///   - isPresented: A binding to a Boolean value that determines whether to present the alert.
    ///   - titleKey: The title of the alert.
    ///   - message: The message displayed in the alert.
    ///   - primaryButtonTitle: The title of the primary button.
    ///   - primaryAction: The action to perform when the primary button is tapped.
    ///
    /// - Returns: A view that presents a Material Design styled alert.
    public func materialAlert(
        isPresented: Binding<Bool>,
        titleKey: String,
        message: String,
        primaryButtonTitle: String,
        primaryAction: @escaping () -> Void
    ) -> some View {
        self.materialAlert(
            isPresented: isPresented,
            titleKey: titleKey,
            message: message,
            primaryButtonTitle: primaryButtonTitle,
            primaryAction: primaryAction,
            secondaryButtonTitle: nil,
            secondaryAction: nil
        )
    }
    
    /// Presents a Material UI style alert with a title, message, primary and secondary buttons.
    ///
    /// - Parameters:
    ///   - isPresented: A binding to a Boolean value that determines whether to present the alert.
    ///   - titleKey: The title of the alert.
    ///   - message: The message displayed in the alert.
    ///   - primaryButtonTitle: The title of the primary button.
    ///   - primaryAction: The action to perform when the primary button is tapped.
    ///   - secondaryButtonTitle: The title of the secondary button.
    ///   - secondaryAction: The action to perform when the secondary button is tapped.
    ///
    /// - Returns: A view that presents a Material Design styled alert.
    public func materialAlert(
        isPresented: Binding<Bool>,
        titleKey: String,
        message: String,
        primaryButtonTitle: String,
        primaryAction: @escaping () -> Void,
        secondaryButtonTitle: String?,
        secondaryAction: (() -> Void)?
    ) -> some View {
        self.modifier(
            MaterialAlertModifier(
                isPresented: isPresented,
                titleKey: titleKey,
                message: message,
                primaryButtonTitle: primaryButtonTitle,
                primaryAction: primaryAction,
                secondaryButtonTitle: secondaryButtonTitle,
                secondaryAction: secondaryAction
            )
        )
    }
}

// MARK: - MaterialAlertModifier

/// A view modifier that adds alert sheet to any view.
@available(iOS 15.0, *)
fileprivate struct MaterialAlertModifier: ViewModifier {
    
    // MARK: - Properties
    
    @Binding var isPresented: Bool
    
    let titleKey: String
    let message: String?
    
    let primaryButtonTitle: String
    let primaryAction: () -> Void
    
    let secondaryButtonTitle: String?
    let secondaryAction: (() -> Void)?
    
    // MARK: - Body
    
    func body(content: Content) -> some View {
        content.overlay(
            MaterialAlertView(
                isPresented: $isPresented,
                titleKey: titleKey,
                message: message,
                primaryButtonTitle: primaryButtonTitle,
                primaryAction: primaryAction,
                secondaryButtonTitle: secondaryButtonTitle,
                secondaryAction: secondaryAction
            )
        )
    }
}

// MARK: - MaterialAlertView

/// A view that represents a Material Design styled alert.
fileprivate struct MaterialAlertView: View {
    
    // MARK: - Properties
    
    @Binding var isPresented: Bool
    @State private var animationFlag: Bool = false
    
    let titleKey: String
    let message: String?
    
    let primaryButtonTitle: String
    let primaryAction: () -> Void
    
    let secondaryButtonTitle: String?
    let secondaryAction: (() -> Void)?
    
    // MARK: - View Body
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 16) {
                Text(titleKey)
                    .font(.title3)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
                    .lineLimit(1)
                
                if let message = message {
                    Text(message)
                        .font(.headline)
                        .fontWeight(.medium)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.leading)
                }
                
                HStack {
                    Spacer()
                    
                    if let secondaryButtonTitle = secondaryButtonTitle {
                        Button {
                            secondaryAction?()
                            withAnimation {
                                isPresented = false
                            }
                        } label: {
                            Text(secondaryButtonTitle)
                        }
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                    }
                    
                    Button {
                        primaryAction()
                        withAnimation {
                            isPresented = false
                        }
                    } label: {
                        Text(primaryButtonTitle)
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
            }
            .frame(maxWidth: UIScreen.main.bounds.width * 0.75)
            .padding()
            .background(Color.white)
            .cornerRadius(16)
            .shadow(radius: 10)
            .scaleEffect(animationFlag ? 1 : 0)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.45))
        .opacity(animationFlag ? 1 : 0)
        .onAppear {
            withAnimation {
                animationFlag = true
            }
        }
        .onDisappear {
            withAnimation {
                animationFlag = false
            }
        }
    }
}

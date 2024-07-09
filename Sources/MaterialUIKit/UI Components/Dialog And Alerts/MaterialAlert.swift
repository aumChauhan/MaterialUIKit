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
            VStack(alignment: .leading, spacing: MaterialUIKit.configuration.stackSpacing) {
                Text(titleKey)
                    .font(.title2)
                    .fontWeightWithFallback(.semibold)
                    .foregroundStyle(.materialPrimaryTitle)
                    .lineLimit(1)
                
                if let message {
                    Text(message)
                        .font(.headline)
                        .fontWeightWithFallback(.medium)
                        .foregroundStyle(.materialSecondaryTitle)
                        .multilineTextAlignment(.leading)
                }
                
                HStack(spacing: MaterialUIKit.configuration.horizontalPadding) {
                    if let secondaryButtonTitle = secondaryButtonTitle {
                        Button {
                            secondaryAction?()
                            
                            withMaterialAnimation {
                                isPresented = false
                            }
                        } label: {
                            Text(secondaryButtonTitle)
                                .textStyledBackground(10)
                        }
                        .align(.trailing)
                    }
                    
                    Button {
                        primaryAction()
                        
                        if secondaryAction == nil {
                            withMaterialAnimation {
                                isPresented = false
                            }
                        }
                    } label: {
                        Text(primaryButtonTitle)
                            .filledStyledBackground()
                            .cornerRadius(.infinity)
                    }
                }
                .align(.trailing)
            }
            .frame(width: UIScreen.main.bounds.width/1.3)
            .primaryBackground()
            .scaleEffect(animationFlag ? 1 : 1.1)
        }
        .modalBackdrop(isPresented: $isPresented, animationFlag: $animationFlag)
    }
}

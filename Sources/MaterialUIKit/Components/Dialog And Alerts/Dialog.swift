//
// Dialog.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 30/12/23
//

import SwiftUI

// MARK: - PUBLIC

extension View {
    
    /// Presents a dialog box dialog with a title and message.
    ///
    /// - Parameters:
    ///   - isPresented: A binding to a Boolean value that determines whether to present the alert.
    ///   - titleKey: The title of the alert.
    ///   - message: The message displayed in the alert.
    @available(iOS 15.0, *)
    public func dialog(
        isPresented: Binding<Bool>,
        titleKey: String,
        message: String
    ) -> some View {
        self.dialog(
            isPresented: isPresented,
            titleKey: titleKey,
            message: message,
            primaryActionKey: "Cancel",
            primaryAction: {}
        )
    }
    
    /// Presents a dialog box with a title, message, and primary button.
    ///
    /// - Parameters:
    ///   - isPresented: A binding to a Boolean value that determines whether to present the alert.
    ///   - titleKey: The title of the alert.
    ///   - message: The message displayed in the alert.
    ///   - primaryActionKey: The title key of the primary button.
    ///   - primaryAction: The action to perform when the primary button is tapped.
    @available(iOS 15.0, *)
    public func dialog(
        isPresented: Binding<Bool>,
        titleKey: String,
        message: String,
        primaryActionKey: String,
        primaryAction: @escaping () -> Void
    ) -> some View {
        self.dialog(
            isPresented: isPresented,
            titleKey: titleKey,
            message: message,
            primaryActionKey: primaryActionKey,
            primaryAction: primaryAction,
            secondaryActionKey: nil,
            secondaryAction: nil
        )
    }
    
    /// Presents a dialog box with a title, message, primary and secondary buttons.
    ///
    /// - Parameters:
    ///   - isPresented: A binding to a Boolean value that determines whether to present the alert.
    ///   - titleKey: The title of the alert.
    ///   - message: The message displayed in the alert.
    ///   - primaryActionKey: The title key of the primary button.
    ///   - primaryAction: The action to perform when the primary button is tapped.
    ///   - secondaryActionKey: The title key of the secondary button.
    ///   - secondaryAction: The action to perform when the secondary button is tapped.
    @available(iOS 15.0, *)
    public func dialog(
        isPresented: Binding<Bool>,
        titleKey: String,
        message: String,
        primaryActionKey: String,
        primaryAction: @escaping () -> Void,
        secondaryActionKey: String?,
        secondaryAction: (() -> Void)?
    ) -> some View {
        self.modifier(
            DialogViewModifier(
                isPresented: isPresented,
                titleKey: titleKey,
                message: message,
                primaryActionKey: primaryActionKey,
                primaryAction: primaryAction,
                secondaryActionKey: secondaryActionKey,
                secondaryAction: secondaryAction
            )
        )
    }
}

// MARK: - FILE PRIVATE

/// Adds dialog sheet over the current view.
fileprivate struct DialogViewModifier: ViewModifier {
    
    // MARK: - PROPERTIES
    
    @Binding var isPresented: Bool
    
    let titleKey: String
    let message: String?
    
    let primaryActionKey: String
    let primaryAction: () -> Void
    
    let secondaryActionKey: String?
    let secondaryAction: (() -> Void)?
    
    // MARK: - BODY
    
    func body(content: Content) -> some View {
        content.overlay(
            Dialog(
                isPresented: $isPresented,
                titleKey: titleKey,
                message: message,
                primaryActionKey: primaryActionKey,
                primaryAction: primaryAction,
                secondaryActionKey: secondaryActionKey,
                secondaryAction: secondaryAction
            )
        )
    }
}

/// Represents a Material Design styled dialog box.
fileprivate struct Dialog: View {
    
    // MARK: - PROPERTIES
    
    @Binding var isPresented: Bool
    @State private var animationFlag: Bool = false
    
    let titleKey: String
    let message: String?
    
    let primaryActionKey: String
    let primaryAction: () -> Void
    
    let secondaryActionKey: String?
    let secondaryAction: (() -> Void)?
    
    // MARK: - VIEW BODY
    
    var body: some View {
        VStack(alignment: .leading, spacing: MaterialUIKit.configuration.verticalStackSpacing) {
            Text(titleKey)
                .font(MaterialUIKit.configuration.h2)
                .fontWeightWithFallback(.semibold)
                .foregroundStyle(.materialUIPrimaryTitle)
                .lineLimit(1)
            
            if let message {
                Text(message)
                    .font(MaterialUIKit.configuration.h4)
                    .foregroundStyle(.materialUISecondaryTitle)
                    .multilineTextAlignment(.leading)
            }
            
            HStack(spacing: MaterialUIKit.configuration.contentPadding) {
                if let secondaryActionKey = secondaryActionKey {
                    Button {
                        secondaryAction?()
                        
                        withMaterialAnimation {
                            isPresented = false
                        }
                        
                        hapticFeedback()
                    } label: {
                        Text(secondaryActionKey)
                            .font(MaterialUIKit.configuration.h4)
                            .fontWeightWithFallback(.semibold)
                    }
                    .tint(.materialUIAccent)
                    .align(.trailing)
                }
                
                Button {
                    primaryAction()
                    
                    withMaterialAnimation {
                        isPresented = false
                    }
                    
                    hapticFeedback()
                } label: {
                    Text(primaryActionKey)
                        .font(MaterialUIKit.configuration.h4)
                        .fontWeightWithFallback(.semibold)
                        .foregroundStyle(.materialUITonal)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 18)
                        .background(.materialUIAccent)
                        .cornerRadius(.infinity)
                }
            }
            .align(.trailing)
        }
        .frame(width: UIScreen.main.bounds.width/1.3)
        .secondaryBackground()
        .scaleEffect(animationFlag ? 1 : 1.1)
        .modalBackdrop(isPresented: $isPresented, animationFlag: $animationFlag)
    }
}

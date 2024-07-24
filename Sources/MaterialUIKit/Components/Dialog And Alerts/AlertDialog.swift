//
// AlertDialog.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 30/12/23
//

import SwiftUI

extension View {
    
    /// Presents a Material UI style alert dialog with a title and message.
    ///
    /// - Parameters:
    ///   - isPresented: A binding to a Boolean value that determines whether to present the alert.
    ///   - titleKey: The title of the alert.
    ///   - message: The message displayed in the alert.
    ///
    /// - Returns: A view that presents a Material Design styled alert.
    public func alertDialog(
        isPresented: Binding<Bool>,
        titleKey: String,
        message: String
    ) -> some View {
        self.alertDialog(
            isPresented: isPresented,
            titleKey: titleKey,
            message: message,
            primaryButtonTitle: "Cancel",
            primaryAction: {}
        )
    }
    
    /// Presents a Material UI style alert dialog with a title, message, and primary button.
    ///
    /// - Parameters:
    ///   - isPresented: A binding to a Boolean value that determines whether to present the alert.
    ///   - titleKey: The title of the alert.
    ///   - message: The message displayed in the alert.
    ///   - primaryButtonTitle: The title of the primary button.
    ///   - primaryAction: The action to perform when the primary button is tapped.
    ///
    /// - Returns: A view that presents a Material Design styled alert.
    public func alertDialog(
        isPresented: Binding<Bool>,
        titleKey: String,
        message: String,
        primaryButtonTitle: String,
        primaryAction: @escaping () -> Void
    ) -> some View {
        self.alertDialog(
            isPresented: isPresented,
            titleKey: titleKey,
            message: message,
            primaryButtonTitle: primaryButtonTitle,
            primaryAction: primaryAction,
            secondaryButtonTitle: nil,
            secondaryAction: nil
        )
    }
    
    /// Presents a Material UI style alert dialog with a title, message, primary and secondary buttons.
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
    public func alertDialog(
        isPresented: Binding<Bool>,
        titleKey: String,
        message: String,
        primaryButtonTitle: String,
        primaryAction: @escaping () -> Void,
        secondaryButtonTitle: String?,
        secondaryAction: (() -> Void)?
    ) -> some View {
        self.modifier(
            AlertDialogViewModifier(
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

// MARK: - AlertDialogViewModifier

/// A view modifier that adds alert dialog sheet to any view.
fileprivate struct AlertDialogViewModifier: ViewModifier {
    
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
            AlertDialog(
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

// MARK: - AlertDialog

/// A view that represents a Material Design styled alert dialog.
fileprivate struct AlertDialog: View {
    
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
                if let secondaryButtonTitle = secondaryButtonTitle {
                    Button {
                        secondaryAction?()
                        
                        withMaterialAnimation {
                            isPresented = false
                        }
                    } label: {
                        Text(secondaryButtonTitle)
                            .font(MaterialUIKit.configuration.h4)
                    }
                    .tint(.materialUIAccent)
                    .align(.trailing)
                }
                
                Button {
                    primaryAction()
                    
                    withMaterialAnimation {
                        isPresented = false
                    }
                } label: {
                    Text(primaryButtonTitle)
                        .font(MaterialUIKit.configuration.h4)
                        .padding(.vertical, 9)
                        .padding(.horizontal, 18)
                        .foregroundStyle(.materialUITonal)
                        .background(.materialUIAccent)
                        .cornerRadius(.infinity)
                }
            }
            .align(.trailing)
        }
        .frame(width: UIScreen.main.bounds.width/1.3)
        .primaryBackground()
        .scaleEffect(animationFlag ? 1 : 1.1)
        .modalBackdrop(isPresented: $isPresented, animationFlag: $animationFlag)
    }
}

//
// DialogSheet.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 24/01/24
//

import SwiftUI

// MARK: - PUBLIC

extension View {
    
    /// Presents a Material UI style dialog sheet over the current view.
    ///
    /// - Parameters:
    ///   - isPresented: A binding to a Boolean value that determines whether to present the dialog sheet.
    ///   - content: A closure returning the view content to be displayed in the dialog sheet.
    ///
    /// - Returns: A modified view with the Material Design dialog sheet behavior.
    public func dialogSheet<Content>(
        isPresented: Binding<Bool>,
        _ content: @escaping () -> Content
    ) -> some View where Content: View {
        self.modifier(
            DialogSheetViewModifier(isPresented: isPresented, dialogSheetContent: AnyView(content()))
        )
    }
}

/// A view modifier that adds dialog sheet behavior to any view.
fileprivate struct DialogSheetViewModifier: ViewModifier {
    
    @Binding var isPresented: Bool
    let dialogSheetContent: AnyView
    
    func body(content: Content) -> some View {
        content.overlay(
            DialogSheet(isPresented: $isPresented, content: dialogSheetContent)
        )
    }
}

// MARK: - FILE PRIVATE

/// A view represents Material UI styled dialog sheet.
fileprivate struct DialogSheet: View {
    
    // MARK: - PROPERTIES
    
    @Binding var isPresented: Bool
    @State private var animationFlag: Bool = false
    
    let content: AnyView
    
    // MARK: - INITIALIZER
    
    init(isPresented: Binding<Bool>, content: AnyView) {
        self._isPresented = isPresented
        self.content = content
    }
    
    // MARK: - VIEW BODY
    
    var body: some View {
        VStack(alignment: .leading, spacing: MaterialUIKit.configuration.verticalStackSpacing) {
            Button {
                isPresented.toggle()
            } label: {
                Image(systemName: "xmark")
                    .foregroundStyle(.materialUIPrimaryTitle)
            }
            .align(.leading)
            
            content
        }
        .frame(width: UIScreen.main.bounds.width/1.3)
        .secondaryBackground()
        .scaleEffect(animationFlag ? 1 : 1.1)
        .modalBackdrop(isPresented: $isPresented, animationFlag: $animationFlag)
    }
}

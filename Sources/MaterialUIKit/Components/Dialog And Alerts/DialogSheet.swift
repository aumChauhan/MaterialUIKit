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
    
    /// Presents a dialog sheet over the current view.
    ///
    /// - Parameters:
    ///   - isPresented: A binding to a Boolean value that determines whether to present the dialog sheet.
    ///   - content: A closure returning the view content to be displayed in the dialog sheet.
    @available(iOS 15.0, *)
    public func dialogSheet<Content>(
        isPresented: Binding<Bool>,
        _ content: @escaping () -> Content
    ) -> some View where Content: View {
        self.modifier(
            DialogSheetViewModifier(isPresented: isPresented, dialogSheetContent: AnyView(content()))
        )
    }
}

// MARK: - FILE PRIVATE

/// Adds dialog sheet over the current view.
fileprivate struct DialogSheetViewModifier: ViewModifier {
    
    @Binding var isPresented: Bool
    let dialogSheetContent: AnyView
    
    func body(content: Content) -> some View {
        content.overlay(
            DialogSheet(isPresented: $isPresented, content: dialogSheetContent)
        )
    }
}

/// Represents Material Desgin styled dialog sheet.
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
                hapticFeedback()
            } label: {
                Image(systemName: "xmark")
                    .fontWeightWithFallback(.medium)
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

//
// MaterialDialogSheet.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 24/01/24
//

import SwiftUI

extension View {
    
    /// Presents a Material UI style dialog sheet over the current view.
    ///
    /// - Parameters:
    ///   - isPresented: A binding to a Boolean value that determines whether to present the dialog sheet.
    ///   - content: A closure returning the view content to be displayed in the dialog sheet.
    ///
    /// - Returns: A modified view with the Material Design dialog sheet behavior.
    public func materialDesignDialogSheet<Content>(
        isPresented: Binding<Bool>,
        _ content: @escaping () -> Content
    ) -> some View where Content: View {
        self.modifier(
            MaterialDesignDialogSheetModifier(isPresented: isPresented, dialogSheetContent: AnyView(content()))
        )
    }
}

// MARK: - MaterialDesignDialogSheetModifier

/// A view modifier that adds dialog sheet behavior to any view.
fileprivate struct MaterialDesignDialogSheetModifier: ViewModifier {
    
    @Binding var isPresented: Bool
    let dialogSheetContent: AnyView

    func body(content: Content) -> some View {
        content.overlay(
            MaterialDesignDialogSheetView(isPresented: $isPresented, content: dialogSheetContent)
        )
    }
}

// MARK: - MaterialDesignDialogSheetView

/// A view represents Material UI styled dialog sheet.
fileprivate struct MaterialDesignDialogSheetView: View {
    
    // MARK: - Properties

    @Binding var isPresented: Bool
    @State private var animationFlag: Bool = false
    
    let content: AnyView
    
    // MARK: - Initializer

    init(isPresented: Binding<Bool>, content: AnyView) {
        self._isPresented = isPresented
        self.content = content
    }
    
    // MARK: - View Body

    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: MaterialUIKitConstants.verticalContentPadding) {
                HStack {
                    Button {
                        isPresented.toggle()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundStyle(.muiSecondaryTitle)
                    }
                    Spacer()
                }
                content
            }
            .frame(width: UIScreen.main.bounds.width / 1.3)
            .padding(20)
            .background(.muiTonal)
            .cornerRadius(MaterialUIKitConstants.cornerRadius)
            .padding(0.8)
            .background(.muiSecondaryTitle.opacity(0.4))
            .cornerRadius(MaterialUIKitConstants.cornerRadius)
            .scaleEffect(animationFlag ? 1 : 0)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.45))
        .opacity(animationFlag ? 1 : 0)
        .onChange(of: isPresented) { _ in
            withAnimation(.bouncy) {
                animationFlag = isPresented
            }
        }
    }
}
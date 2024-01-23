//
// MUIDialogSheet.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 24/01/24
//

import SwiftUI

// MARK: - Extension View

@available(iOS 15.0, *)
extension View {
    
    /// Presents a MaterialUI style dialog sheet over the current view.
    ///
    /// - Parameters:
    ///   - isPresented: Binding to control the presentation state of the dialog sheet.
    ///   - content: A view content to be displayed in the dialog sheet.
    public func mUIDialogSheet<Content: View>(isPresented: Binding<Bool>, _ content: () -> Content) -> some View {
        self.modifier(
            MUIDialogSheetModifer(isPresented: isPresented, dialogSheetContent: AnyView(content()))
        )
    }
}

// MARK: - MUIDialogSheetModifer

/// A view modifier that adds the MaterialUI style dialog sheet  behavior to any view.
@available(iOS 15.0, *)
private struct MUIDialogSheetModifer: ViewModifier {
    
    // MARK: - Properties
    
    @Binding public var isPresented: Bool
    public let dialogSheetContent: AnyView
    
    // MARK: - Body
    
    func body(content: Content) -> some View {
        content.overlay(
            MUIDialogSheetView(isPresented: $isPresented, content: dialogSheetContent)
        )
    }
}

// MARK: - MUIDialogSheetView

/// A custom Material UI style dialog sheet that can be presented over other views.
@available(iOS 15.0, *)
private struct MUIDialogSheetView: View {
    
    // MARK: - Properties
    
    @Binding public var isPresented: Bool
    @State private var animationFlag: Bool = false
    
    public let content: any View
    
    // MARK: Initializers
    
    public init(isPresented: Binding<Bool>, content: any View) {
        self._isPresented = isPresented
        self.content = content
    }
    
    // MARK: - View Body
    
    var body: some View {
        ZStack {
            // Backgorund
            Color.gray.opacity(0.0)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading, spacing: 10) {
                // Sheet dismiss button
                HStack {
                    Button {
                        isPresented.toggle()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(MaterialUI.tint.secondaryTitle())
                    }
                    
                    Spacer()
                }
                
                AnyView(content)
            }
            .frame(width: UIScreen.main.bounds.width/1.3)
            .padding(20)
            .background(MaterialUI.tint.iconColor())
            .cornerRadius(25)
            .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 1)
        }
        // In-Out animation
        .scaleEffect(animationFlag ? 1 : 0)
        .opacity(animationFlag ? 1 : 0)
        .onChangeWithFallback(of: isPresented) { oldValue, newValue in
            withAnimation(.bouncy) {
                animationFlag = isPresented
            }
        }
    }
}

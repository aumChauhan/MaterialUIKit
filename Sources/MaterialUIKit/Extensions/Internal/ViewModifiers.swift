//
// ViewModifiers.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 09/07/24
//

import SwiftUI

package extension View {
    
    /// Applies a stroke to the view using the configuration settings for border width, color, and corner radius.
    ///
    /// - Parameter cornerRadius: The corner radius for the stroke. If `nil`, the radius from the configuration is used.
    func stroke(background: Color? = nil, cornerRadius: CGFloat? = nil) -> some View {
        self
            .padding(MaterialUIKit.configuration.borderWidth)
            .background(background ?? .materialUIOutline)
            .cornerRadius(cornerRadius ?? MaterialUIKit.configuration.cornerRadius)
    }
    
    /// Applies a material primary background with corner radius and margin to the view.
    ///
    /// - Parameter cornerRadius: The corner radius for the stroke. If `nil`, the radius from the configuration is used.
    func primaryBackground(cornerRadius: CGFloat? = nil) -> some View {
        self
            .padding(MaterialUIKit.configuration.contentPadding)
            .background(.materialUIPrimaryBackground)
            .cornerRadius(cornerRadius ?? MaterialUIKit.configuration.cornerRadius)
    }
    
    /// Applies a material secondary background with corner radius and margin to the view.
    ///
    /// - Parameter cornerRadius: The corner radius for the stroke. If `nil`, the radius from the configuration is used.
    func secondaryBackground(cornerRadius: CGFloat? = nil) -> some View {
        self
            .padding(MaterialUIKit.configuration.contentPadding)
            .background(.materialUISecondaryBackground)
            .cornerRadius(cornerRadius ?? MaterialUIKit.configuration.cornerRadius)
    }
    
    /// Applies a material tertiary background with corner radius and margin to the view.
    ///
    /// - Parameter cornerRadius: The corner radius for the stroke. If `nil`, the radius from the configuration is used.
    func tertiaryBackground(cornerRadius: CGFloat? = nil) -> some View {
        self
            .padding(MaterialUIKit.configuration.contentPadding)
            .background(.materialUITertiaryBackground)
            .cornerRadius(cornerRadius ?? MaterialUIKit.configuration.cornerRadius)
    }
    
    /// Aligns the view within its frame based on the specified alignment option.
    ///
    /// - Parameter at: The alignment option specifying how to align the view within its frame.
    @ViewBuilder
    func align(_ at: Alignment) -> some View {
        switch at {
        case .top:
            self.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        case .bottom:
            self.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        case .leading:
            self.frame(maxWidth: .infinity, alignment: .leading)
        case .trailing:
            self.frame(maxWidth: .infinity, alignment: .trailing)
        case .topLeading:
            self.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        case .topTrailing:
            self.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
        case .bottomLeading:
            self.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
        case .bottomTrailing:
            self.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
        case .center:
            self.frame(maxWidth: .infinity, alignment: .center)
        default:
            self.frame(maxWidth: .infinity, alignment: .center)
        }
    }
    
    /// Executes a closure with the configured animation type from MaterialUIKit.
    ///
    /// - Parameter action: The closure to execute with the configured animation.
    func withMaterialAnimation(_ action: @escaping () -> Void) {
        withAnimation(MaterialUIKit.configuration.animationType) {
            action()
        }
    }
    
    /// Adds a backdrop for modal presentation, with animation synchronization.
    ///
    /// - Parameters:
    ///   - isPresented: Binding to control the modal presentation.
    ///   - animationFlag: Binding to synchronize animation state.
    func modalBackdrop(isPresented: Binding<Bool>, animationFlag: Binding<Bool>) -> some View {
        self
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black.opacity(0.45))
            .opacity(animationFlag.wrappedValue ? 1 : 0)
            .onChange(of: isPresented.wrappedValue) { _ in
                withMaterialAnimation {
                    animationFlag.wrappedValue = isPresented.wrappedValue
                }
            }
    }
    
    /// Applies vertical and horizontal padding to the view using the values from `MaterialUIKit.configuration`.
    ///
    /// - Returns: A view with the specified vertical and horizontal padding applied.
    func contentPadding() -> some View {
        self
            .padding(.horizontal, 4)
            .padding(.vertical, MaterialUIKit.configuration.verticalPadding)
            .padding(.horizontal, MaterialUIKit.configuration.horizontalPadding)
    }
    
    /// Applies vertical and horizontal padding to the view and sets the width to the maximum available, using the values from `MaterialUIKit.configuration`.
    ///
    /// - Returns: A view with the specified vertical and horizontal padding applied and width set to maximum.
    func extendedWidthPadded() -> some View {
        self
            .padding(.vertical, MaterialUIKit.configuration.verticalPadding)
            .padding(.horizontal, MaterialUIKit.configuration.horizontalPadding)
            .frame(maxWidth: .infinity)
    }
}

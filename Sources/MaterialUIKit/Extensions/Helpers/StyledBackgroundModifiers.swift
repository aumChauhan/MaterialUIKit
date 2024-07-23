//
// StyledBackgroundModifiers.swift.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 06/07/24
//

import SwiftUI

package extension View {
    /// Adds an elevated background and rounded corners.
    func elevatedStyledBackground() -> some View {
        return self
            .foregroundStyle(.materialHighlight)
            .margin()
            .background(.materialTertiaryBackground)
            .shadow(color: .black.opacity(0.15), radius: 1.5, x: 0, y: 1)
            .shadow(color: .black.opacity(0.3), radius: 1, x: 0, y: 1)
    }
    
    /// Adds a filled background and rounded corners.
    func filledStyledBackground() -> some View {
        return self
            .foregroundStyle(.materialTonal)
            .margin()
            .background(.materialAccent)
    }
    
    /// Adds a tonal background and rounded corners.
    func tonalStyledBackground() -> some View {
        return self
            .foregroundStyle(.materialHighlight)
            .margin()
            .background(.materialSecondaryBackground)
    }
    
    /// Adds a outline background and rounded corners.
    func outlineStyledBackground(cornerRadius: CGFloat? = nil) -> some View {
        return self
            .foregroundStyle(.materialAccent)
            .margin()
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius ?? .infinity)
                    .stroke(.materialAccent, lineWidth: MaterialUIKit.configuration.borderWidth)
            )
    }
    
    /// Adds a text-only button with no background.
    func textStyledBackground(_ padding: CGFloat? = nil) -> some View {
        return self
            .foregroundStyle(.materialAccent)
            .padding(padding ?? 10)
    }
    
    /// Adds elevated background and rounded corners, occupying full available width.
    func elevatedStretchedStyledBackground(cornerRadius: CGFloat? = nil) -> some View {
        return self
            .foregroundStyle(.materialHighlight)
            .extendedWidthPadded()
            .background(.materialTertiaryBackground)
            .shadow(color: .black.opacity(0.15), radius: 1.5, x: 0, y: 1)
            .shadow(color: .black.opacity(0.3), radius: 1, x: 0, y: 1)
    }
    
    /// Adds a filled background and rounded corners, occupying full available width.
    func filledStretchedStyledBackground(cornerRadius: CGFloat? = nil) -> some View {
        return self
            .foregroundStyle(.materialTonal)
            .extendedWidthPadded()
            .background(.materialAccent)
    }
    
    /// Adds a tonal background and rounded corners, occupying full available width.
    func tonalStretchedStyledBackground(cornerRadius: CGFloat? = nil) -> some View {
        return self
            .foregroundStyle(.materialHighlight)
            .extendedWidthPadded()
            .background(.materialSecondaryBackground)
    }
    
    /// Adds an outlined border and rounded corners, occupying full available width.
    func outlineStretchedStyledBackground(cornerRadius: CGFloat? = nil) -> some View {
        return self
            .foregroundStyle(.materialAccent)
            .extendedWidthPadded()
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius ?? .infinity)
                    .stroke(.materialAccent, lineWidth: MaterialUIKit.configuration.borderWidth)
                    .frame(maxWidth: .infinity)
            )
    }
}

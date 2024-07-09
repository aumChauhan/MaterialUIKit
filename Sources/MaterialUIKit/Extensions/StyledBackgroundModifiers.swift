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
            .font(.headline)
            .fontWeightWithFallback(.medium)
            .foregroundStyle(.materialHighlight)
            .padding(.vertical, 10)
            .padding(.horizontal, 20)
            .background(.materialTertiaryBackground)
            .cornerRadius(15)
            .shadow(color: .black.opacity(0.15), radius: 1.5, x: 0, y: 1)
            .shadow(color: .black.opacity(0.3), radius: 1, x: 0, y: 1)
    }
    
    /// Adds a filled background and rounded corners.
    func filledStyledBackground() -> some View {
        return self
            .font(.headline)
            .fontWeightWithFallback(.medium)
            .foregroundStyle(.materialTonal)
            .padding(.vertical, 10)
            .padding(.horizontal, 20)
            .background(.materialAccent)
            .cornerRadius(15)
    }
    
    /// Adds a tonal background and rounded corners.
    func tonalStyledBackground() -> some View {
        return self
            .font(.headline)
            .fontWeightWithFallback(.medium)
            .foregroundStyle(.materialHighlight)
            .padding(.vertical, 10)
            .padding(.horizontal, 20)
            .background(.materialSecondaryBackground)
            .cornerRadius(15)
    }
    
    /// Adds a outline background and rounded corners.
    func outlineStyledBackground() -> some View {
        return self
            .font(.headline)
            .fontWeightWithFallback(.regular)
            .foregroundStyle(.materialAccent)
            .padding(.vertical, 10)
            .padding(.horizontal, 20)
            .overlay(
                RoundedRectangle(cornerRadius: 100)
                    .stroke(.materialAccent, lineWidth: 1)
            )
    }
    
    /// Adds a text-only button with no background.
    func textStyledBackground(_ padding: CGFloat? = nil) -> some View {
        return self
            .font(.headline)
            .fontWeightWithFallback(.medium)
            .foregroundStyle(.materialAccent)
            .padding(padding ?? 10)
    }
    
    // MARK: - Infinity Width View Modifiers
    
    /// Adds elevated background and rounded corners, occupying full available width.
    func elevatedStretchedStyledBackground(cornerRadius: CGFloat? = nil) -> some View {
        return self
            .font(.headline)
            .fontWeightWithFallback(.medium)
            .foregroundStyle(.materialHighlight)
            .padding(.vertical, 15)
            .padding(.horizontal, 20)
            .frame(maxWidth: .infinity)
            .background(.materialTertiaryBackground)
            .cornerRadius(cornerRadius ?? 15)
            .shadow(color: .black.opacity(0.15), radius: 1.5, x: 0, y: 1)
            .shadow(color: .black.opacity(0.3), radius: 1, x: 0, y: 1)
    }
    
    /// Adds a filled background and rounded corners, occupying full available width.
    func filledStretchedStyledBackground(cornerRadius: CGFloat? = nil) -> some View {
        return self
            .font(.headline)
            .fontWeightWithFallback(.medium)
            .foregroundStyle(.materialTonal)
            .padding(.vertical, 15)
            .padding(.horizontal, 20)
            .frame(maxWidth: .infinity)
            .background(.materialAccent)
            .cornerRadius(cornerRadius ?? 15)
    }
    
    /// Adds a tonal background and rounded corners, occupying full available width.
    func tonalStretchedStyledBackground(cornerRadius: CGFloat? = nil) -> some View {
        return self
            .font(.headline)
            .fontWeightWithFallback(.medium)
            .foregroundStyle(.materialHighlight)
            .padding(.vertical, 15)
            .padding(.horizontal, 20)
            .frame(maxWidth: .infinity)
            .background(.materialSecondaryBackground)
            .cornerRadius(cornerRadius ?? 15)
    }
    
    /// Adds an outlined border and rounded corners, occupying full available width.
    func outlineStretchedStyledBackground() -> some View {
        return self
            .font(.headline)
            .fontWeightWithFallback(.regular)
            .foregroundStyle(.materialAccent)
            .padding(.vertical, 15)
            .padding(.horizontal, 20)
            .frame(maxWidth: .infinity)
            .overlay(
                RoundedRectangle(cornerRadius: 99)
                    .stroke(.materialAccent, lineWidth: 1)
                    .frame(maxWidth: .infinity)
            )
    }
}

//
// MaterialButtonStyle.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 05/07/24
//

import Foundation

/// Represents different button styles for the ``MaterialButton``.
@frozen
public enum MaterialButtonStyle {
    /// An elevated background and rounded corners.
    case elevated
    
    /// A filled background and rounded corners.
    case filled
    
    /// A tonal background and rounded corners.
    case tonal
    
    /// An outlined border and rounded corners.
    case outline
    
    /// A text-only button with no background.
    case text
    
    /// An elevated background and rounded corners, occupying full available width.
    case elevatedStretched

    /// A filled background and rounded corners, occupying full available width.
    case filledStretched
    
    /// A tonal background and rounded corners, occupying full available width.
    case tonalStretched
    
    /// An outlined border and rounded corners, occupying full available width.
    case outlineStretched
}

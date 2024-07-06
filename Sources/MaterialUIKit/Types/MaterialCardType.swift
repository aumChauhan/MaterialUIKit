//
// MUICardView.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 05/07/2024
//

import SwiftUI

/// To specify the type of ``MaterialCard`` card layout.
@frozen
public enum MaterialCardType {
    /// Automatically determine the card layout based on content.
    case automatic
    
    /// Horizontal card layout.
    case horizontal
    
    /// Stack card layout.
    case stack
}

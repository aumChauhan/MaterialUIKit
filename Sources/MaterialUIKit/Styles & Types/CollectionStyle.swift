//
// CollectionStyle.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 06/07/24
//

import SwiftUI

/// Represents different styles for ``Collection``.
@available(iOS 15.0, *)
@frozen public enum CollectionStyle {
    /// A plain-style list.
    case plain
    
    /// A list style with inset cells.
    case inset
    
    /// A grouped list style with inset cells.
    case insetGrouped
}

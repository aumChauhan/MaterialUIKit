//
// Date.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 16/04/24
//

import SwiftUI

/// An extension on `Date` to format dates in a specific format.
@available(iOS 15.0, *)
extension Date {
    
    /// Formats the date in the "E, MMM D" style.
    /// - Returns: A formatted string representing the date.
    public func formattedMUIDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, MMM d"
        return dateFormatter.string(from: self)
    }
}


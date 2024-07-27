//
// Date.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 16/04/24
//

import SwiftUI

/// An extension on `Date` to format dates in a specific format.
package extension Date {
    
    /// Formats the date in the "E, MMM D" style.
    func formattedMUIDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, MMM d"
        return dateFormatter.string(from: self)
    }
}

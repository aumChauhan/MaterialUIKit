//
// FontWeightKey.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 24/07/24
//

import SwiftUI

/// Environment key for setting the font weight.
package struct FontWeightKey: EnvironmentKey {
    package static var defaultValue: Font.Weight = .medium
}

package extension EnvironmentValues {
    var fontWeight: Font.Weight {
        get { self[FontWeightKey.self] }
        set { self[FontWeightKey.self] = newValue }
    }
}

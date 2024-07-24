//
// FontKey.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 24/07/24
//

import SwiftUI

/// Environment key for setting the font.
package struct FontKey: EnvironmentKey {
    package static var defaultValue: Font = MaterialUIKit.configuration.h4
}

package extension EnvironmentValues {
    var font: Font {
        get { self[FontKey.self] }
        set { self[FontKey.self] = newValue }
    }
}


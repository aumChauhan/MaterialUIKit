//
// CornerRadiusKey.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 24/07/24
//

import SwiftUI

/// Environment key for setting the corner radius.
package struct CornerRadiusKey: EnvironmentKey {
    package static var defaultValue: CGFloat = MaterialUIKit.configuration.cornerRadius
}

package extension EnvironmentValues {
    var cornerRadius: CGFloat {
        get { self[CornerRadiusKey.self] }
        set { self[CornerRadiusKey.self] = newValue }
    }
}

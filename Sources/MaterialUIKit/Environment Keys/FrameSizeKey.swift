//
// FrameSizeKey.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 24/07/24
//

import SwiftUI

/// Environment key for setting the frame size.
package struct FrameSizeKey: EnvironmentKey {
    package static var defaultValue: CGFloat = 20
}

package extension EnvironmentValues {
    var frameSize: CGFloat {
        get { self[FrameSizeKey.self] }
        set { self[FrameSizeKey.self] = newValue }
    }
}

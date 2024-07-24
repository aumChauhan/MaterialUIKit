//
// UINavigationController.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 24/07/24
//

import SwiftUI

/// An extension for `UINavigationController` to customize its behavior.
extension UINavigationController {
    
    /// Overrides the `viewDidLoad` method to disable the interactive pop gesture recognizer's delegate.
    open override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = nil
    }
}

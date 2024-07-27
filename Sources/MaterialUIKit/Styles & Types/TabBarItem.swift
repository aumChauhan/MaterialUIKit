//
// TabBarItem.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 06/07/24
//

import SwiftUI

/// A model representing an item in the MaterialUI-style tab bar.
@available(iOS 15.0, *)
public struct TabBarItem: Hashable {
    
    // MARK: - PROPERTIES
    
    let systemImage: String
    let titleKey: String
    
    // MARK: - INITIALIZERS
    
    public init(systemImage: String, titleKey: String) {
        self.systemImage = systemImage
        self.titleKey = titleKey
    }
}

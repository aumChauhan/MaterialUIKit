//
// MUITabBarItem.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 06/07/24
//

import SwiftUI

/// A model representing an item in the MaterialUI-style tab bar.
public struct MUITabBarItem: Hashable {
    
    // MARK: - Properties
    
    let systemName: String
    let title: String
    
    // MARK: - Initializers
    
    public init(systemName: String, title: String) {
        self.systemName = systemName
        self.title = title
    }
}

//
// DropdownMenuLabel.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 24/07/24
//

import SwiftUI

/// Represents a Material UI styled label for a dropdown menu item.
@available(iOS 15.0, *)
public struct DropdownMenuLabel: View {
    
    // MARK: - PROPERTIES
    
    private let systemImage: String
    private let titleKey: String
    
    // MARK: - INITIALIZERS
    
    /// Creates a menu label with the given system image and title.
    ///
    /// - Parameters:
    ///   - systemImage: The name of the system image.
    ///   - titleKey: The title displayed next to the system image.
    public init(_ systemImage: String, _ titleKey: String) {
        self.systemImage = systemImage
        self.titleKey = titleKey
    }
    
    // MARK: - VIEW BODY
    
    public var body: some View {
        HStack(spacing: MaterialUIKit.configuration.horizontalStackSpacing) {
            Image(systemName: systemImage)
                .foregroundStyle(.materialUIAccent)
            
            Text(titleKey)
                .font(MaterialUIKit.configuration.h4)
                .foregroundStyle(.materialUIPrimaryTitle)
        }
    }
}

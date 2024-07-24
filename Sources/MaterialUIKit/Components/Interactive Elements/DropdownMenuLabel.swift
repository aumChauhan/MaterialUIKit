//
// DropdownMenuLabel.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 24/07/24
//

import SwiftUI

/// A label view to create a row cells in a ``DropdownMenu``.
public struct DropdownMenuLabel: View {
    
    // MARK: - PROPERTIES
    
    private let systemName: String
    private let title: String
    
    // MARK: - INITIALIZERS
    
    /// Creates a menu label with the given system image and title.
    ///
    /// - Parameters:
    ///   - systemName: The name of the system image.
    ///   - title: The title displayed next to the system image.
    public init(systemName: String, _ title: String) {
        self.systemName = systemName
        self.title = title
    }
    
    // MARK: - VIEW BODY
    
    public var body: some View {
        HStack(spacing: MaterialUIKit.configuration.horizontalStackSpacing) {
            Image(systemName: systemName)
                .foregroundStyle(.materialUIAccent)
            
            Text(title)
                .font(MaterialUIKit.configuration.h4)
                .foregroundStyle(.materialUIPrimaryTitle)
        }
    }
}

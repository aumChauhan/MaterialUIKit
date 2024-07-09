//
// MaterialLabels.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 30/12/23
//

import SwiftUI

// MARK: - MUINavigationLabel

/// A Material UI styled navigation link label.
public struct MUINavigationLabel: View {
    
    // MARK: - Properties
    
    private let systemName: String
    private let title: String
    
    // MARK: - Initializers
    
    /// Creates a navigation link label with the specified system image and title.
    ///
    /// - Parameters:
    ///   - systemName: The system image name for the icon.
    ///   - title: The title for the label.
    public init(systemName: String, _ title: String) {
        self.systemName = systemName
        self.title = title
    }
    
    // MARK: - View Body
    
    public var body: some View {
        HStack(spacing: 10) {
            Image(systemName: systemName)
                .font(.subheadline)
                .elevatedStyledBackground()
                .frame(width: 35, height: 35)
                .cornerRadius(50)
            
            Text(title)
                .font(.headline)
                .fontWeightWithFallback(.regular)
                .foregroundStyle(.materialPrimaryTitle)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundStyle(.materialSecondaryTitle)
        }
    }
}

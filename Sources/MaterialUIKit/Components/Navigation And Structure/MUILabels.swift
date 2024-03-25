//
// MUILabels.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 30/12/23
//

import SwiftUI

// MARK: - MUINavLinkLabel

/// A SwiftUI view that represents a navigation link label in Material-UI style.
@available(iOS 15.0, *)
public struct MUINavLinkLabel: View {
    
    // MARK: - Properties
    
    private let systemImage: String
    private let title: String
    
    // MARK: - Initializers
    
    /// Creates a navigation link label with the specified system image and title.
    /// - Parameters:
    ///   - systemImage: The system image name for the icon.
    ///   - title: The title for the label.
    public init(systemImage: String, _ title: String) {
        self.systemImage = systemImage
        self.title = title
    }
    
    // MARK: - View Body
    
    public var body: some View {
        HStack(spacing: 10) {
            // System image
            Image(systemName: systemImage)
                .font(.subheadline)
                .elevatedButtonStyle()
                .frame(width: 35, height: 35)
                .cornerRadius(50)
            
            // Label title
            Text(title)
                .font(.headline)
                .fontWeightWithFallback(.regular)
                .foregroundStyle(MaterialUIKit.tint.primaryTitle())
            
            Spacer()
            
            // Navigation arrow
            Image(systemName: "chevron.right")
                .foregroundStyle(MaterialUIKit.tint.secondaryTitle())
        }
    }
}

// TODO: MUILabel


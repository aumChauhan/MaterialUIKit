//
// NavigationContainerLabel.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 30/12/23
//

import SwiftUI

/// A Material UI style navigation container link label.
public struct NavigationContainerLabel: View {
    
    // MARK: - PROPERTIES

    private let systemImage: String
    private let titleKey: String
    
    // MARK: - INITIALIZERS
    
    /// Creates a navigation container link label with the specified system image and title.
    ///
    /// - Parameters:
    ///   - systemImage: The system image name for the icon.
    ///   - titleKey: The title for the label.
    public init(systemImage: String, _ titleKey: String) {
        self.systemImage = systemImage
        self.titleKey = titleKey
    }
    
    // MARK: - VIEW BODY

    public var body: some View {
        HStack(spacing: MaterialUIKit.configuration.horizontalStackSpacing) {
            Image(systemName: systemImage)
                .font(.subheadline)
                .elevatedStyledBackground()
                .frame(width: 35, height: 35)
                .cornerRadius(50)
            
            Text(titleKey)
                .font(MaterialUIKit.configuration.h4)
                .fontWeightWithFallback(.regular)
                .foregroundStyle(.materialUIPrimaryTitle)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundStyle(.materialUISecondaryTitle)
        }
    }
}

//
// NavigationContainerLabel.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 30/12/23
//

import SwiftUI

/// Represents a Material UI styled label for navigation routes, used to display route names in a navigation container.
@available(iOS 15.0, *)
public struct NavigationRouteLabel: View {
    
    // MARK: - PROPERTIES

    private let systemImage: String
    private let titleKey: String
    
    // MARK: - INITIALIZERS
    
    /// Creates a `NavigationRouteLabel` instance with the specified system image and title.
    ///
    /// - Parameters:
    ///   - systemImage: The name of the system image to be used as the label's icon.
    ///   - titleKey: The key for the title text to be displayed.
    public init(systemImage: String, _ titleKey: String) {
        self.systemImage = systemImage
        self.titleKey = titleKey
    }
    
    // MARK: - VIEW BODY

    public var body: some View {
        HStack(spacing: MaterialUIKit.configuration.horizontalStackSpacing) {
            Image(systemName: systemImage)
                .font(.subheadline)
                .padding(10)
                .foregroundStyle(.materialUIHighlight)
                .background(.materialUITertiaryBackground)
                .clipShape(Circle())
            
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

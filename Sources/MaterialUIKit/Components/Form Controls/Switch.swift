//
// Switch.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 30/12/23
//

import SwiftUI

/// Represents a Material UI styled switch for toggling boolean states.
@available(iOS 15.0, *)
public struct Switch: View {
    
    // MARK: - PROPERTIES
    
    private let titleKey: String
    @Binding private var isOn: Bool
    
    // MARK: - INITIALIZERS
    
    /// Creates a Material UI style switch.
    ///
    /// - Parameters:
    ///   - titleKey: The title key of the switch.
    ///   - isOn: A binding to a boolean value that determines the on/off state of the switch.
    public init(_ titleKey: String, isOn: Binding<Bool>) {
        self.titleKey = titleKey
        self._isOn = isOn
    }
    
    // MARK: - VIEW BODY
    
    public var body: some View {
        Toggle(titleKey, isOn: $isOn)
            .font(MaterialUIKit.configuration.h4)
            .foregroundStyle(.materialUIPrimaryTitle)
            .labelsHidden()
            .toggleStyle(SwitchStyle())
    }
}

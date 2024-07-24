//
// Checkbox.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 30/12/23
//

import SwiftUI

/// A Material UI style checkbox.
public struct Checkbox: View {
    
    // MARK: - PROPERTIES
    
    private let titleKey: String
    @Binding private var isOn: Bool
    
    // MARK: - INITIALIZERS
    
    /// Creates a Material UI style checkbox.
    ///
    /// - Parameters:
    ///   - titleKey: The title displayed next to the checkbox.
    ///   - isOn: Binding to control the checkbox's state (checked or unchecked).
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
            .toggleStyle(MUICheckboxStyle())
    }
}

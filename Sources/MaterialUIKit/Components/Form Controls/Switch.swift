//
// Switch.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 30/12/23
//

import SwiftUI

/// A Material UI style switch.
public struct Switch: View {
    
    // MARK: - Properties
    
    private let title: String
    @Binding private var isOn: Bool
    
    // MARK: - Initializers
    
    /// Creates a Material UI style switch.
    ///
    /// - Parameters:
    ///   - title: The title of the switch.
    ///   - isOn: A binding to a boolean value that determines the on/off state of the switch.
    public init(_ title: String, isOn: Binding<Bool>) {
        self.title = title
        self._isOn = isOn
    }
    
    // MARK: - View Body
    
    public var body: some View {
        Toggle(title, isOn: $isOn)
            .font(MaterialUIKit.configuration.h4)
            .foregroundStyle(.materialUIPrimaryTitle)
            .labelsHidden()
            .toggleStyle(MUISwitchStyle())
    }
}

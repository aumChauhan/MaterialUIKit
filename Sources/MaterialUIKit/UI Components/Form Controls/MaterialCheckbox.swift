//
// MaterialCheckbox.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 30/12/23
//

import SwiftUI

/// A MaterialUI styled checkbox.
public struct MaterialCheckbox: View {
    
    // MARK: - Properties
    
    private let titleKey: String
    @Binding private var isOn: Bool
    
    // MARK: - Initializers
    
    /// Creates a Material UI styled checkbox.
    ///
    /// - Parameters:
    ///   - titleKey: The title displayed next to the checkbox.
    ///   - isOn: Binding to control the checkbox's state (checked or unchecked).
    public init(_ titleKey: String, isOn: Binding<Bool>) {
        self.titleKey = titleKey
        self._isOn = isOn
    }
    
    // MARK: - View Body
    
    public var body: some View {
        Toggle(titleKey, isOn: $isOn)
            .foregroundStyle(.muiPrimaryTitle)
            .labelsHidden()
            .toggleStyle(MaterialCheckboxStyle())
    }
}

// MARK: - MaterialCheckboxStyle

/// Visual representation of the Material design styled checkbox.
private struct MaterialCheckboxStyle: ToggleStyle {
    
    // MARK: - Body
    
    internal func makeBody(configuration: Configuration) -> some View {
        HStack(alignment: .center) {
            configuration.label
            
            Spacer()
            
            Image(systemName: configuration.isOn ? "checkmark.square.fill" : "square")
                .font(.title2)
                .foregroundStyle(configuration.isOn ? .muiAccent : .materialSecondaryTitle)
                .onTapGesture {
                    withAnimation(.bouncy) {
                        configuration.isOn.toggle()
                    }
                }
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 3)
    }
}

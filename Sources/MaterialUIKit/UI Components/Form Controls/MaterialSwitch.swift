//
// MaterialSwitch.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 30/12/23
//

import SwiftUI

/// A Material UI styled switch.
public struct MaterialSwitch: View {
    
    // MARK: - Properties
    
    private let title: String
    @Binding private var isOn: Bool
    
    // MARK: - Initializers
    
    /// Creates a MaterialUI styled switch.
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
            .foregroundStyle(.muiPrimaryTitle)
            .labelsHidden()
            .toggleStyle(MaterialSwitchToggleStyle())
    }
}

// MARK: - MaterialSwitchToggleStyle

/// Visual representation of the Material Design styled toggle switch.
@available(iOS 15.0, *)
private struct MaterialSwitchToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack(alignment: .center) {
            configuration.label
            
            Spacer()
            
            RoundedRectangle(cornerRadius: 20)
                .foregroundStyle(configuration.isOn ? .muiAccent : .muiPrimaryBackground)
                .frame(width: 45, height: 25)
                .overlay(alignment: configuration.isOn ? .trailing : .leading) { // Switch key
                    Circle()
                        .frame(width: 20)
                        .foregroundStyle(configuration.isOn ? .muiTonal : .muiSecondaryTitle)
                        .padding(.horizontal, 3)
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 99)
                        .stroke(.muiSecondaryTitle, lineWidth: 1.5)
                        .frame(maxWidth: .infinity)
                )
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


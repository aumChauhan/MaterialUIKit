//
// MUICheckbox.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 30/12/23
//

import SwiftUI

// MARK: - MUICheckbox

/// A SwiftUI view representing a MaterialUI style checkbox.
@available(iOS 15.0, *)
public struct MUICheckbox: View {
    
    // MARK: - Properties
    
    private let title: String
    @Binding private var isOn: Bool
    
    // MARK: - Initializers
    
    /// Creates a MaterialUI style checkbox.
    /// - Parameters:
    ///   - title: The title of the switch.
    ///   - isOn: A binding to a boolean value that determines the on/off state of the checkbox.
    public init(_ title: String, isOn: Binding<Bool>) {
        self.title = title
        self._isOn = isOn
    }
    
    // MARK: - View BOdy
    
    public var body: some View {
        Toggle(title, isOn: $isOn)
            .foregroundStyle(.muiPrimaryTitle)
            .labelsHidden()
            .toggleStyle(MUICheckboxStyle())
    }
}

// MARK: - MUICheckboxStyle

/// A custom toggle style for the MUICheckbox.
@available(iOS 15.0, *)
private struct MUICheckboxStyle: ToggleStyle {
    
    // MARK: - Body
    
    internal func makeBody(configuration: Configuration) -> some View {
        HStack(alignment: .center) {
            configuration.label
            
            Spacer()
            
            Image(systemName: configuration.isOn ? "checkmark.square.fill" : "square")
                .font(.title2)
                .foregroundStyle(configuration.isOn ? .muiAccent : .muiSecondaryTitle)
                .onTapGesture { // Toggle checkbox action
                    withAnimation(.bouncy) {
                        configuration.isOn.toggle()
                    }
                }
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 3)
    }
}

/// A view modifier to apply a tint color.
@available(iOS 15.0, *)
private struct TintColorModifier: ViewModifier {
    
    // MARK: - Properties
    
    internal let tintColor: Color
    
    // MARK: - Body
    
    func body(content: Content) -> some View {
        content
            .accentColor(tintColor)
    }
}

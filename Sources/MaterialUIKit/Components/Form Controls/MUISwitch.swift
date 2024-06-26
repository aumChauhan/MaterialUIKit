//
// MUISwitch.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 30/12/23
//

import SwiftUI

// MARK: - MUISwitchToggleStyle

/// A custom toggle style for the MUISwitch.
@available(iOS 15.0, *)
private struct MUISwitchToggleStyle: ToggleStyle {
    
    // MARK: - Body
    
    public func makeBody(configuration: Configuration) -> some View {
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
                    // Outline stroke
                    RoundedRectangle(cornerRadius: 99)
                        .stroke(.muiSecondaryTitle, lineWidth: 1.5)
                        .frame(maxWidth: .infinity)
                )
                .onTapGesture {
                    // Toggle Action
                    withAnimation(.bouncy) {
                        configuration.isOn.toggle()
                    }
                }
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 3)
    }
}

// MARK: - MUISwitch

/// A SwiftUI view representing a MaterialUI style switch.
@available(iOS 15.0, *)
public struct MUISwitch: View {
    
    // MARK: - Properties
    
    private let title: String
    @Binding private var isOn: Bool
    
    // MARK: - Initializers
    
    /// Creates a MaterialUI style switch.
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
            .toggleStyle(MUISwitchToggleStyle())
    }
}

// MARK: - View Extension

/// An extension to customize the tint color of the MUISwitch.
@available(iOS 15.0, *)
extension View {
    func tint(_ color: Color) -> some View {
        self.modifier(TintColorModifier(tintColor: color))
    }
}

// MARK: - TintColorModifier

/// A view modifier to apply a tint color.
@available(iOS 15.0, *)
private struct TintColorModifier: ViewModifier {
    public let tintColor: Color
    
    func body(content: Content) -> some View {
        content
            .accentColor(tintColor)
    }
}

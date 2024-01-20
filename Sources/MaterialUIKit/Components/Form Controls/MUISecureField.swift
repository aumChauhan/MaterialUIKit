//
// MUISecureField.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 30/12/23
//

import SwiftUI

// MARK: - MUISecureField

/// A SwiftUI view representing a MaterialUI style secure field.
@available(iOS 15.0, *)
public struct MUISecureField: View {
    
    // MARK: - Properties
    
    @Binding public var text: String
    public let systemSymbol: String?
    public let titlekey: String
    public let background: Color?
    
    @FocusState private var isFocused: Bool
    @State private var secureFieldIsFocused: Bool = false
    
    // MARK: - Initializers
    
    /// Creates a Material UI style secure field.
    ///
    /// - Parameters:
    ///   - titleKey: Title key for the secure field.
    ///   - text: Binding to the text value of the secure field.
    public init(_ titlekey: String, text: Binding<String>) {
        self.titlekey = titlekey
        self._text = text
        self.systemSymbol = nil
        self.background = nil
    }
    
    /// Creates a MaterialUI style secure field with a system symbol.
    ///
    /// - Parameters:
    ///   - systemSymbol: System symbol for the secure field.
    ///   - titleKey: Title key for the secure field.
    ///   - text: Binding to the text value of the secure field.
    public init(systemSymbol: String, _ titlekey: String, text: Binding<String>) {
        self.titlekey = titlekey
        self._text = text
        self.systemSymbol = systemSymbol
        self.background = nil
    }
    
    /// Creates a MaterialUI style secure field with a system symbol and custom background color.
    ///
    /// - Parameters:
    ///   - systemSymbol: System symbol for the secure field.
    ///   - titleKey: Title key for the secure field.
    ///   - text: Binding to the text value of the secure field.
    ///   - background: Custom background color for the secure field.
    public init(systemSymbol: String, _ titlekey: String, text: Binding<String>, _ background: Color) {
        self.titlekey = titlekey
        self._text = text
        self.systemSymbol = systemSymbol
        self.background = background
    }
    
    // MARK: - View Body
    
    public var body: some View {
        HStack(spacing: 0) {
            // System image
            if let systemSymbol {
                Image(systemName: systemSymbol)
                    .font(.callout)
                    .foregroundColor(secureFieldIsFocused ? MaterialUI.tint.accent() : MaterialUI.tint.secondaryTitle())
                    .padding(.leading, 15)
            }
            
            // SwiftUI's default securefield.
            SecureField("", text: $text)
                .tint(MaterialUI.tint.accent())
                .padding()
            
            Spacer()
            
            // Clear securefield button
            if !(text.isEmpty) {
                Button {
                    text = ""
                } label:  {
                    Image(systemName: "xmark.circle")
                        .foregroundColor(MaterialUI.tint.secondaryTitle())
                        .padding(.trailing, 14)
                }
            }
        }
        .background(
            // Creates outline around secureField on focus state
            RoundedRectangle(cornerRadius: 20)
                .stroke(secureFieldIsFocused ? MaterialUI.tint.accent() : MaterialUI.tint.secondaryTitle(), lineWidth: 2)
                .background(background ?? MaterialUI.tint.secondaryBackground().opacity(0.5))
                .cornerRadius(20)
        )
        
        // Placeholder text that shifts upward on focus state
        .overlay(alignment: .leading) {
            if (!secureFieldIsFocused && !text.isEmpty) {
                EmptyView()
            } else {
                Text(titlekey)
                    .font(secureFieldIsFocused ? .caption : .callout)
                    .foregroundColor(secureFieldIsFocused ? MaterialUI.tint.accent() : MaterialUI.tint.secondaryTitle())
                    .offset(x: secureFieldIsFocused ? (systemSymbol != nil ? -45 : 0) : 0)
                    .offset(y: secureFieldIsFocused ? -40 : 0)
                    .animation(.bouncy, value: 1)
                    .padding(.leading, systemSymbol != nil ? 50 : 15)
            }
        }
        .focused($isFocused)
        // Toggle focus state
        .onTapGesture {
            isFocused.toggle()
        }
        // To change `@FocusState` value with animation
        .onChangeWithFallback(of: isFocused) { oldValue, newValue in
            withAnimation(.bouncy) {
                secureFieldIsFocused = newValue
            }
        }
        // Safearea for placeholder during focusState
        .padding(.top, secureFieldIsFocused ? 15 : 0)
    }
}


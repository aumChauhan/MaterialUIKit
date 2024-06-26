//
// MUITextField.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 30/12/23
//

import SwiftUI

// MARK: - MUITextField

/// A SwiftUI view representing a MaterialUI style text field.
@available(iOS 15.0, *)
public struct MUITextField: View {
    
    // MARK: - Properties
    
    @Binding private var text: String
    private let systemSymbol: String?
    private let titlekey: String
    private let background: Color?
    
    @FocusState private var isFocused: Bool
    @State private var textFieldIsFocused: Bool = false
    
    // MARK: - Initializers
    
    /// Creates a Material UI style text field.
    ///
    /// - Parameters:
    ///   - titleKey: Title key for the text field.
    ///   - text: Binding to the text value of the text field.
    public init(_ titlekey: String, text: Binding<String>) {
        self.titlekey = titlekey
        self._text = text
        self.systemSymbol = nil
        self.background = nil
    }
    
    /// Creates a MaterialUI style text field with a system symbol.
    ///
    /// - Parameters:
    ///   - systemSymbol: System symbol for the text field.
    ///   - titleKey: Title key for the text field.
    ///   - text: Binding to the text value of the text field.
    public init(systemSymbol: String, _ titlekey: String, text: Binding<String>) {
        self.titlekey = titlekey
        self._text = text
        self.systemSymbol = systemSymbol
        self.background = nil
    }
    
    /// Creates a MaterialUI style text field with a system symbol and custom background color.
    ///
    /// - Parameters:
    ///   - systemSymbol: System symbol for the text field.
    ///   - titleKey: Title key for the text field.
    ///   - text: Binding to the text value of the text field.
    ///   - background: Custom background color for the text field.
    public init(systemSymbol: String, _ titlekey: String, text: Binding<String>, background: Color) {
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
                    .foregroundStyle(textFieldIsFocused ? .muiAccent : .muiSecondaryTitle)
                    .padding(.leading, 15)
            }
            
            // SwiftUI's default textfield
            TextField("", text: $text)
                .tint(.muiAccent)
                .padding(16)
            
            Spacer()
            
            // Clear textfield button
            if !text.isEmpty {
                Button {
                    text = ""
                } label:  {
                    Image(systemName: "xmark.circle")
                        .foregroundStyle(.muiSecondaryTitle)
                        .padding(.trailing, 14)
                }
            }
        }
        .background(
            // Creates outline around textfield on focus state
            RoundedRectangle(cornerRadius: 20)
                .stroke(textFieldIsFocused ? .muiAccent : .muiSecondaryTitle, lineWidth: 1)
                .background(background ?? .muiSecondaryBackground.opacity(0.5))
                .cornerRadius(20)
        )
        // Placeholder text that shifts upward on focus state.
        .overlay(alignment: .leading) {
            if (!textFieldIsFocused && !text.isEmpty) {
                EmptyView()
            } else {
                Text(titlekey)
                    .font(textFieldIsFocused ? .caption : .callout)
                    .foregroundStyle(textFieldIsFocused ? .muiAccent : .muiSecondaryTitle)
                    .offset(x: textFieldIsFocused ? (systemSymbol != nil ? -35 : 0) : 0)
                    .offset(y: textFieldIsFocused ? -40 : 0)
                    .animation(.bouncy, value: 1)
                    .padding(.leading, systemSymbol != nil ? 40 : 15)
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
                textFieldIsFocused = newValue
            }
        }
        // Safearea for placeholder during focusState
        .padding(.top, textFieldIsFocused ? 15 : 0)
    }
}

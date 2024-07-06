//
// MaterialTextField.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 30/12/23
//

import SwiftUI

/// A Material UI styled text field.
public struct MaterialTextField: View {
    
    // MARK: - Properties
    
    @Binding private var text: String
    private let systemName: String?
    private let titlekey: String
    private let background: Color?
    
    @FocusState private var isFocused: Bool
    @State private var textFieldIsFocused: Bool = false
    
    // MARK: - Initializers
    
    /// Creates a default text field.
    ///
    /// - Parameters:
    ///   - titleKey: Title key for the text field.
    ///   - text: Binding to the text value of the text field.
    public init(_ titlekey: String, text: Binding<String>) {
        self.titlekey = titlekey
        self._text = text
        self.systemName = nil
        self.background = nil
    }
    
    /// Creates a text field with a system symbol.
    ///
    /// - Parameters:
    ///   - systemName: System (SF)symbol for the text field.
    ///   - titleKey: Title key for the text field.
    ///   - text: Binding to the text value of the text field.
    public init(systemName: String, _ titlekey: String, text: Binding<String>) {
        self.titlekey = titlekey
        self._text = text
        self.systemName = systemName
        self.background = nil
    }
    
    /// Creates a text field with a system symbol and custom background color.
    ///
    /// - Parameters:
    ///   - systemName: System (SF)symbol for the text field.
    ///   - titleKey: Title key for the text field.
    ///   - text: Binding to the text value of the text field.
    ///   - background: Custom background color for the text field.
    public init(systemName: String, _ titlekey: String, text: Binding<String>, background: Color) {
        self.titlekey = titlekey
        self._text = text
        self.systemName = systemName
        self.background = background
    }
    
    // MARK: - View Body
    
    public var body: some View {
        HStack(spacing: 0) {
            if let systemName {
                Image(systemName: systemName)
                    .font(.callout)
                    .foregroundStyle(textFieldIsFocused ? .muiAccent : .muiSecondaryTitle)
                    .padding(.leading, 15)
            }
            
            TextField("", text: $text)
                .tint(.muiAccent)
                .padding(16)
            
            Spacer()
            
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
            RoundedRectangle(cornerRadius: 20)
                .stroke(textFieldIsFocused ? .muiAccent : .muiSecondaryTitle, lineWidth: 1)
                .background(background ?? .muiSecondaryBackground.opacity(0.5))
                .cornerRadius(20)
        )

        .overlay(alignment: .leading) {
            if (!textFieldIsFocused && !text.isEmpty) {
                EmptyView()
            } else {
                Text(titlekey)
                    .font(textFieldIsFocused ? .caption : .callout)
                    .foregroundStyle(textFieldIsFocused ? .muiAccent : .muiSecondaryTitle)
                    .offset(x: textFieldIsFocused ? (systemName != nil ? -35 : 0) : 0)
                    .offset(y: textFieldIsFocused ? -40 : 0)
                    .animation(.bouncy, value: 1)
                    .padding(.leading, systemName != nil ? 40 : 15)
            }
        }
        .focused($isFocused)
        .onTapGesture {
            isFocused.toggle()
        }
        .onChangeWithFallback(of: isFocused) { oldValue, newValue in
            withAnimation(.bouncy) {
                textFieldIsFocused = newValue
            }
        }
        .padding(.top, textFieldIsFocused ? 15 : 0)
    }
}

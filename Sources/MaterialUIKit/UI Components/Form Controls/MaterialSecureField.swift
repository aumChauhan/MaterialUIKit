//
// MaterialSecureField.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 30/12/23
//

import SwiftUI

/// A Material UI style secure field.
public struct MaterialSecureField: View {
    
    // MARK: - Properties
    
    @Binding private var text: String
    private let systemName: String?
    private let titlekey: String
    private let background: Color?
    
    @FocusState private var isFocused: Bool
    @State private var secureFieldIsFocused: Bool = false
    
    // MARK: - Initializers
    
    /// Creates a default secure field.
    ///
    /// - Parameters:
    ///   - titleKey: Title key for the secure field.
    ///   - text: Binding to the text value of the secure field.
    public init(_ titlekey: String, text: Binding<String>) {
        self.titlekey = titlekey
        self._text = text
        self.systemName = nil
        self.background = nil
    }
    
    /// Creates a secure field with a system symbol.
    ///
    /// - Parameters:
    ///   - systemName: System (SF)symbol for the secure field.
    ///   - titleKey: Title key for the secure field.
    ///   - text: Binding to the text value of the secure field.
    public init(systemName: String, _ titlekey: String, text: Binding<String>) {
        self.titlekey = titlekey
        self._text = text
        self.systemName = systemName
        self.background = nil
    }
    
    /// Creates a secure field with a system symbol and custom background color.
    ///
    /// - Parameters:
    ///   - systemName: System (SF)symbol for the secure field.
    ///   - titleKey: Title key for the secure field.
    ///   - text: Binding to the text value of the secure field.
    ///   - background: Custom background color for the secure field.
    public init(systemName: String, _ titlekey: String, text: Binding<String>, _ background: Color) {
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
                    .foregroundStyle(secureFieldIsFocused ? .materialAccent : .materialSecondaryTitle)
                    .padding(.leading, 15)
            }
            
            SecureField("", text: $text)
                .tint(.materialAccent)
                .padding(16)
            
            Spacer()
            
            if !(text.isEmpty) {
                Button {
                    text = ""
                } label:  {
                    Image(systemName: "xmark.circle")
                        .foregroundStyle(.materialSecondaryTitle)
                        .padding(.trailing, 14)
                }
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 20)
                .stroke(secureFieldIsFocused ? .materialAccent : .materialSecondaryTitle, lineWidth: 1)
                .background(background ?? .materialSecondaryBackground.opacity(0.5))
                .cornerRadius(20)
        )
        
        // Placeholder text that shifts upward on focus state
        .overlay(alignment: .leading) {
            if (!secureFieldIsFocused && !text.isEmpty) {
                EmptyView()
            } else {
                Text(titlekey)
                    .font(secureFieldIsFocused ? .caption : .callout)
                    .foregroundStyle(secureFieldIsFocused ? .materialAccent : .materialSecondaryTitle)
                    .offset(x: secureFieldIsFocused ? (systemName != nil ? -35 : 0) : 0)
                    .offset(y: secureFieldIsFocused ? -40 : 0)
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
                secureFieldIsFocused = newValue
            }
        }
        // Safearea for placeholder during focusState
        .padding(.top, secureFieldIsFocused ? 15 : 0)
    }
}

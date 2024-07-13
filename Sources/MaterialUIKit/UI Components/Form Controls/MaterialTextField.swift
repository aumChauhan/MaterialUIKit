//
// MaterialTextField.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 30/12/23
//

import SwiftUI

/// A Material UI style text field.
public struct MaterialTextField: View {
    
    // MARK: - Properties
    
    @Binding private var text: String
    private let systemName: String?
    private let titlekey: String
    private let background: Color?
    
    @FocusState private var isFocused: Bool
    @State private var textFieldIsFocused: Bool = false
    @Environment(\.textFieldcornerRadius) private var cornerRadius: CGFloat

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
        HStack(spacing: MaterialUIKit.configuration.horizontalPadding) {
            if let systemName {
                Image(systemName: systemName)
                    .font(.callout)
                    .foregroundStyle(textFieldIsFocused ? .materialAccent : .materialSecondaryTitle)
                    .padding(.leading, MaterialUIKit.configuration.horizontalPadding)
            }
            
            TextField(titlekey, text: $text)
                .tint(.materialAccent)
                .padding(.vertical, MaterialUIKit.configuration.verticalPadding)
                .padding(.horizontal, systemName != nil ? 0 : MaterialUIKit.configuration.horizontalPadding)
            
            Spacer()
            
            if !text.isEmpty {
                Button {
                    text = ""
                } label:  {
                    Image(systemName: "xmark.circle")
                        .foregroundStyle(.materialSecondaryTitle)
                        .padding(.trailing, MaterialUIKit.configuration.horizontalPadding)
                }
            }
        }
        .background(background ?? .materialSecondaryBackground)
        .cornerRadius(cornerRadius)
        .padding(MaterialUIKit.configuration.borderWidth)
        .background(textFieldIsFocused ? .materialAccent : .materialSecondaryTitle.opacity(0.5))
        .cornerRadius(cornerRadius)
        .focused($isFocused)
        .onTapGesture {
            isFocused.toggle()
        }
        .onChangeWithFallback(of: isFocused) { oldValue, newValue in
            withAnimation(.bouncy) {
                textFieldIsFocused = newValue
            }
        }
    }
}

// MARK: - Environment Keys

/// Environment key for setting the corner radius.
fileprivate struct CornerRadiusKey: EnvironmentKey {
    static var defaultValue: CGFloat = 16
}

fileprivate extension EnvironmentValues {
    var textFieldcornerRadius: CGFloat {
        get { self[CornerRadiusKey.self] }
        set { self[CornerRadiusKey.self] = newValue }
    }
}

// MARK: - Extension View

extension View {
    
    /// Sets the corner radius for the text field.
    ///
    /// - Parameter radius: The corner radius to be applied to the text field.
    ///
    /// - Returns: A view modified to include the specified corner radius.
    public func textFieldCornerRadius(_ radius: CGFloat) -> some View {
        self.environment(\.textFieldcornerRadius, radius)
    }
}

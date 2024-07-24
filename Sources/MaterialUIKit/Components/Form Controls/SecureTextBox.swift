//
// SecureTextBox.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 30/12/23
//

import SwiftUI

/// A Material UI style secure text field.
public struct SecureTextBox: View {
    
    // MARK: - PROPERTIES
    
    @Binding private var text: String
    private let systemImage: String?
    private let titlekey: String
    private let background: Color?
    
    @FocusState private var isFocused: Bool
    @State private var secureFieldIsFocused: Bool = false
    @Environment(\.cornerRadius) private var cornerRadius: CGFloat
    
    // MARK: - INITIALIZERS
    
    /// Creates a default secure text box.
    ///
    /// - Parameters:
    ///   - titleKey: Title key for the secure text box.
    ///   - text: Binding to the text value of the secure field.
    public init(_ titlekey: String, text: Binding<String>) {
        self.titlekey = titlekey
        self._text = text
        self.systemImage = nil
        self.background = nil
    }
    
    /// Creates a secure text box with a system symbol.
    ///
    /// - Parameters:
    ///   - systemImage: System symbol for the secure field.
    ///   - titleKey: Title key for the secure field.
    ///   - text: Binding to the text value of the secure field.
    public init(systemImage: String, _ titlekey: String, text: Binding<String>) {
        self.titlekey = titlekey
        self._text = text
        self.systemImage = systemImage
        self.background = nil
    }
    
    /// Creates a MaterialUI style secure field with a system symbol and custom background color.
    ///
    /// - Parameters:
    ///   - systemImage: System symbol for the secure field.
    ///   - titleKey: Title key for the secure field.
    ///   - text: Binding to the text value of the secure field.
    ///   - background: Custom background color for the secure field.
    public init(systemImage: String, _ titlekey: String, text: Binding<String>, background: Color) {
        self.titlekey = titlekey
        self._text = text
        self.systemImage = systemImage
        self.background = background
    }
    
    
    // MARK: - VIEW BODY
    
    public var body: some View {
        HStack(spacing: MaterialUIKit.configuration.horizontalStackSpacing) {
            if let systemImage {
                Image(systemName: systemImage)
                    .font(.callout)
                    .foregroundStyle(secureFieldIsFocused ? .materialUIAccent : .materialUIOnDisabled)
                    .padding(.leading, MaterialUIKit.configuration.horizontalPadding)
            }
            
            SecureField(titlekey, text: $text)
                .font(MaterialUIKit.configuration.h4)
                .tint(.materialUIAccent)
                .padding(.vertical, MaterialUIKit.configuration.verticalPadding)
                .padding(.horizontal, systemImage != nil ? 0 : MaterialUIKit.configuration.horizontalPadding)
            
            if !(text.isEmpty) {
                Button {
                    text = ""
                    hapticFeedback()
                } label:  {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(.materialUISecondaryTitle)
                        .padding(.trailing, MaterialUIKit.configuration.horizontalPadding)
                }
            }
        }
        .background(background ?? .materialUISecondaryBackground)
        .cornerRadius(cornerRadius)
        .stroke(background: secureFieldIsFocused ? .materialUIAccent : .materialUIOnDisabled, cornerRadius: cornerRadius)
        .focused($isFocused)
        .onTapGesture {
            isFocused.toggle()
            hapticFeedback()
        }
        .onChangeWithFallback(of: isFocused) { oldValue, newValue in
            withMaterialAnimation {
                secureFieldIsFocused = newValue
            }
        }
    }
}

extension View {
    
    /// Sets the corner radius for the secure field.
    ///
    /// - Parameter radius: The corner radius to be applied to the secure field.
    ///
    /// - Returns: A view modified to include the specified corner radius.
    public func secureTextBoxCornerRadius(_ radius: CGFloat) -> some View {
        self.environment(\.cornerRadius, radius)
    }
}

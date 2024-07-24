//
// TextBox.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 30/12/23
//

import SwiftUI

/// A Material UI style text field.
public struct TextBox: View {
    
    // MARK: - PROPERTIES
    
    @Binding private var text: String
    private let systemImage: String?
    private let titlekey: String
    private let background: Color?
    
    @FocusState private var isFocused: Bool
    @State private var textFieldIsFocused: Bool = false
    @Environment(\.cornerRadius) private var cornerRadius: CGFloat
    
    // MARK: - INITIALIZERS
    
    /// Creates a default text box.
    ///
    /// - Parameters:
    ///   - titleKey: Title key for the text field.
    ///   - text: Binding to the text value of the text field.
    public init(_ titlekey: String, text: Binding<String>) {
        self.titlekey = titlekey
        self._text = text
        self.systemImage = nil
        self.background = nil
    }
    
    /// Creates a text box with a system symbol.
    ///
    /// - Parameters:
    ///   - systemImage: System symbol for the text field.
    ///   - titleKey: Title key for the text field.
    ///   - text: Binding to the text value of the text field.
    public init(systemImage: String, _ titlekey: String, text: Binding<String>) {
        self.titlekey = titlekey
        self._text = text
        self.systemImage = systemImage
        self.background = nil
    }
    
    /// Creates a MaterialUI style text box with a system symbol and custom background color.
    ///
    /// - Parameters:
    ///   - systemImage: System symbol for the text box.
    ///   - titleKey: Title key for the text box.
    ///   - text: Binding to the text value of the text box.
    ///   - background: Custom background color for the text box.
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
                    .foregroundStyle(textFieldIsFocused ? .materialUIAccent : .materialUIOnDisabled)
                    .padding(.leading, MaterialUIKit.configuration.horizontalPadding)
            }
            
            TextField(titlekey, text: $text)
                .font(MaterialUIKit.configuration.h4)
                .tint(.materialUIAccent)
                .padding(.vertical, MaterialUIKit.configuration.verticalPadding)
                .padding(.horizontal, systemImage != nil ? 0 : MaterialUIKit.configuration.horizontalPadding)
            
            if !text.isEmpty {
                Button {
                    text = ""
                } label:  {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(.materialUISecondaryTitle)
                        .padding(.trailing, MaterialUIKit.configuration.horizontalPadding)
                }
            }
        }
        .background(background ?? .materialUISecondaryBackground)
        .cornerRadius(cornerRadius)
        .stroke(background: textFieldIsFocused ? .materialUIAccent : .materialUIOnDisabled, cornerRadius: cornerRadius)
        .focused($isFocused)
        .onTapGesture {
            isFocused.toggle()
        }
        .onChangeWithFallback(of: isFocused) { oldValue, newValue in
            withMaterialAnimation {
                textFieldIsFocused = newValue
            }
        }
    }
}

extension View {
    
    /// Sets the corner radius for the text field.
    ///
    /// - Parameter radius: The corner radius to be applied to the text field.
    ///
    /// - Returns: A view modified to include the specified corner radius.
    public func textBoxCornerRadius(_ radius: CGFloat) -> some View {
        self.environment(\.cornerRadius, radius)
    }
}

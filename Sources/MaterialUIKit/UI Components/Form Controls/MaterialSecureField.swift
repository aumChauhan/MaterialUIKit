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
    
    @FocusState private var isFocused: Bool
    @State private var secureFieldIsFocused: Bool = false
    @Environment(\.cornerRadius) private var cornerRadius: CGFloat

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
    }
    
    // MARK: - View Body
    
    public var body: some View {
        HStack(spacing: MaterialUIKit.configuration.horizontalStackSpacing) {
            if let systemName {
                Image(systemName: systemName)
                    .font(.callout)
                    .foregroundStyle(secureFieldIsFocused ? .materialAccent : .materialOnDisabled)
                    .padding(.leading, MaterialUIKit.configuration.horizontalPadding)
            }
            
            SecureField(titlekey, text: $text)
                .font(MaterialUIKit.configuration.h4)
                .tint(.materialAccent)
                .padding(.vertical, MaterialUIKit.configuration.verticalPadding)
                .padding(.horizontal, systemName != nil ? 0 : MaterialUIKit.configuration.horizontalPadding)
            
            Spacer()
            
            if !(text.isEmpty) {
                Button {
                    text = ""
                } label:  {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(.materialSecondaryTitle)
                        .padding(.trailing, MaterialUIKit.configuration.horizontalPadding)
                }
            }
        }
        .background(.materialSecondaryBackground)
        .cornerRadius(cornerRadius)
        .stroke(background: secureFieldIsFocused ? .materialAccent : .materialOnDisabled)
        .focused($isFocused)
        .onTapGesture {
            isFocused.toggle()
        }
        .onChangeWithFallback(of: isFocused) { oldValue, newValue in
            withMaterialAnimation {
                secureFieldIsFocused = newValue
            }
        }
    }
}

// MARK: - Environment Keys

/// Environment key for setting the corner radius.
fileprivate struct CornerRadiusKey: EnvironmentKey {
    static var defaultValue: CGFloat = MaterialUIKit.configuration.cornerRadius
}

fileprivate extension EnvironmentValues {
    var cornerRadius: CGFloat {
        get { self[CornerRadiusKey.self] }
        set { self[CornerRadiusKey.self] = newValue }
    }
}

// MARK: - Extension View

extension View {
    
    /// Sets the corner radius for the secure field.
    ///
    /// - Parameter radius: The corner radius to be applied to the secure field.
    ///
    /// - Returns: A view modified to include the specified corner radius.
    public func materialSecureFieldCornerRadius(_ radius: CGFloat) -> some View {
        self.environment(\.cornerRadius, radius)
    }
}

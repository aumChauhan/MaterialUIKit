//
// MUISearchBar.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 30/12/23
//

import SwiftUI

// MARK: - MUISearchBar

/// A Material UI styled search bar.
public struct MaterialSearchBar: View {
    
    // MARK: - Properties
    
    private let placeholder: String
    private let action: () -> Void
    @Binding private var searchText: String
    @State private var showSearchButton: Bool = false
    
    // MARK: - Initializers
    
    /// Creates a search bar with a default placeholder text.
    ///
    /// - Parameters:
    ///   - searchText: A binding to the text that the user enters into the search bar.
    ///   - action: A closure to execute when the user triggers the search action.
    public init(searchText: Binding<String>, _ action: @escaping () -> Void) {
        self.placeholder = "Search"
        self._searchText = searchText
        self.action = action
    }
    
    /// Creates a search bar with a custom placeholder text.
    ///
    /// - Parameters:
    ///   - placeholder: The placeholder text to display when the search bar is empty.
    ///   - searchText: A binding to the text that the user enters into the search bar.
    ///   - action: A closure to execute when the user triggers the search action.
    public init(_ placeholder: String, searchText: Binding<String>, _ action: @escaping () -> Void) {
        self.placeholder = placeholder
        self._searchText = searchText
        self.action = action
    }
    
    // MARK: - View Body
    
    public var body: some View {
        HStack {
            HStack(spacing: MaterialUIKit.configuration.horizontalPadding) {
                Image(systemName: "magnifyingglass")
                    .font(.headline)
                    .foregroundStyle(.materialSecondaryTitle)
                
                TextField(placeholder, text: $searchText)
                    .keyboardType(.webSearch)
                    .tint(.materialAccent)
                
                Spacer()
                
                if !(searchText.isEmpty) {
                    Button {
                        withMaterialAnimation {
                            searchText = ""
                            showSearchButton = false
                        }
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(.materialSecondaryTitle)
                    }
                }
            }
            .padding(MaterialUIKit.configuration.verticalPadding)
            .background(.materialSecondaryBackground)
            .cornerRadius(.infinity)
            .padding(1)
            .background(.materialSecondaryTitle.opacity(0.5))
            .cornerRadius(.infinity)
            .tint(.materialAccent)
            
            if showSearchButton {
                Button("Search", action: action)
                    .foregroundStyle(.materialAccent)
                    .fontWeightWithFallback(.medium)
                    .buttonStyle(ShrinkFadeButtonStyle())
            }
        }
        .onChangeWithFallback(of: searchText) { oldValue, newValue in
            withMaterialAnimation {
                if !(newValue.isEmpty) {
                    showSearchButton = true
                }
            }
        }
    }
}

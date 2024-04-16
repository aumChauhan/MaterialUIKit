//
// MUISearchBar.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 30/12/23
//

import SwiftUI

// MARK: - MUISearchBar

/// A MaterialUI-style search bar with a customizable placeholder and search text binding.
@available(iOS 15.0, *)
public struct MUISearchBar: View {
    
    // MARK: - Properties
    
    private let placeholder: String
    private let action: () -> Void
    @Binding private var searchText: String
    @State private var showSearchButton: Bool = false
    
    // MARK: - Initializers
    
    /// Creates a MaterialUI-style search bar with a default placeholder text.
    ///
    ///  - Parameters:
    ///     - searchText: A binding to the text that the user enters into the search bar.
    ///     - action: A closure to execute when the user triggers the search action.
    public init(searchText: Binding<String>, _ action: @escaping () -> Void) {
        self.placeholder = "Search"
        self._searchText = searchText
        self.action = action
    }
    
    /// Creates a MaterialUI-style search bar with a custom placeholder text.
    ///
    ///  - Parameters:
    ///     - placeholder: The placeholder text to display when the search bar is empty.
    ///     - searchText: A binding to the text that the user enters into the search bar.
    ///     - action: A closure to execute when the user triggers the search action.
    public init(_ placeholder: String, searchText: Binding<String>, _ action: @escaping () -> Void) {
        self.placeholder = placeholder
        self._searchText = searchText
        self.action = action
    }
    
    // MARK: - View Body
    
    public var body: some View {
        HStack {
            // Search bar
            HStack(spacing: 10) {
                // Search icon
                Image(systemName: "magnifyingglass")
                    .font(.headline)
                    .foregroundStyle(.muiSecondaryTitle)
                
                // Search field
                TextField(placeholder, text: $searchText)
                    .keyboardType(.webSearch)
                    .tint(.muiAccent)
                
                Spacer()
                
                // Clear text & hide search action button
                if !(searchText.isEmpty) {
                    Button {
                        withAnimation {
                            searchText = ""
                            showSearchButton = false
                        }
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(.muiSecondaryTitle)
                    }
                }
            }
            // Searchfield backdrop
            .padding(12)
            .background(.muiSecondaryBackground)
            .cornerRadius(100)
            // Stroke
            .padding(1)
            .background(.muiSecondaryTitle.opacity(0.5))
            .cornerRadius(100)
            .tint(.muiAccent)
            
            // Search action
            if showSearchButton {
                Button("Search", action: action)
                    .foregroundStyle(.muiAccent)
                    .fontWeightWithFallback(.medium)
                    .buttonStyle(MUIButtonTapStyle())
            }
        }
        // Changes states of `showSearchButton` with animation
        .onChangeWithFallback(of: searchText) { oldValue, newValue in
            withAnimation {
                if !(newValue.isEmpty) {
                    showSearchButton = true
                }
            }
        }
    }
}

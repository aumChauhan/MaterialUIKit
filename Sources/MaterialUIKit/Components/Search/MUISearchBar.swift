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
@available(iOS 17.0, *)
public struct MUISearchBar: View {
    
    // MARK: - Properties
    
    public let placeholder: String
    public let action: () -> Void
    @Binding public var searchText: String
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
            HStack(spacing: 15) {
                // Search icon
                Image(systemName: "magnifyingglass")
                    .font(.title3)
                    .foregroundColor(MaterialUI.tint.secondaryTitle())
                
                // Search field
                TextField(placeholder, text: $searchText)
                    .keyboardType(.webSearch)
                    .tint(MaterialUI.tint.accent())
                
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
                            .foregroundColor(MaterialUI.tint.secondaryTitle())
                    }
                }
            }
            .padding(15)
            .background(MaterialUI.tint.secondaryBackground())
            .cornerRadius(99)
            .tint(MaterialUI.tint.accent())
            
            // Search action
            if showSearchButton {
                Button("Search", action: action)
                    .foregroundColor(MaterialUI.tint.accent())
                    .fontWeight(.medium)
                    .buttonStyle(MUIButtonTapStyle())
            }
        }
        // Changes states of `showSearchButton` with animation
        .onChange(of: searchText) { oldValue, newValue in
            withAnimation {
                if !(newValue.isEmpty) {
                    showSearchButton = true
                }
            }
        }
    }
}

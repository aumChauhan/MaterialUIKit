//
// SearchBox.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 30/12/23
//

import SwiftUI

/// A Material UI styled search box.
public struct SearchBox: View {
    
    // MARK: - PROPERTIES
    
    private let placeholder: String
    private let action: () -> Void
    @Binding private var searchText: String
    @State private var showSearchButton: Bool = false
    
    // MARK: - INITIALIZERS
    
    /// Creates a search box with a default placeholder text.
    ///
    /// - Parameters:
    ///   - searchText: A binding to the text that the user enters into the search bar.
    ///   - action: A closure to execute when the user triggers the search action.
    public init(searchText: Binding<String>, _ action: @escaping () -> Void) {
        self.placeholder = "Search"
        self._searchText = searchText
        self.action = action
    }
    
    /// Creates a search box with a custom placeholder text.
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
    
    // MARK: - VIEW BODY

    public var body: some View {
        HStack {
            HStack(spacing: MaterialUIKit.configuration.horizontalStackSpacing) {
                Image(systemName: "magnifyingglass")
                    .font(.headline)
                    .foregroundStyle(.materialUISecondaryTitle)
                
                TextField(placeholder, text: $searchText)
                    .keyboardType(.webSearch)
                    .tint(.materialUIAccent)
                
                Spacer()
                
                if !(searchText.isEmpty) {
                    Button {
                        withMaterialAnimation {
                            searchText = ""
                            showSearchButton = false
                        }
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(.materialUISecondaryTitle)
                    }
                }
            }
            .padding(.vertical, MaterialUIKit.configuration.verticalPadding)
            .padding(.horizontal, MaterialUIKit.configuration.horizontalPadding)
            .background(.materialUISecondaryBackground)
            .cornerRadius(.infinity)
            .stroke(cornerRadius: .infinity)
            .tint(.materialUIAccent)
            
            if showSearchButton {
                Button("Search", action: action)
                    .foregroundStyle(.materialUIAccent)
                    .fontWeightWithFallback(.medium)
                    .buttonStyle(MUIActionButtonAnimationStyle())
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

//
// MaterialList.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 30/12/23
//

import SwiftUI

// MARK: - MaterialListViewLayout

/// A `_Variadic­View.Tree` with a `MUIListViewLayout` and list styles.
fileprivate struct MaterialListViewLayout: _VariadicView_UnaryViewRoot {
    
    // MARK: - Properties
    
    var listStyle: MaterialListStyle
    
    // MARK: - Initializers
    
    public init(listStyle: MaterialListStyle) {
        self.listStyle = listStyle
    }
    
    // MARK: - Body
    
    @ViewBuilder
    public func body(children: _VariadicView.Children) -> some View {
        ScrollView {
            switch listStyle {
            case .plain:
                plainStyle(children: children)
                
            case .inset:
                insetStyle(children: children)
                
            case .insetGrouped:
                insetGroupedStyle(children: children)
            }
        }
    }
    
    // MARK: Helpers

    /// Returns a plain-style list with a vertical stack of content items.
    private func plainStyle(children: _VariadicView.Children) -> some View {
        
        let last = children.last?.id
        
        return VStack(spacing: 10) {
            ForEach(children) { child in
                child
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.headline)
                    .fontWeightWithFallback(.regular)
                    .foregroundStyle(.muiPrimaryTitle)
                
                if child.id != last {
                    MaterialDivider()
                }
            }
        }
    }
    
    /// Returns an inset-style list with rounded rectangles as background on individual list item.
    private func insetStyle(children: _VariadicView.Children) -> some View {
        return VStack(spacing: MaterialUIKitConstants.verticalContentPadding) {
            ForEach(children) { child in
                child
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.headline)
                    .fontWeightWithFallback(.regular)
                    .foregroundStyle(.muiPrimaryTitle)
                    .padding(16)
                    .background(.muiSecondaryBackground)
                    .cornerRadius(15)
            }
        }
    }
    
    /// Returns an inset-grouped-style list with rounded rectangles as background.
    private func insetGroupedStyle(children: _VariadicView.Children) -> some View {
        let last = children.last?.id
        
        return VStack(spacing: MaterialUIKitConstants.verticalContentPadding) {
            ForEach(children) { child in
                child
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.headline)
                    .fontWeightWithFallback(.regular)
                    .foregroundStyle(.muiPrimaryTitle)
                
                if child.id != last {
                    MaterialDivider()
                }
            }
        }
        .padding(20)
        .background(.muiSecondaryBackground)
        .cornerRadius(MaterialUIKitConstants.cornerRadius)
    }
}

// MARK: - MaterialList

/// A Material Design style list with different visual styles.
public struct MaterialList<Content>: View where Content: View {
    
    // MARK: - Properties
    
    private var content: Content
    private var listStyle: MaterialListStyle
    
    // MARK: - Initializers
    
    /// Creates a stylized list with a default insetGrouped style.
    ///
    /// - Parameters:
    ///   - content: A closure that returns the content view for a given element.
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
        self.listStyle = .insetGrouped
    }
    
    /// Creates a stylized list with a custom list style.
    ///
    /// - Parameters:
    ///   - listStyle: The style of the list, such as `.plain`, `.inset`, or `.insetGrouped`.
    ///   - content: A closure that returns the content view for a given element.
    public init(listStyle: MaterialListStyle, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.listStyle = listStyle
    }
    
    // MARK: - View Body
    
    public var body: some View {
        ScrollView(.vertical) {
            switch listStyle {
            case .plain:
                plainStyle()
                
            case .inset:
                insetStyle()
                
            case .insetGrouped:
                insetGroupedStyle()
            }
        }
    }
    
    // MARK: Helpers
    
    /// Returns a plain-style list with a vertical stack of content items.
    private func plainStyle() -> some View {
        _VariadicView.Tree(MaterialListViewLayout(listStyle: listStyle)) {
            content
        }
    }
    
    /// Returns an inset-style list with rounded rectangles as background on individual list item.
    private func insetStyle() -> some View {
        _VariadicView.Tree(MaterialListViewLayout(listStyle: listStyle)) {
            content
        }
    }
    
    /// Returns an inset-grouped-style list with rounded rectangles as background.
    private func insetGroupedStyle() -> some View {
        _VariadicView.Tree(MaterialListViewLayout(listStyle: listStyle)) {
            content
        }
    }
}

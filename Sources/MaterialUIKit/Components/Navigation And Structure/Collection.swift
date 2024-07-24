//
// Collection.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 30/12/23
//

import SwiftUI

// MARK: - CollectionViewLayout

/// A `_Variadic­View.Tree` with a `MUIListViewLayout` and list styles.
fileprivate struct CollectionViewLayout: _VariadicView_UnaryViewRoot {
    
    // MARK: - Properties
    
    var listStyle: MUICollectionStyle
    
    // MARK: - Initializers
    
    public init(listStyle: MUICollectionStyle) {
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
        
        return VStack(spacing: MaterialUIKit.configuration.verticalStackSpacing) {
            ForEach(children) { child in
                child
                    .font(MaterialUIKit.configuration.h4)
                    .fontWeightWithFallback(.regular)
                    .foregroundStyle(.materialUIPrimaryTitle)
                    .align(.leading)
                
                if child.id != last {
                    Separator()
                }
            }
        }
    }
    
    /// Returns an inset-style list with rounded rectangles as background on individual list item.
    private func insetStyle(children: _VariadicView.Children) -> some View {
        return VStack(spacing: MaterialUIKit.configuration.verticalStackSpacing) {
            ForEach(children) { child in
                child
                    .font(MaterialUIKit.configuration.h4)
                    .fontWeightWithFallback(.regular)
                    .foregroundStyle(.materialUIPrimaryTitle)
                    .align(.leading)
                    .secondaryBackground()
            }
        }
    }
    
    /// Returns an inset-grouped-style list with rounded rectangles as background.
    private func insetGroupedStyle(children: _VariadicView.Children) -> some View {
        let last = children.last?.id
        
        return VStack(spacing: MaterialUIKit.configuration.verticalStackSpacing) {
            ForEach(children) { child in
                child
                    .font(MaterialUIKit.configuration.h4)
                    .fontWeightWithFallback(.regular)
                    .foregroundStyle(.materialUIPrimaryTitle)
                    .align(.leading)
                
                if child.id != last {
                    Separator()
                }
            }
        }
        .secondaryBackground()
    }
}

// MARK: - Collection

/// A Material Design style collection (list) with different visual styles.
public struct Collection<Content>: View where Content: View {
    
    // MARK: - Properties
    
    private var content: Content
    private var listStyle: MUICollectionStyle
    
    // MARK: - Initializers
    
    /// Creates a stylized collection (list) with a default insetGrouped style.
    ///
    /// - Parameters:
    ///   - content: A closure that returns the content view for a given element.
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
        self.listStyle = .insetGrouped
    }
    
    /// Creates a stylized collection (list) with a custom list style.
    ///
    /// - Parameters:
    ///   - listStyle: The style of the list, such as `.plain`, `.inset`, or `.insetGrouped`.
    ///   - content: A closure that returns the content view for a given element.
    public init(listStyle: MUICollectionStyle, @ViewBuilder content: () -> Content) {
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
        _VariadicView.Tree(CollectionViewLayout(listStyle: listStyle)) {
            content
        }
    }
    
    /// Returns an inset-style list with rounded rectangles as background on individual list item.
    private func insetStyle() -> some View {
        _VariadicView.Tree(CollectionViewLayout(listStyle: listStyle)) {
            content
        }
    }
    
    /// Returns an inset-grouped-style list with rounded rectangles as background.
    private func insetGroupedStyle() -> some View {
        _VariadicView.Tree(CollectionViewLayout(listStyle: listStyle)) {
            content
        }
    }
}

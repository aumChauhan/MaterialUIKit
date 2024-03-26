//
// MUIList.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 30/12/23
//

import SwiftUI

// MARK: - MUIListStyle

/// Enum representing different styles for `MUIList`.
@frozen public enum MUIListStyle {
    /// A plain-style list with default spacing and divider lines.
    case plain
    
    /// An inset-style list with content padding and rounded corners.
    case inset
    
    /// An inset-grouped-style list with content padding and rounded corners, suitable for grouped content.
    case insetGrouped
}

// MARK: - MUIListViewLayout

/// A `_Variadic­View.Tree` with a `MUIListViewLayout` and list styles.
@available(iOS 15.0, *)
private struct MUIListViewLayout: _VariadicView_UnaryViewRoot {
    
    // MARK: - Properties
    
    public var listStyle: MUIListStyle
    
    // MARK: - Initializers
    
    public init(listStyle: MUIListStyle) {
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
}

// MARK: - Extension MIUList

@available(iOS 15.0, *)
extension MUIListViewLayout {
    
    /// Returns a plain-style list with a vertical stack of content items.
    private func plainStyle(children: _VariadicView.Children) -> some View {
        
        let last = children.last?.id
        
        return VStack(spacing: 10) {
            ForEach(children) { child in
                child
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.headline)
                    .fontWeightWithFallback(.regular)
                    .foregroundColor(MaterialUIKit.tint.primaryTitle())
                
                if child.id != last {
                    MUIDivider()
                }
            }
        }
    }
    
    /// Returns an inset-style list with rounded rectangles as background on individual list item.
    private func insetStyle(children: _VariadicView.Children) -> some View {
        return VStack(spacing: MUIConstants.verticalContentPadding) {
            ForEach(children) { child in
                child
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.headline)
                    .fontWeightWithFallback(.regular)
                    .foregroundColor(MaterialUIKit.tint.primaryTitle())
                    .padding(16)
                    .background(MaterialUIKit.tint.secondaryBackground())
                    .cornerRadius(15)
            }
        }
    }
    
    /// Returns an inset-grouped-style list with rounded rectangles as background.
    private func insetGroupedStyle(children: _VariadicView.Children) -> some View {
        let last = children.last?.id
        
        return VStack(spacing: MUIConstants.verticalContentPadding) {
            ForEach(children) { child in
                child
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.headline)
                    .fontWeightWithFallback(.regular)
                    .foregroundColor(MaterialUIKit.tint.primaryTitle())
                
                if child.id != last {
                    MUIDivider()
                }
            }
        }
        .padding(20)
        .background(MaterialUIKit.tint.secondaryBackground())
        .cornerRadius(MUIConstants.cornerRadius)
    }
}


// MARK: - MUIList

/// A MaterialUI style list with different visual styles.
@available(iOS 15.0, *)
public struct MUIList<Content>: View where Content: View {
    
    // MARK: - Properties
    
    public var content: Content
    public var listStyle: MUIListStyle
    
    // MARK: - Initializers
    
    /// Creates a stylized list with a default insetGrouped style.
    /// - Parameters:
    ///   - content: A closure that returns the content view for a given element.
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
        self.listStyle = .insetGrouped
    }
    
    /// Creates a stylized list with a custom list style.
    /// - Parameters:
    ///   - listStyle: The style of the list, such as `.plain`, `.inset`, or `.insetGrouped`.
    ///   - content: A closure that returns the content view for a given element.
    public init(listStyle: MUIListStyle, @ViewBuilder content: () -> Content) {
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
}


// MARK: - Extension MIUList
@available(iOS 15.0, *)
extension MUIList {
    
    /// Returns a plain-style list with a vertical stack of content items.
    private func plainStyle() -> some View {
        _VariadicView.Tree(MUIListViewLayout(listStyle: listStyle)) {
            content
        }
    }
    
    /// Returns an inset-style list with rounded rectangles as background on individual list item.
    private func insetStyle() -> some View {
        _VariadicView.Tree(MUIListViewLayout(listStyle: listStyle)) {
            content
        }
    }
    
    /// Returns an inset-grouped-style list with rounded rectangles as background.
    private func insetGroupedStyle() -> some View {
        _VariadicView.Tree(MUIListViewLayout(listStyle: listStyle)) {
            content
        }
    }
}

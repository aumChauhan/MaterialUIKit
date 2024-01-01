//
// MUIList.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit
//
// Author: Aum Chauhan
// Created On: 30/12/23
//

import SwiftUI

// MARK: - MUIListStyle

/// Enum representing different styles for `MUIList`.
@available(iOS 17.0, *)
public enum MUIListStyle {
    /// A plain-style list with default spacing and divider lines.
    case plain
    
    /// An inset-style list with content padding and rounded corners.
    case inset
    
    /// An inset-grouped-style list with content padding and rounded corners, suitable for grouped content.
    case insetGrouped
}

// MARK: - MUIList

/// A MaterialUI style list with different visual styles.
@available(iOS 17.0, *)
public struct MUIList<Data, ID, Content>: View where Data: RandomAccessCollection, ID: Hashable, Content: View, Data.Element: Hashable, Data: Hashable  {
    
    // MARK: - Properties
    
    public var data: Data
    public var id: KeyPath<Data.Element, ID>
    public var content: (Data.Element) -> Content
    public var listStyle: MUIListStyle
    
    @Environment(\.colorScheme) private var colorScheme
    
    // MARK: - Initializers
    
    /// Creates a stylized list with a default insetGrouped style.
    /// - Parameters:
    ///   - data: A collection of elements to display in the list.
    ///   - id: A key path to an `ID` property on each element to uniquely identify them.
    ///   - content: A closure that returns the content view for a given element.
    public init(_ data: Data, id: KeyPath<Data.Element, ID>, @ViewBuilder _ content: @escaping (Data.Element) -> Content) {
        self.data = data
        self.id = id
        self.content = content
        self.listStyle = .insetGrouped
    }
    
    /// Creates a stylized list with a custom list style.
    /// - Parameters:
    ///   - data: A collection of elements to display in the list.
    ///   - id: A key path to an `ID` property on each element to uniquely identify them.
    ///   - listStyle: The style of the list, such as `.plain`, `.inset`, or `.insetGrouped`.
    ///   - content: A closure that returns the content view for a given element.
    public init(_ data: Data, id: KeyPath<Data.Element, ID>, listStyle: MUIListStyle, @ViewBuilder _ content: @escaping (Data.Element) -> Content) {
        self.data = data
        self.id = id
        self.content = content
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

@available(iOS 17.0, *)
extension MUIList {
    
    /// Returns a plain-style list with a vertical stack of content items.
    private func plainStyle() -> some View {
        VStack(spacing: 12) {
            ForEach(data, id: id) { item in
                content(item)
                    .tag(item)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.headline)
                    .fontWeight(.regular)
                    .foregroundColor(MaterialUI.tint.primaryTitle(colorScheme))
                    .padding(.horizontal, 15)
                    .padding(.vertical, 2)
                
                if !isLastElement(data: data, item: item) {
                    MUIDivider()
                }
            }
        }
        .padding(10)
    }
    
    /// Returns an inset-style list with rounded rectangles as background on individual list item.
    private func insetStyle() -> some View {
        VStack(spacing: 12) {
            ForEach(data, id: id) { item in
                content(item)
                    .tag(item)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.headline)
                    .fontWeight(.regular)
                    .foregroundColor(MaterialUI.tint.primaryTitle(colorScheme))
                    .padding(20)
                    .background(MaterialUI.tint.secondaryBackground(colorScheme))
                    .cornerRadius(20)
            }
        }
        .padding(10)
    }
    
    /// Returns an inset-grouped-style list with rounded rectangles as background.
    private func insetGroupedStyle() -> some View {
        VStack(spacing: 12) {
            ForEach(data, id: id) { item in
                content(item)
                    .tag(item)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.headline)
                    .fontWeight(.regular)
                    .foregroundColor(MaterialUI.tint.primaryTitle(colorScheme))
                    .padding(0)
                
                if !isLastElement(data: data, item: item) {
                    MUIDivider()
                }
            }
        }
        .padding(25)
        .background(MaterialUI.tint.secondaryBackground(colorScheme))
        .cornerRadius(25)
        .padding(15)
    }
    
    /// Checks if the current element is the last one in the collection.
    private func isLastElement(data: Data, item: Data.Element) -> Bool {
        return data.last == item
    }
    
}

//
// MUISegmentedControl.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 30/12/23
//

import SwiftUI

// MARK: - MUISegmentedControl

/// A segmented control with customizable appearance and behavior.
@available(iOS 17.0, *)
public struct MUISegmentedControl<Data, ID, Content>: View where Data: RandomAccessCollection, ID: Hashable, Content: View, Data.Element: Hashable, Data: Hashable {
    
    // MARK: - Properties
    
    public var data: Data
    public var id: KeyPath<Data.Element, ID>
    public var content: (Data.Element) -> Content
    
    @Binding public var selectedItem: Data.Element
    @Namespace private var namespace
    @Environment(\.colorScheme) private var colorScheme
    
    // MARK: - Initializer
    
    /// Creates a segmented control with customizable appearance and behavior.
    /// - Parameters:
    ///   - data: A collection of elements to display in the segmented control.
    ///   - id: A key path to an `ID` property on each element to uniquely identify them.
    ///   - selectedItem: A binding to the currently selected element in the segmented control.
    ///   - content: A closure that returns the content view for a given element.
    public init(_ data: Data, id: KeyPath<Data.Element, ID>, selectedItem: Binding<Data.Element>, @ViewBuilder _ content: @escaping (Data.Element) -> Content) {
        self.data = data
        self.id = id
        self._selectedItem = selectedItem
        self.content = content
    }
    
    // MARK: - View Body
    
    public var body: some View {
        HStack(spacing: 0) {
            ForEach(data, id: id) { item in
                ZStack {
                    // Selected tab background
                    if item == selectedItem {
                        RoundedRectangle(cornerRadius: 0)
                            .foregroundColor(MaterialUI.tint.tertiaryBackground(colorScheme))
                            .matchedGeometryEffect(id: "selectedTabBg", in: namespace)
                    }
                    
                    // Content
                    content(item)
                        .tag(item)
                        .foregroundColor(MaterialUI.tint.primaryTitle(colorScheme))
                        .fontWeight(item == selectedItem ? .bold : .regular)
                        .padding(.vertical, 10)
                        .frame(maxWidth: .infinity)
                    
                    // To change `selectedItem`
                        .onTapGesture {
                            withAnimation(.bouncy) {
                                selectedItem = item
                            }
                        }
                }
                
                // Vertical divider
                if !isLastElement(data: data, item: item) {
                    RoundedRectangle(cornerRadius: 0.5)
                        .foregroundStyle(MaterialUI.tint.accentTitle(colorScheme))
                        .frame(width: 0.8)
                }
            }
        }
        // Outline styling.
        .frame(maxWidth: .infinity, maxHeight: 48)
        .background(MaterialUI.tint.background(colorScheme))
        .cornerRadius(99)
        // Outline width
        .padding(1)
        // Outline color
        .background(MaterialUI.tint.accentTitle(colorScheme))
        .cornerRadius(99)
    }
    
    /// Checks if the current element is the last one in the collection.
    private func isLastElement(data: Data, item: Data.Element) -> Bool {
        return data.last == item
    }
}

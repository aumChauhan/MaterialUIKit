//
// MUIRadioButtonGroup.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 16/04/24
//


import SwiftUI

/// A view that presents a collection of items in a radio button form within a single section in MaterialUI style.
@available(iOS 15.0, *)
public struct MUIRadioButtonGroup<Data, ID, Content>: View where Data: RandomAccessCollection, ID: Hashable, Content: View, Data.Element: Hashable, Data: Hashable {
    
    // MARK: - Properties
    
    private let data: Data
    private let id: KeyPath<Data.Element, ID>
    private let content: (Data.Element) -> Content
    
    @Binding public var selectedItem: Data.Element
    
    // MARK: - Initializer
    
    /// Creates a `MUIRadioGroupView` with the provided items and a binding to the selected value.
    /// - Parameters:
    ///   - data: A collection of elements to display in the radio-group options.
    ///   - id: A key path to an `ID` property on each element to uniquely identify them.
    ///   - selectedItem: A binding to the currently selected element in the radio-group options.
    ///   - content: A closure that returns the content view for a given element.
    public init(_ data: Data, id: KeyPath<Data.Element, ID>, selectedItem: Binding<Data.Element>, @ViewBuilder _ content: @escaping (Data.Element) -> Content) {
        self.data = data
        self.id = id
        self._selectedItem = selectedItem
        self.content = content
    }
    
    // MARK: - View Body
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 7) {
            ForEach(data, id: id) { item in
                HStack(alignment: .center) {
                    // Content
                    content(item)
                        .tag(item)
                        .foregroundStyle(.muiPrimaryTitle)
                        .fontWeightWithFallback(.regular)
                        .padding(.vertical, 10)
                    
                    Spacer()
                    
                    // Radio button
                    Image(systemName: item == selectedItem ? "circle.circle.fill" : "circle")
                        .font(.title3)
                        .foregroundStyle(item == selectedItem ? .muiAccent : .muiSecondaryTitle)
                        .onTapGesture {
                            // To change selectedItem
                            withAnimation(.bouncy) {
                                selectedItem = item
                            }
                        }
                }
                
                // Divider
                
                if !isLastElement(data: data, item: item) {
                    MUIDivider()
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    /// Checks if the current element is the last one in the collection.
    private func isLastElement(data: Data, item: Data.Element) -> Bool {
        return data.last == item
    }
}

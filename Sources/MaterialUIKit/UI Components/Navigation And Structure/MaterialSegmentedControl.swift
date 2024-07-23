//
// MaterialSegmentedControl.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 30/12/23
//

import SwiftUI

/// A Material UI style segmented control.
public struct MaterialSegmentedControl<Data, ID, Content>: View where Data: RandomAccessCollection, ID: Hashable, Content: View, Data.Element: Hashable, Data: Hashable {
    
    // MARK: - Properties
    
    private var data: Data
    private var id: KeyPath<Data.Element, ID>
    private var content: (Data.Element) -> Content
    
    @Binding private var selectedItem: Data.Element
    @Namespace private var namespace
    
    // MARK: - Initializer
    
    /// Creates a segemented contorl with the given data, identifier, and content.
    ///
    /// - Parameters:
    ///   - data: A collection of elements to display in the segmented control.
    ///   - id: A key path to an `ID` property on each element to uniquely identify them.
    ///   - selectedItem: A binding to the currently selected element in the segmented control.
    ///   - content: A closure that returns the content view for a given element.
    public init(
        _ data: Data,
        id: KeyPath<Data.Element, ID>,
        selectedItem: Binding<Data.Element>,
        @ViewBuilder _ content: @escaping (Data.Element) -> Content
    ) {
        self.data = data
        self.id = id
        self._selectedItem = selectedItem
        self.content = content
    }
    
    // MARK: - View Body
    
    public var body: some View {
        HStack(spacing: .zero) {
            ForEach(data, id: id) { item in
                ZStack {
                    if item == selectedItem {
                        RoundedRectangle(cornerRadius: .zero)
                            .foregroundStyle(.materialTertiaryBackground)
                            .matchedGeometryEffect(id: "selectedTabBackground", in: namespace)
                    }
                    
                    content(item)
                        .tag(item)
                        .font(MaterialUIKit.configuration.h4)
                        .foregroundStyle(.materialPrimaryTitle)
                        .fontWeightWithFallback(item == selectedItem ? .bold : .regular)
                        .padding(.vertical, MaterialUIKit.configuration.verticalPadding)
                        .frame(maxWidth: .infinity)
                        .onTapGesture {
                            withMaterialAnimation {
                                selectedItem = item
                            }
                        }
                }
                
                if !isLastElement(data: data, item: item) {
                    RoundedRectangle(cornerRadius: 0.5)
                        .foregroundStyle(.materialSeparator)
                        .frame(width: MaterialUIKit.configuration.borderWidth)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 40)
        .background(.materialPrimaryBackground)
        .cornerRadius(MaterialUIKit.configuration.cornerRadius)
        .stroke(background: .materialHighlight)
    }
    
    /// Checks if the current element is the last one in the collection.
    fileprivate func isLastElement(data: Data, item: Data.Element) -> Bool {
        return data.last == item
    }
}


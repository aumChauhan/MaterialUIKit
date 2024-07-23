//
// MaterialRadioButtonGroup.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 16/04/24
//

import SwiftUI

/// A Material UI style collection of items in a radio button form.
public struct MaterialRadioButtonGroup<Data, ID, Content>: View where Data: RandomAccessCollection, ID: Hashable, Content: View, Data.Element: Hashable, Data: Hashable {
    
    // MARK: - Properties
    
    private let data: Data
    private let id: KeyPath<Data.Element, ID>
    private let content: (Data.Element) -> Content
    
    @Binding public var selection: Data.Element
    
    // MARK: - Initializer
    
    /// Creates a radio button group view with the provided items and a binding to the selected value.
    ///
    /// - Parameters:
    ///   - data: A collection of elements to display in the radio-group options.
    ///   - id: A key path to an `ID` property on each element to uniquely identify them.
    ///   - selection: A binding to the currently selected element in the radio-group options.
    ///   - content: A closure that returns the content view for a given element.
    public init(
        _ data: Data,
        id: KeyPath<Data.Element, ID>,
        selection: Binding<Data.Element>,
        @ViewBuilder _ content: @escaping (Data.Element) -> Content
    ) {
        self.data = data
        self.id = id
        self._selection = selection
        self.content = content
    }
    
    // MARK: - View Body
    
    public var body: some View {
        VStack(alignment: .leading, spacing: MaterialUIKit.configuration.verticalStackSpacing) {
            ForEach(data, id: id) { item in
                HStack {
                    content(item)
                        .tag(item)
                        .font(MaterialUIKit.configuration.h4)
                        .foregroundStyle(.materialPrimaryTitle)
                    
                    Spacer()
                    
                    Image(systemName: item == selection ? "circle.circle.fill" : "circle")
                        .font(.title3)
                        .foregroundStyle(item == selection ? .materialAccent : .materialOnDisabled)
                        .onTapGesture {
                            withMaterialAnimation {
                                selection = item
                            }
                        }
                }
                
                if !isLastElement(data: data, item: item) {
                    MaterialDivider()
                }
            }
        }
        .align(.leading)
    }
    
    /// Checks if the current element is the last one in the collection.
    private func isLastElement(data: Data, item: Data.Element) -> Bool {
        return data.last == item
    }
}

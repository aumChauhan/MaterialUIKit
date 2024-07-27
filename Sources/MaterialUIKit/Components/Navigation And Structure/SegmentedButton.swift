//
// SegmentedButton.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 30/12/23
//

import SwiftUI

/// Represents a Material UI styled segmented control for switching between options.
@available(iOS 15.0, *)
public struct SegmentedButton<Data, ID, Content>: View where Data: RandomAccessCollection, ID: Hashable, Content: View, Data.Element: Hashable, Data: Hashable {
    
    // MARK: - PROPERTIES
    
    private var data: Data
    private var id: KeyPath<Data.Element, ID>
    private var content: (Data.Element) -> Content
    
    @Binding private var selection: Data.Element
    @Namespace private var namespace
    
    // MARK: - INITIALIZER
    
    /// Creates a segemented control with the given data, identifier, and content.
    ///
    /// - Parameters:
    ///   - data: A collection of elements to display in the segmented control.
    ///   - id: A key path to an `ID` property on each element to uniquely identify them.
    ///   - selection: A binding to the currently selected element in the segmented control.
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
    
    // MARK: - VIEW BODY
    
    public var body: some View {
        HStack(spacing: .zero) {
            ForEach(data, id: id) { item in
                ZStack {
                    if item == selection {
                        RoundedRectangle(cornerRadius: .zero)
                            .foregroundStyle(.materialUIHighlight.opacity(0.15))
                            .matchedGeometryEffect(id: "selectedTabBackground", in: namespace)
                    }
                    
                    content(item)
                        .tag(item)
                        .font(MaterialUIKit.configuration.h4)
                        .foregroundStyle(.materialUIPrimaryTitle)
                        .fontWeightWithFallback(item == selection ? .semibold : .regular)
                        .padding(.vertical, MaterialUIKit.configuration.verticalPadding)
                        .frame(maxWidth: .infinity)
                        .onTapGesture {
                            withMaterialAnimation {
                                selection = item
                            }
                        }
                }
                
                if !isLastElement(data: data, item: item) {
                    RoundedRectangle(cornerRadius: 0.5)
                        .foregroundStyle(.materialUIOutline)
                        .frame(width: MaterialUIKit.configuration.borderWidth)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 40)
        .background(.materialUIPrimaryBackground)
        .cornerRadius(MaterialUIKit.configuration.cornerRadius)
        .stroke(background: .materialUIOutline)
        .hapticFeedbackOnChange(of: selection)
    }
    
    /// Checks if the current element is the last one in the collection.
    fileprivate func isLastElement(data: Data, item: Data.Element) -> Bool {
        return data.last == item
    }
}

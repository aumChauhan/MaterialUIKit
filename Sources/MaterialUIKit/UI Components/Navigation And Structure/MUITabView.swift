//
// MUITabView.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 30/12/23
//

import SwiftUI

/// A Material UI styled tab bar container.
public struct MaterialTabBar<Content>: View where Content: View {
    
    // MARK: - Properties
    
    private let content: Content
    
    @Binding private var selection: MaterialTabBarItem
    @State private var tabs: [MaterialTabBarItem] = []
    
    // MARK: - Initializer
    
    /// Creates a container view with a MaterialUI-style tab bar.
    ///
    /// - Parameters:
    ///   - selection: Binding to the selected tab item.
    ///   - content: The main content of the view.
    public init(selection: Binding<MaterialTabBarItem>, @ViewBuilder content: () -> Content) {
        self._selection = selection
        self.content = content()
    }
    
    // MARK: - View Body
    
    public var body: some View {
        ZStack(alignment: .bottom) {
            content
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
            
            MaterialTabBarContainerView(tabs: tabs, selection: $selection, localSelection: selection)
        }
        .ignoresSafeArea(.keyboard)
        .onPreferenceChange(MaterialTabBarItemsPreferenceKey.self, perform: { value in
            self.tabs = value
        })
    }
}

// MARK: - MaterialTabBarContainerView

/// A view that represents the MaterialUI-style tab bar.
fileprivate struct MaterialTabBarContainerView: View {
    
    // MARK: - Properties
    
    public let tabs: [MaterialTabBarItem]
    @Binding public var selection: MaterialTabBarItem
    @State public var localSelection: MaterialTabBarItem
    
    @Namespace private var namespace
    
    // MARK: - View Body
    
    var body: some View {
        tabBar
            .onChangeWithFallback(of: selection) { oldValue, newValue in
                withAnimation(.bouncy) {
                    localSelection = newValue
                }
            }
    }
    
    /// Returns tab bar.
    private var tabBar: some View {
        HStack {
            ForEach(tabs, id: \.self) { tab in
                VStack(alignment: .center , spacing: 4) {
                    Image(systemName: tab.systemName)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 5)
                        .font(.headline)
                        .foregroundStyle(localSelection == tab ? .muiTonal : .materialPrimaryTitle)
                        .background(
                            ZStack {
                                if localSelection == tab {
                                    RoundedRectangle(cornerRadius: 100)
                                        .fill(.muiAccent)
                                        .matchedGeometryEffect(id: "background_rectangle", in: namespace)
                                }
                            }
                        )
                    
                    Text(tab.title)
                        .font(.footnote)
                        .fontWeightWithFallback(localSelection == tab ? .bold : .medium)
                        .foregroundStyle(.muiPrimaryTitle)
                }
                .frame(maxWidth: .infinity)
                .onTapGesture {
                    selection = tab
                }
            }
        }
        .padding(.top, 10)
        .background(
            MaterialUIKit.tint.secondaryBackground()
                .ignoresSafeArea(edges: [.horizontal, .bottom])
        )
    }
}

// MARK: - MaterialTabBarItemsPreferenceKey

/// A preference key to collect tab bar items for rendering.
fileprivate struct MaterialTabBarItemsPreferenceKey: PreferenceKey {
    static var defaultValue: [MaterialTabBarItem] = []
    
    static func reduce(value: inout [MaterialTabBarItem], nextValue: () -> [MaterialTabBarItem]) {
        value += nextValue()
    }
}

// MARK: - MaterialTabBarItemViewModiferWithOnAppear

/// A view modifier to handle the appearance of tab bar items.
fileprivate struct MaterialTabBarItemViewModiferWithOnAppear: ViewModifier {
    
    public let tab: MaterialTabBarItem
    @Binding public var selection: MaterialTabBarItem
    
    /// Applies the view modifier to handle the appearance of tab bar items.
    /// - Parameters:
    ///   - content: The content to be modified.
    /// - Returns: A modified view.
    @ViewBuilder func body(content: Content) -> some View {
        if selection == tab {
            ZStack {
                MaterialUIKit.tint.primaryBackground()
                content
            }
            .opacity(1)
            .preference(key: MaterialTabBarItemsPreferenceKey.self, value: [tab])
        } else {
            Text("")
                .opacity(0)
                .preference(key: MaterialTabBarItemsPreferenceKey.self, value: [tab])
        }
    }
}

// MARK: - View Extension

extension View {
    
    /// Sets up a tab bar item with the specified system image, title, and selection binding.
    ///
    /// - Parameters:
    ///   - systemName: The name of the system image for the tab item.
    ///   - title: The title text for the tab item.
    ///   - selection: Binding to the selected tab item.
    ///
    /// - Returns: A modified view with the specified tab bar item.
    public func materialTabBarItem(systemName: String, title: String, selection: Binding<MaterialTabBarItem>) -> some View {
        modifier(
            MaterialTabBarItemViewModiferWithOnAppear(
                tab: MaterialTabBarItem(
                    systemName: systemName,
                    title: title
                ),
                selection: selection
            )
        )
    }
}

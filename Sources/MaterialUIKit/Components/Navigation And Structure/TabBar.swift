//
// TabBar.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 30/12/23
//

import SwiftUI

// MARK: - PUBLIC

/// A Material UI style bottom tab items container.
public struct TabBar<Content>: View where Content: View {
    
    // MARK: - PROPERTIES
    
    private let content: Content
    
    @Binding private var selection: MUITabBarItem
    @State private var tabs: [MUITabBarItem] = []
    
    // MARK: - INITIALIZER
    
    /// Creates a container view with a MaterialUI-style tab bar.
    ///
    /// - Parameters:
    ///   - selection: Binding to the selected tab item.
    ///   - content: The main content of the view.
    public init(selection: Binding<MUITabBarItem>, @ViewBuilder content: () -> Content) {
        self._selection = selection
        self.content = content()
    }
    
    // MARK: - View BODY
    
    public var body: some View {
        ZStack(alignment: .bottom) {
            content
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
            
            TabBarContainer(tabs: tabs, selection: $selection, localSelection: selection)
        }
        .ignoresSafeArea(.keyboard)
        .onPreferenceChange(TabBarPreferenceKey.self, perform: { value in
            self.tabs = value
        })
    }
}

extension View {
    
    /// Sets up a tab bar item with the specified system image, title, and selection binding.
    ///
    /// - Parameters:
    ///   - systemName: The name of the system image for the tab item.
    ///   - title: The title text for the tab item.
    ///   - selection: Binding to the selected tab item.
    ///
    /// - Returns: A modified view with the specified tab bar item.
    public func tabBarItem(systemName: String, title: String, selection: Binding<MUITabBarItem>) -> some View {
        modifier(
            TabBarItemViewModifer(
                tab: MUITabBarItem(
                    systemName: systemName,
                    title: title
                ),
                selection: selection
            )
        )
    }
}

// MARK: - FILE PRIVATE

/// A view that represents the MaterialUI-style tab bar.
fileprivate struct TabBarContainer: View {
    
    // MARK: - PROPERTIES
    
    let tabs: [MUITabBarItem]
    @Binding var selection: MUITabBarItem
    @State var localSelection: MUITabBarItem
    
    @Namespace private var namespace
    
    // MARK: - VIEW BODY

    var body: some View {
        tabBar
            .onChangeWithFallback(of: selection) { oldValue, newValue in
                withMaterialAnimation {
                    localSelection = newValue
                }
            }
    }
    
    /// Returns tab bar.
    fileprivate var tabBar: some View {
        HStack {
            ForEach(tabs, id: \.self) { tab in
                VStack(alignment: .center , spacing: 4) {
                    Image(systemName: tab.systemName)
                        .padding(.horizontal, MaterialUIKit.configuration.horizontalPadding)
                        .padding(.vertical, 5)
                        .font(.headline)
                        .foregroundStyle(localSelection == tab ? .materialUITonal : .materialUIPrimaryTitle)
                        .background(
                            ZStack {
                                if localSelection == tab {
                                    RoundedRectangle(cornerRadius: .infinity)
                                        .fill(.materialUIAccent)
                                        .matchedGeometryEffect(id: "backgroundRectangle", in: namespace)
                                }
                            }
                        )
                    
                    Text(tab.title)
                        .font(.footnote)
                        .foregroundStyle(.materialUIPrimaryTitle)
                }
                .frame(maxWidth: .infinity)
                .onTapGesture {
                    selection = tab
                }
            }
        }
        .padding(.vertical, 10)
        .background(
            MaterialUIKit.configuration.colorScheme.secondaryBackground
                .ignoresSafeArea(edges: [.horizontal, .bottom])
        )
    }
}

/// A preference key to collect tab bar items for rendering.
fileprivate struct TabBarPreferenceKey: PreferenceKey {
    static var defaultValue: [MUITabBarItem] = []
    
    static func reduce(value: inout [MUITabBarItem], nextValue: () -> [MUITabBarItem]) {
        value += nextValue()
    }
}


/// A view modifier to handle the appearance of tab bar items.
fileprivate struct TabBarItemViewModifer: ViewModifier {
    
    let tab: MUITabBarItem
    @Binding var selection: MUITabBarItem
    
    /// Applies the view modifier to handle the appearance of tab bar items.
    @ViewBuilder
    func body(content: Content) -> some View {
        if selection == tab {
            ZStack {
                MaterialUIKit.configuration.colorScheme.primaryBackground
                content
            }
            .opacity(1)
            .preference(key: TabBarPreferenceKey.self, value: [tab])
        } else {
            Text("")
                .opacity(0)
                .preference(key: TabBarPreferenceKey.self, value: [tab])
        }
    }
}


//
// TabBar.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 30/12/23
//

import SwiftUI

// MARK: - PUBLIC

/// Represents a Material UI styled container for bottom tab items, used to organize and switch between different views.
@available(iOS 15.0, *)
public struct TabBar<Content>: View where Content: View {
    
    // MARK: - PROPERTIES
    
    private let content: Content
    private let usesVerticalLayout: Bool
    
    @Binding private var selection: TabBarItem
    @State private var tabs: [TabBarItem] = []
    
    // MARK: - INITIALIZER
    
    /// Creates a container view with a bottom tab bar.
    ///
    /// - Parameters:
    ///   - selection: Binding to the selected tab item.
    ///   - content: The main content of the view.
    ///   - usesVerticalLayout: A Boolean value indicating whether to use a vertical layout for the tab bar. (The content must then use the whole screen height)
    public init(selection: Binding<TabBarItem>, usesVerticalLayout: Bool = false, @ViewBuilder content: () -> Content) {
        self._selection = selection
        self.content = content()
        self.usesVerticalLayout = usesVerticalLayout
    }
    
    // MARK: - View BODY
    
    public var body: some View {
        Group {
            if usesVerticalLayout {
                VStack(spacing: .zero) {
                    content
                    TabBarContainer(tabs: tabs, selection: $selection, localSelection: selection)
                        .frame(maxWidth: .infinity)
                }
            } else {
                ZStack(alignment: .bottom) {
                    content
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .ignoresSafeArea(edges: .bottom)

                    TabBarContainer(tabs: tabs, selection: $selection, localSelection: selection)
                }
            }
        }
        .ignoresSafeArea(.keyboard)
        .onPreferenceChange(TabBarPreferenceKey.self) { value in
            self.tabs = value
        }
        .hapticFeedbackOnChange(of: selection)
    }
}

extension View {
    
    /// Sets up a tab bar item with the specified system image, title, and selection binding.
    ///
    /// - Parameters:
    ///   - systemImage: The name of the system image for the tab item.
    ///   - titleKey: The title text for the tab item.
    ///   - selection: Binding to the selected tab item.
    public func tabBarItem(systemImage: String, titleKey: String, selection: Binding<TabBarItem>) -> some View {
        modifier(
            TabBarItemViewModifer(
                tab: TabBarItem(
                    systemImage: systemImage,
                    titleKey: titleKey
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
    
    let tabs: [TabBarItem]
    @Binding var selection: TabBarItem
    @State var localSelection: TabBarItem
    
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
                    Image(systemName: tab.systemImage)
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
                    
                    Text(tab.titleKey)
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
    static var defaultValue: [TabBarItem] = []
    
    static func reduce(value: inout [TabBarItem], nextValue: () -> [TabBarItem]) {
        value += nextValue()
    }
}


/// A view modifier to handle the appearance of tab bar items.
fileprivate struct TabBarItemViewModifer: ViewModifier {
    
    let tab: TabBarItem
    @Binding var selection: TabBarItem
    
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

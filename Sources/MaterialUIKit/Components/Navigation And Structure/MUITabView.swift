//
// MUITabView.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 30/12/23
//

import SwiftUI

// MARK: - MUITabBarItem

/// A model representing an item in the MaterialUI-style tab bar.
@available(iOS 17.0, *)
public struct MUITabBarItem: Hashable {
    
    // MARK: - Properties
    
    public let systemImage: String
    public let title: String
    
    // MARK: - Initializers
    
    public init(systemImage: String, title: String) {
        self.systemImage = systemImage
        self.title = title
    }
}

// MARK: - MUITabBarView

/// A container view that includes the main content and a MaterialUI-style tab bar.
@available(iOS 17.0, *)
public struct MUITabBarView<Content>: View where Content: View {
    
    // MARK: - Properties
    
    public let content: Content
    
    @Binding public var selection: MUITabBarItem
    @State private var tabs: [MUITabBarItem] = []
    
    // MARK: - Initializer
    
    /// Creates a container view with a MaterialUI-style tab bar.
    /// - Parameters:
    ///   - selection: Binding to the selected tab item.
    ///   - content: The main content of the view.
    public init(selection: Binding<MUITabBarItem>, @ViewBuilder content: () -> Content) {
        self._selection = selection
        self.content = content()
    }
    
    // MARK: - View Body
    
    public var body: some View {
        ZStack(alignment: .bottom) {
            content
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
            
            MUITabBarContainerView(tabs: tabs, selection: $selection, localSelection: selection)
        }
        .ignoresSafeArea(.keyboard)
        .onPreferenceChange(MUITabBarItemsPreferenceKey.self, perform: { value in
            self.tabs = value
        })
    }
}

// MARK: - MUITabBarContainerView

/// A view that represents the MaterialUI-style tab bar.
@available(iOS 17.0, *)
private struct MUITabBarContainerView: View {
    
    // MARK: - Properties
    
    public let tabs: [MUITabBarItem]
    @Binding public var selection: MUITabBarItem
    @State public var localSelection: MUITabBarItem
    
    @Namespace private var namespace
    
    // MARK: - View Body
    
    var body: some View {
        tabBar
            .onChange(of: selection) { oldValue, newValue in
                withAnimation(.bouncy) {
                    localSelection = newValue
                }
            }
    }
}

// MARK: - Extension MUITabBarContainerView

@available(iOS 17.0, *)
extension MUITabBarContainerView {
    
    /// Returns tab bar.
    private var tabBar: some View {
        HStack {
            ForEach(tabs, id: \.self) { tab in
                VStack(alignment: .center , spacing: 4) {
                    
                    // Tab item image
                    Image(systemName: tab.systemImage)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 5)
                        .font(.headline)
                        .foregroundColor(localSelection == tab ? MaterialUI.tint.iconColor() : MaterialUI.tint.primaryTitle())
                    
                    // Selected tab background
                        .background(
                            ZStack {
                                if localSelection == tab {
                                    RoundedRectangle(cornerRadius: 100)
                                        .fill(MaterialUI.tint.accent())
                                        .matchedGeometryEffect(id: "background_rectangle", in: namespace)
                                }
                            }
                        )
                    
                    // Tab title
                    Text(tab.title)
                        .font(.footnote)
                        .fontWeight(localSelection == tab ? .bold : .medium)
                        .foregroundColor(MaterialUI.tint.primaryTitle())
                }
                .frame(maxWidth: .infinity)
                // Switch tab action
                .onTapGesture {
                    selection = tab
                }
            }
        }
        .padding(.top, 10)
        // Tab bar background
        .background(
            MaterialUI.tint.secondaryBackground()
                .ignoresSafeArea(edges: [.horizontal, .bottom])
        )
    }
}

// MARK: - MUITabBarItemsPreferenceKey

/// A preference key to collect tab bar items for rendering.
@available(iOS 17.0, *)
private struct MUITabBarItemsPreferenceKey: PreferenceKey {
    static var defaultValue: [MUITabBarItem] = []
    
    static func reduce(value: inout [MUITabBarItem], nextValue: () -> [MUITabBarItem]) {
        value += nextValue()
    }
}

// MARK: - MUITabBarItemViewModiferWithOnAppear

/// A view modifier to handle the appearance of tab bar items.
@available(iOS 17.0, *)
private struct MUITabBarItemViewModiferWithOnAppear: ViewModifier {
    
    public let tab: MUITabBarItem
    @Binding public var selection: MUITabBarItem
    
    /// Applies the view modifier to handle the appearance of tab bar items.
    /// - Parameters:
    ///   - content: The content to be modified.
    /// - Returns: A modified view.
    @ViewBuilder func body(content: Content) -> some View {
        if selection == tab {
            ZStack {
                MaterialUI.tint.background()
                content
            }
            .opacity(1)
            .preference(key: MUITabBarItemsPreferenceKey.self, value: [tab])
        } else {
            Text("")
                .opacity(0)
                .preference(key: MUITabBarItemsPreferenceKey.self, value: [tab])
        }
    }
}

// MARK: - Extension View

@available(iOS 17.0, *)
extension View {
    
    /// Sets up a tab bar item with the specified system image, title, and selection binding.
    /// - Parameters:
    ///   - systemImage: The name of the system image for the tab item.
    ///   - title: The title text for the tab item.
    ///   - selection: Binding to the selected tab item.
    /// - Returns: A modified view with the specified tab bar item.
    public func mUITabBarItem(systemImage: String, title: String, selection: Binding<MUITabBarItem>) -> some View {
        modifier(
            MUITabBarItemViewModiferWithOnAppear(
                tab: MUITabBarItem(systemImage: systemImage, title: title),
                selection: selection)
        )
    }
}

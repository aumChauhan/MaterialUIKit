//
// NavigationContainer.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 30/12/23
//

import SwiftUI

// MARK: - PUBLIC

/// A navigation container that wraps the content in a MaterialUI-style navigation bar.
public struct NavigationContainer<Content>: View where Content: View {
    
    // MARK: - PROPERTIES
    
    private let content: Content
    
    // MARK: - INITIALIZER

    /// Creates a custom navigation container with the specified content.
    ///
    /// - Parameter content: The content to be wrapped in the navigation container.
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    // MARK: - VIEW BODY

    public var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack { contentWrapper() }
        } else {
            NavigationView { contentWrapper() }
        }
    }
    
    /// A wrapper function that provides a custom-styled content view.
    private func contentWrapper() -> some View {
        ZStack {
            Color.materialUIPrimaryBackground.ignoresSafeArea(.all)
            
            TopAppBar {
                content
                    .padding(MaterialUIKit.configuration.contentPadding)
            }
            .navigationBarHidden(true)
        }
    }
}

extension View {
    
    /// Sets the title for the navigation container.
    ///
    /// - Parameter title: The title to be displayed in the navigation container.
    ///
    /// - Returns: A view modified to include the specified navigation bar title.
    public func navigationContainerTitle(_ title: String) -> some View {
        return self.preference(key: NavigationContainerTitlePreferenceKey.self, value: title)
    }
    
    /// Sets the style for the navigation container header.
    ///
    /// - Parameter style: The style of the navigation container header.
    ///
    /// - Returns: A view modified to include the specified navigation container header style.
    public func navigationContainerHeaderStyle(_ style: MUINavigationContainerHeaderStyle) -> some View {
        return self.preference(key: NavigationContainerHeaderStylePreferenceKey.self, value: style)
    }
    
    /// Sets the toolbar for the navigation container.
    ///
    /// - Parameter toolbar: The toolbar to be displayed in the navigation container.
    ///
    /// - Returns: A view modified to include the specified toolbar.
    public func navigationContainerToolbar<Toolbar: View>(toolbar: () -> Toolbar) -> some View {
        return self.preference(key: NavigationContainerToolBarPreferenceKey.self, value: EquatableViewContainer(view: AnyView(toolbar())))
    }
    
    /// Sets the visibility of the back button in the navigation container.
    ///
    /// - Parameter hidden: A Boolean value indicating whether the back button should be hidden.
    ///
    /// - Returns: A view modified to include the specified back button visibility.
    public func navigationContainerBackButtonHidden(_ hidden: Bool) -> some View {
        return self.preference(key: NavigationContainerBackButtonHiddenPreferenceKey.self, value: !hidden)
    }
    
    /// Sets the properties for the navigation container.
    ///
    /// - Parameters:
    ///   - title: The title to be displayed in the navigation container.
    ///   - backButtonHidden: A Boolean value indicating whether the back button should be hidden.
    ///   - style: The style of the navigation container header.
    ///
    /// - Returns: A view modified to include the specified navigation bar properties.
    public func navigationContainerTopBar(title: String, backButtonHidden: Bool, style: MUINavigationContainerHeaderStyle) -> some View {
        self
            .navigationContainerTitle(title)
            .navigationContainerBackButtonHidden(backButtonHidden)
            .navigationContainerHeaderStyle(style)
    }
    
}

// MARK: - FILE PRIVATE

fileprivate struct ContainerHeader: View {
    
    // MARK: - Properties
    
    let toolbar: EquatableViewContainer
    let title: String
    let headerStyle: MUINavigationContainerHeaderStyle
    let showBackButton: Bool
    
    @Environment(\.dismiss) private var dismiss
    
    // MARK: - View Body
    
    var body: some View {
        switch headerStyle {
        case .large:
            largeHeader()
        case .inline:
            inlineHeader()
        }
    }
    
    /// Returns a navigation container header with large header style.
    private func largeHeader() -> some View {
        VStack(alignment: .leading, spacing: MaterialUIKit.configuration.verticalStackSpacing) {
            HStack {
                if showBackButton {
                    Button {
                        dismiss()
                        hapticFeedback()
                    } label: {
                        Image(systemName: "arrow.left")
                            .font(.title3)
                    }
                    .tint(.materialUIPrimaryTitle)
                }
                
                toolbar.view
            }
            .align(.leading)
            
            Text(title)
                .font(MaterialUIKit.configuration.hXL)
                .fontWeightWithFallback(.semibold)
        }
        .foregroundStyle(.materialUIPrimaryTitle)
    }
    
    /// Returns a navigation container header with inline header style.
    private func inlineHeader() -> some View {
        HStack(spacing: MaterialUIKit.configuration.horizontalStackSpacing) {
            if showBackButton {
                Button {
                    dismiss()
                    hapticFeedback()
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.headline)
                }
            }
            
            Text(title)
                .font(MaterialUIKit.configuration.h2)
            
            Spacer()
            
            toolbar.view
        }
        .foregroundStyle(.materialUIPrimaryTitle)
    }
}

/// A container view that represents the navigation top bar and content of a screen.
fileprivate struct TopAppBar<Content>: View where Content: View {
    
    // MARK: - PROPERTIES
    
    public let content: Content
    
    @State private var showBackButton: Bool = false
    @State private var headerStyle: MUINavigationContainerHeaderStyle = .large
    @State private var title: String = ""
    @State private var toolbar: EquatableViewContainer = EquatableViewContainer(view: AnyView(EmptyView()))
    
    // MARK: - INITIALIZER
    
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    // MARK: - VIEW BODY

    public var body: some View {
        VStack(spacing: 0) {
            ContainerHeader(
                toolbar: toolbar,
                title: title,
                headerStyle: headerStyle,
                showBackButton: showBackButton
            )
            .padding(.horizontal, MaterialUIKit.configuration.contentPadding)
            
            content
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        // Sets navigation title
        .onPreferenceChange(NavigationContainerTitlePreferenceKey.self) { value in
            self.title = value
        }
        // Sets the visiblity for back button
        .onPreferenceChange(NavigationContainerBackButtonHiddenPreferenceKey.self) { value in
            self.showBackButton = value
        }
        // Sets the navigation title style
        .onPreferenceChange(NavigationContainerHeaderStylePreferenceKey.self) { value in
            self.headerStyle = value
        }
        // Sets the toolbar
        .onPreferenceChange(NavigationContainerToolBarPreferenceKey.self) { value in
            toolbar = value
        }
    }
}

/// Sets the title for the navigation bar.
fileprivate struct NavigationContainerTitlePreferenceKey: PreferenceKey {
    static var defaultValue: String = ""
    
    static func reduce(value: inout String, nextValue: () -> String) {
        value = nextValue()
    }
}

/// Sets the visibility of the back button in the navigation bar.
fileprivate struct NavigationContainerBackButtonHiddenPreferenceKey: PreferenceKey {
    static var defaultValue: Bool = false
    
    static func reduce(value: inout Bool, nextValue: () -> Bool) {
        value = nextValue()
    }
}

/// Sets the style for the navigation bar header.
fileprivate struct NavigationContainerHeaderStylePreferenceKey: PreferenceKey {
    static var defaultValue: MUINavigationContainerHeaderStyle = .large
    
    static func reduce(value: inout MUINavigationContainerHeaderStyle, nextValue: () -> MUINavigationContainerHeaderStyle) {
        value = nextValue()
    }
}

/// Sets the toolbar for the navigation bar.
fileprivate struct NavigationContainerToolBarPreferenceKey: PreferenceKey {
    static var defaultValue: EquatableViewContainer = EquatableViewContainer(view: AnyView(EmptyView()) )
    
    static func reduce(value: inout EquatableViewContainer, nextValue: () -> EquatableViewContainer) {
        value = nextValue()
    }
}

/// A container to hold an equatable view.
fileprivate struct EquatableViewContainer: Equatable {
    let id = UUID().uuidString
    let view:AnyView
    
    static func == (lhs: EquatableViewContainer, rhs: EquatableViewContainer) -> Bool {
        return lhs.id == rhs.id
    }
}

//
// MUINavigationView.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 30/12/23
//

import SwiftUI

// MARK: - MUINavigationHeaderStyle

/// An enumeration representing different styles for navigation bar headers.
@available(iOS 15.0, *)
public enum MUINavigationHeaderStyle {
    /// A large-style navigation bar header.
    case large
    
    /// An inline-style navigation bar header.
    case inline
}

// MARK: - MUINavigationView

/// A custom navigation view that wraps the content in a MaterialUI-styled navigation bar.
@available(iOS 15.0, *)
public struct MUINavigationView<Content>: View where Content: View {
    
    // MARK: - Properties
    
    public let content: Content
    
    // MARK: - Initializer
    
    /// Creates a custom navigation view with the specified content.
    /// - Parameter content: The content to be wrapped in the navigation view.
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    // MARK: - View Body
    
    public var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                ZStack {
                    MaterialUIKit.tint.primaryBackground().ignoresSafeArea(.all)
                    
                    // Content container
                    MUINavigationBarContainerView {
                        content
                            .padding(MUIConstants.insideMargin)
                    }
                    .navigationBarHidden(true)
                }
            }
        } else {
            NavigationView {
                ZStack {
                    MaterialUIKit.tint.primaryBackground().ignoresSafeArea(.all)
                    
                    // Content container
                    MUINavigationBarContainerView {
                        content
                            .padding(MUIConstants.insideMargin)
                    }
                    .navigationBarHidden(true)
                }
            }
        }
    }
}

// MARK: - MUINavigationHeader

@available(iOS 15.0, *)
private struct MUINavigationHeader: View {
    
    // MARK: - Properties
    
    public let toolbar: EquatableViewContainer
    public let title: String
    public let headerStyle: MUINavigationHeaderStyle
    public let showBackButton: Bool
    
    @Environment(\.dismiss) private var dismiss
    
    // MARK: - View Body
    
    public var body: some View {
        switch headerStyle {
        case .large:
            largeHeader()
        case .inline:
            inlineHeader()
        }
    }
}

// MARK: - Extension MUINavigationHeader

@available(iOS 15.0, *)
extension MUINavigationHeader {
    
    /// Returns a navigation header with large header style.
    private func largeHeader() -> some View {
        VStack(alignment: .leading, spacing: MUIConstants.verticalContentPadding) {
            HStack {
                // Dismiss button
                if showBackButton {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "arrow.left")
                            .font(.title3)
                    }
                    .tint(.muiPrimaryTitle)
                }
                
                // Toolbar item
                toolbar.view
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            // Navigation title
            Text(title)
                .font(.title)
                .fontWeightWithFallback(.medium)
        }
        .foregroundColor(.muiPrimaryTitle)
        .padding(.horizontal, 15)
        .padding(.vertical, 10)
    }
    
    /// Returns a navigation header with inline header style.
    private func inlineHeader() -> some View {
        HStack(spacing: 10) {
            // Dismiss button
            if showBackButton {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.headline)
                }
            }
            
            // Navigation title
            Text(title)
                .font(.title3)
            
            Spacer()
            
            // Toolbar Item
            toolbar.view
        }
        .foregroundColor(.muiPrimaryTitle)
        .padding(.horizontal, 15)
        .padding(.vertical, 10)
    }
}

// MARK: - MUINavigationBarContainerView

/// A container view that represents the navigation bar and content of a screen.
@available(iOS 15.0, *)
private struct MUINavigationBarContainerView<Content>: View where Content: View {
    
    // MARK: - Properties
    
    public let content: Content
    
    @State private var showBackButton: Bool = false
    @State private var headerStyle: MUINavigationHeaderStyle = .large
    @State private var title: String = ""
    @State private var toolbar: EquatableViewContainer = EquatableViewContainer(view: AnyView(EmptyView()))
    
    // MARK: - Initializer
    
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    // MARK: - View Body
    
    public var body: some View {
        VStack(spacing: 0) {
            // Navigation header
            MUINavigationHeader(
                toolbar: toolbar,
                title: title,
                headerStyle: headerStyle,
                showBackButton: showBackButton
            )
            
            // NavigationView content
            content
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        // Sets navigation title
        .onPreferenceChange(MUINavigaionBarTitlePreferenceKey.self) { value in
            self.title = value
        }
        // Sets the visiblity for back button
        .onPreferenceChange(MUINavigationBarBackButtonHiddenPreferenceKey.self) { value in
            self.showBackButton = value
        }
        // Sets the navigation title style
        .onPreferenceChange(MUINavigationTitleStylePreferenceKey.self) { value in
            self.headerStyle = value
        }
        // Sets the toolbar
        .onPreferenceChange(MUIToolbarViewPreferenceKey.self) { value in
            toolbar = value
        }
    }
}

// MARK: - MUINavigationLink

/// A navigation link that wraps the destination in a MaterialUI-styled navigation bar.
@available(iOS 15.0, *)
public struct MUINavigationLink<Label, Destination>: View where Label: View, Destination: View {
    
    // MARK: - Properties
    
    public let destination: Destination
    public let label: Label
    
    // MARK: - Initializer
    
    public init(@ViewBuilder destination: () -> Destination, @ViewBuilder label: () -> Label) {
        self.destination = destination()
        self.label = label()
    }
    
    // MARK: - View Body
    
    public var body: some View {
        NavigationLink {
            MUINavigationBarContainerView {
                destination
            }
            .navigationBarHidden(true)
        } label: {
            label
                .padding(.horizontal, 8)
        }
    }
}

// MARK: - Preference Keys

/// Sets the title for the navigation bar.
@available(iOS 15.0, *)
private struct MUINavigaionBarTitlePreferenceKey: PreferenceKey {
    static var defaultValue: String = ""
    
    static func reduce(value: inout String, nextValue: () -> String) {
        value = nextValue()
    }
}

/// Sets the visibility of the back button in the navigation bar.
@available(iOS 15.0, *)
private struct MUINavigationBarBackButtonHiddenPreferenceKey: PreferenceKey {
    static var defaultValue: Bool = false
    
    static func reduce(value: inout Bool, nextValue: () -> Bool) {
        value = nextValue()
    }
}

/// Sets the style for the navigation bar header.
@available(iOS 15.0, *)
private struct MUINavigationTitleStylePreferenceKey: PreferenceKey {
    static var defaultValue: MUINavigationHeaderStyle = .large
    
    static func reduce(value: inout MUINavigationHeaderStyle, nextValue: () -> MUINavigationHeaderStyle) {
        value = nextValue()
    }
}

/// Sets the toolbar for the navigation bar.
@available(iOS 15.0, *)
private struct MUIToolbarViewPreferenceKey: PreferenceKey {
    static var defaultValue: EquatableViewContainer = EquatableViewContainer(view: AnyView(EmptyView()) )
    
    static func reduce(value: inout EquatableViewContainer, nextValue: () -> EquatableViewContainer) {
        value = nextValue()
    }
}

// MARK: - Extension View

@available(iOS 15.0, *)
extension View {
    
    /// Sets the title for the navigation bar.
    /// - Parameter title: The title to be displayed in the navigation bar.
    /// - Returns: A view modified to include the specified navigation bar title.
    public func muiNavigationTitle(_ title: String) -> some View {
        return self.preference(key: MUINavigaionBarTitlePreferenceKey.self, value: title)
    }
    
    /// Sets the style for the navigation bar header.
    /// - Parameter style: The style of the navigation bar header.
    /// - Returns: A view modified to include the specified navigation bar header style.
    public func muiNavigationHeaderStyle(_ style: MUINavigationHeaderStyle) -> some View {
        return self.preference(key: MUINavigationTitleStylePreferenceKey.self, value: style)
    }
    
    /// Sets the toolbar for the navigation bar.
    /// - Parameter toolbar: The toolbar to be displayed in the navigation bar.
    /// - Returns: A view modified to include the specified toolbar.
    public func muiToolbar<Toolbar: View>(toolbar: () -> Toolbar) -> some View {
        return self.preference(key: MUIToolbarViewPreferenceKey.self, value: EquatableViewContainer(view: AnyView(toolbar())))
    }
    
    /// Sets the visibility of the back button in the navigation bar.
    /// - Parameter hidden: A Boolean value indicating whether the back button should be hidden.
    /// - Returns: A view modified to include the specified back button visibility.
    public func muiNavigationBarBackButtonHidden(_ hidden: Bool) -> some View {
        return self.preference(key: MUINavigationBarBackButtonHiddenPreferenceKey.self, value: !hidden)
    }
    
    /// Sets the properties for the navigation bar.
    /// - Parameters:
    ///   - title: The title to be displayed in the navigation bar.
    ///   - backButtonHidden: A Boolean value indicating whether the back button should be hidden.
    ///   - style: The style of the navigation bar header.
    /// - Returns: A view modified to include the specified navigation bar properties.
    public func muiNavigationBar(title: String = "", backButtonHidden: Bool = false, style: MUINavigationHeaderStyle = .large) -> some View {
        self
            .muiNavigationTitle(title)
            .muiNavigationBarBackButtonHidden(backButtonHidden)
            .muiNavigationHeaderStyle(style)
    }
    
}

// MARK: - EquatableViewContainer

/// A container to hold an equatable view.
@available(iOS 15.0, *)
public struct EquatableViewContainer: Equatable {
    let id = UUID().uuidString
    let view:AnyView
    
    public static func == (lhs: EquatableViewContainer, rhs: EquatableViewContainer) -> Bool {
        return lhs.id == rhs.id
    }
}


// MARK: - Extension UINavigationController

/// An extension for `UINavigationController` to customize its behavior.
extension UINavigationController {
    
    /// Overrides the `viewDidLoad` method to disable the interactive pop gesture recognizer's delegate.
    open override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = nil
    }
}

//
// MaterialNavigationStack.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 30/12/23
//

import SwiftUI

// MARK: - MaterialNavigationStack

/// A navigation stack that wraps the content in a MaterialUI-styled navigation bar.
public struct MaterialNavigationStack<Content>: View where Content: View {
    
    // MARK: - Properties
    
    private let content: Content
    
    // MARK: - Initializer
    
    /// Creates a custom navigation stack with the specified content.
    ///
    /// - Parameter content: The content to be wrapped in the navigation stack.
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    // MARK: - View Body
    
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
            MaterialUIKit.tint.primaryBackground().ignoresSafeArea(.all)
            
            MaterialNavigationBarContainerView {
                content
                    .padding(MaterialUIKitConstants.insideMargin)
            }
            .navigationBarHidden(true)
        }
    }
}

// MARK: - MaterialNavigationHeader

private struct MaterialNavigationHeader: View {
    
    // MARK: - Properties
    
    let toolbar: EquatableViewContainer
    let title: String
    let headerStyle: MaterialNavigationHeaderStyle
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
    
    /// Returns a navigation header with large header style.
    private func largeHeader() -> some View {
        VStack(alignment: .leading, spacing: MaterialUIKitConstants.verticalContentPadding) {
            HStack {
                if showBackButton {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "arrow.left")
                            .font(.title3)
                    }
                    .tint(.muiPrimaryTitle)
                }
                
                toolbar.view
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Text(title)
                .font(.largeTitle)
                .fontWeightWithFallback(.semibold)
        }
        .foregroundStyle(.muiPrimaryTitle)
        .padding(.horizontal, 15)
        .padding(.vertical, 10)
    }
    
    /// Returns a navigation header with inline header style.
    private func inlineHeader() -> some View {
        HStack(spacing: 10) {
            if showBackButton {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.headline)
                }
            }
            
            Text(title)
                .font(.title2)
            
            Spacer()
            
            toolbar.view
        }
        .foregroundStyle(.muiPrimaryTitle)
        .padding(.horizontal, 15)
        .padding(.vertical, 10)
    }
}

// MARK: - MaterialNavigationBarContainerView

/// A container view that represents the navigation bar and content of a screen.
private struct MaterialNavigationBarContainerView<Content>: View where Content: View {
    
    // MARK: - Properties
    
    public let content: Content
    
    @State private var showBackButton: Bool = false
    @State private var headerStyle: MaterialNavigationHeaderStyle = .large
    @State private var title: String = ""
    @State private var toolbar: EquatableViewContainer = EquatableViewContainer(view: AnyView(EmptyView()))
    
    // MARK: - Initializer
    
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    // MARK: - View Body
    
    public var body: some View {
        VStack(spacing: 0) {
            MaterialNavigationHeader(
                toolbar: toolbar,
                title: title,
                headerStyle: headerStyle,
                showBackButton: showBackButton
            )
            
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

// MARK: - MaterialNavigationLink

/// A navigation link that wraps the destination in a MaterialUI-styled navigation bar.
public struct MaterialNavigationLink<Label, Destination>: View where Label: View, Destination: View {
    
    // MARK: - Properties
    
    private let destination: Destination
    private let label: Label
    
    // MARK: - Initializer
    
    public init(@ViewBuilder destination: () -> Destination, @ViewBuilder label: () -> Label) {
        self.destination = destination()
        self.label = label()
    }
    
    // MARK: - View Body
    
    public var body: some View {
        NavigationLink {
            destination
                .navigationBarHidden(true)
        } label: {
            label
                .padding(.horizontal, 4)
        }
    }
}

// MARK: - Preference Keys

/// Sets the title for the navigation bar.
private struct MUINavigaionBarTitlePreferenceKey: PreferenceKey {
    static var defaultValue: String = ""
    
    static func reduce(value: inout String, nextValue: () -> String) {
        value = nextValue()
    }
}

/// Sets the visibility of the back button in the navigation bar.
private struct MUINavigationBarBackButtonHiddenPreferenceKey: PreferenceKey {
    static var defaultValue: Bool = false
    
    static func reduce(value: inout Bool, nextValue: () -> Bool) {
        value = nextValue()
    }
}

/// Sets the style for the navigation bar header.
private struct MUINavigationTitleStylePreferenceKey: PreferenceKey {
    static var defaultValue: MaterialNavigationHeaderStyle = .large
    
    static func reduce(value: inout MaterialNavigationHeaderStyle, nextValue: () -> MaterialNavigationHeaderStyle) {
        value = nextValue()
    }
}

/// Sets the toolbar for the navigation bar.
private struct MUIToolbarViewPreferenceKey: PreferenceKey {
    static var defaultValue: EquatableViewContainer = EquatableViewContainer(view: AnyView(EmptyView()) )
    
    static func reduce(value: inout EquatableViewContainer, nextValue: () -> EquatableViewContainer) {
        value = nextValue()
    }
}

// MARK: - Extension View

extension View {
    
    /// Sets the title for the navigation bar.
    ///
    /// - Parameter title: The title to be displayed in the navigation bar.
    ///
    /// - Returns: A view modified to include the specified navigation bar title.
    public func muiNavigationTitle(_ title: String) -> some View {
        return self.preference(key: MUINavigaionBarTitlePreferenceKey.self, value: title)
    }
    
    /// Sets the style for the navigation bar header.
    ///
    /// - Parameter style: The style of the navigation bar header.
    ///
    /// - Returns: A view modified to include the specified navigation bar header style.
    public func muiNavigationHeaderStyle(_ style: MaterialNavigationHeaderStyle) -> some View {
        return self.preference(key: MUINavigationTitleStylePreferenceKey.self, value: style)
    }
    
    /// Sets the toolbar for the navigation bar.
    ///
    /// - Parameter toolbar: The toolbar to be displayed in the navigation bar.
    ///
    /// - Returns: A view modified to include the specified toolbar.
    public func muiToolbar<Toolbar: View>(toolbar: () -> Toolbar) -> some View {
        return self.preference(key: MUIToolbarViewPreferenceKey.self, value: EquatableViewContainer(view: AnyView(toolbar())))
    }
    
    /// Sets the visibility of the back button in the navigation bar.
    ///
    /// - Parameter hidden: A Boolean value indicating whether the back button should be hidden.
    ///
    /// - Returns: A view modified to include the specified back button visibility.
    public func muiNavigationBarBackButtonHidden(_ hidden: Bool) -> some View {
        return self.preference(key: MUINavigationBarBackButtonHiddenPreferenceKey.self, value: !hidden)
    }
    
    /// Sets the properties for the navigation bar.
    ///
    /// - Parameters:
    ///   - title: The title to be displayed in the navigation bar.
    ///   - backButtonHidden: A Boolean value indicating whether the back button should be hidden.
    ///   - style: The style of the navigation bar header.
    ///
    /// - Returns: A view modified to include the specified navigation bar properties.
    public func muiNavigationBar(title: String = "", backButtonHidden: Bool = false, style: MaterialNavigationHeaderStyle = .large) -> some View {
        self
            .muiNavigationTitle(title)
            .muiNavigationBarBackButtonHidden(backButtonHidden)
            .muiNavigationHeaderStyle(style)
    }
    
}

// MARK: - EquatableViewContainer

/// A container to hold an equatable view.
fileprivate struct EquatableViewContainer: Equatable {
    let id = UUID().uuidString
    let view:AnyView
    
    static func == (lhs: EquatableViewContainer, rhs: EquatableViewContainer) -> Bool {
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

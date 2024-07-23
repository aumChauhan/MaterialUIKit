//
// MaterialMenu.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 25/03/24
//

import SwiftUI

// MARK: - MaterialMenuLabel

/// A label view to create a row cells in a ``MaterialMenu``.
public struct MaterialMenuLabel: View {
    
    // MARK: - Properties
    
    private let systemName: String
    private let title: String
    
    // MARK: - Initializers
    
    /// Creates a menu label with the given system image and title.
    ///
    /// - Parameters:
    ///   - systemName: The name of the system image.
    ///   - title: The title displayed next to the system image.
    public init(systemName: String, _ title: String) {
        self.systemName = systemName
        self.title = title
    }
    
    // MARK: - View Body
    
    public var body: some View {
        HStack(spacing: MaterialUIKit.configuration.horizontalStackSpacing) {
            Image(systemName: systemName)
                .foregroundStyle(.materialAccent)
            
            Text(title)
                .font(MaterialUIKit.configuration.h4)
                .foregroundStyle(.materialPrimaryTitle)
        }
        // .padding(.leading, 4)
    }
}

// MARK: - MaterialMenuViewLayout

/// A layout view that arranges the menu items vertically.
fileprivate struct MaterialMenuViewLayout: _VariadicView_UnaryViewRoot {
    @ViewBuilder
    func body(children: _VariadicView.Children) -> some View {
        VStack(spacing: MaterialUIKit.configuration.verticalStackSpacing) {
            ForEach(children) { child in
                child
                    .font(MaterialUIKit.configuration.h4)
                    .fontWeightWithFallback(.regular)
                    .foregroundStyle(.materialPrimaryTitle)
                    .align(.leading)
                
                if child.id != children.last?.id {
                    MaterialDivider()
                }
            }
        }
    }
}

// MARK: - MaterialMenu

/// A Material UI style menu.
public struct MaterialMenu<Label, Content> : View where Label : View, Content : View {
    
    // MARK: - Properties
    
    @State private var height = 0.0
    @State private var showMenu: Bool = false
    @State private var screenWidth: Double = 0
    @State private var screenHeight: Double = 0
    @Binding private var isActive: Bool
    
    private var label: Label!
    private var content: Content!
    private var width: Double = 200
    
    // MARK: - Initializers
    
    /// Creates a menu with custom content and label.
    ///
    /// - Parameters:
    ///   - content: A closure that returns the content view for the menu.
    ///   - label: A closure that returns the label view for the menu.
    public init(
        @ViewBuilder content: () -> Content,
        @ViewBuilder label: () -> Label
    ) {
        self.content = content()
        self.label = label()
        self._isActive = .constant(false)
    }
    
    /// Creates a menu with a title-based label and custom content.
    ///
    /// - Parameters:
    ///   - title: A string representing the title of the menu button.
    ///   - content: A closure that returns the content view for the menu.
    public init<S>(
        _ title: S,
        @ViewBuilder content: () -> Content
    ) where Label == Text, S : StringProtocol {
        self.content = content()
        self.label = Text(title)
        self._isActive = .constant(false)
    }
    
    /// Creates a Material styled with custom content and label, and a binding to control its activation state.
    ///
    /// - Parameters:
    ///   - isActive: A binding to a Boolean value that indicates whether the menu is active.
    ///   - content: A closure that returns the content view for the menu.
    ///   - label: A closure that returns the label view for the menu.
    public init(
        isActive: Binding<Bool>,
        @ViewBuilder content: () -> Content,
        @ViewBuilder label: () -> Label
    ) {
        self.content = content()
        self.label = label()
        self._isActive = isActive
    }
    
    // MARK: - View Body
    
    public var body: some View {
        Button {
            withMaterialAnimation {
                showMenu.toggle()
            }
        } label: {
            label
                .tint(.materialAccent)
        }
        .onAppear {
            screenWidth = UIScreen.main.bounds.size.width
            screenHeight = UIScreen.main.bounds.size.height * 2
        }
        .overlay(backgroundOverlay())
        .overlay(menuOverlay())
        .onChangeWithFallback(of: isActive) { oldValue, newValue in
            withMaterialAnimation {
                showMenu.toggle()
            }
        }
    }
    
    // MARK: - Helpers
    
    /// Adds a background overlay to the menu, allowing to close the menu when tapped outside of it.
    func backgroundOverlay() -> some View {
        GeometryReader { geo in
            VStack {
                if showMenu {
                    Button {
                        withMaterialAnimation {
                            showMenu.toggle()
                        }
                    } label: {
                        Rectangle()
                            .foregroundStyle(.clear)
                            .contentShape(Rectangle())
                    }
                    .offset(x: -geo.frame(in: .global).origin.x)
                }
            }
        }
        .frame(width: screenWidth, height: screenHeight)
    }
    
    /// Creates the overlay for the menu content.
    @ViewBuilder func menuOverlay() -> some View {
        GeometryReader { geo in
            if showMenu {
                ZStack {
                    // Uses scrollable frame with fixed height
                    if height > 190 {
                        ScrollView {
                            _VariadicView.Tree(MaterialMenuViewLayout()) {
                                content
                            }
                            .contentShape(Rectangle())
                        }
                        .frame(width: 180, height: 190)
                    } else {
                        // Uses static vertical frame (for less content inside the menu) with dynamic height
                        VStack {
                            _VariadicView.Tree(MaterialMenuViewLayout()) {
                                content
                            }
                            .contentShape(Rectangle())
                        }
                        .frame(width: 180)
                    }
                }
                .padding(MaterialUIKit.configuration.contentPadding)
                .background(
                    GeometryReader { geo in
                        ZStack {
                            Color.materialSecondaryBackground
                                .shadow(color: .black.opacity(0.5), radius: 80, x: 0, y: 10)
                        }
                        .cornerRadius(MaterialUIKit.configuration.cornerRadius)
                        .onAppear {
                            self.height = geo.size.height
                        }
                    }
                )
                .offset(x: menuOffsetX(geo.frame(in: .global).origin.x), y: menuOffsetY(geo.frame(in: .global).origin.y))
                .transition(.scale.combined(with: .opacity))
            }
        }
        .frame(width: width, height: height)
    }
    
    /// Calculates the horizontal offset for the menu based on its position on the screen.
    func menuOffsetX(_ x: Double) -> Double {
        if x < 8 {
            return -x + 8
        } else if x + width > screenWidth - 8 {
            return screenWidth - x - width - 8
        } else {
            return 0
        }
    }
    
    /// Calculates the vertical offset for the menu based on its position on the screen.
    func menuOffsetY(_ y: Double) -> Double {
        return y > screenHeight / 3.5 ? -height / 1.5 + 16 : height / 2.0 + 16
    }
}

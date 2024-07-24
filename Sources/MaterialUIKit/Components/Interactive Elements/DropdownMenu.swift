//
// DropdownMenu.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 25/03/24
//

import SwiftUI

// MARK: - PUBLIC

/// A Material UI style dropdown menu.
public struct DropdownMenu<Label, Content> : View where Label : View, Content : View {
    
    // MARK: - PROPERTIES
    
    @State private var height = 0.0
    @State private var showMenu: Bool = false
    @State private var screenWidth: Double = 0
    @State private var screenHeight: Double = 0
    @Binding private var isActive: Bool
    
    private var label: Label!
    private var content: Content!
    private var width: Double = 200
    
    // MARK: - INITIALIZERS
    
    /// Creates a dropdown menu with custom content and label.
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
    
    /// Creates a dropdown menu with a title-based label and custom content.
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
    
    /// Creates a dropdown menu with custom content and label, and a binding to control its activation state.
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
    
    // MARK: - VIEW BODY
    
    public var body: some View {
        Button {
            withMaterialAnimation {
                showMenu.toggle()
            }
        } label: {
            label
                .tint(.materialUIAccent)
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
}

// MARK: - FILE PRIVATE

fileprivate extension DropdownMenu {
    
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
                            _VariadicView.Tree(DropdownMenuViewLayout()) {
                                content
                            }
                            .contentShape(Rectangle())
                        }
                        .frame(width: 180, height: 190)
                    } else {
                        // Uses static vertical frame (for less content inside the menu) with dynamic height
                        VStack {
                            _VariadicView.Tree(DropdownMenuViewLayout()) {
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
                            Color.materialUITertiaryBackground
                        }
                        .cornerRadius(MaterialUIKit.configuration.cornerRadius)
                        .shadow(color: .black.opacity(0.15), radius: 40, x: 0, y: geo.frame(in: .global).origin.y > screenHeight / 3.5 ? -10 : 10)
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

/// A layout view that arranges the menu items vertically.
fileprivate struct DropdownMenuViewLayout: _VariadicView_UnaryViewRoot {
    @ViewBuilder func body(children: _VariadicView.Children) -> some View {
        VStack(spacing: MaterialUIKit.configuration.verticalStackSpacing) {
            ForEach(children) { child in
                child
                    .font(MaterialUIKit.configuration.h4)
                    .fontWeightWithFallback(.regular)
                    .foregroundStyle(.materialUIPrimaryTitle)
                    .align(.leading)
                
                if child.id != children.last?.id {
                    Separator()
                }
            }
        }
    }
}

//
// MUITimePicker.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 30/12/23
//

import SwiftUI

// MARK: - Extension View

@available(iOS 17.0, *)
extension View {
    
    /// Presents a Material Design time picker.
    ///
    /// - Parameters:
    ///   - isPresented: A binding to control the presentation of the time picker.
    ///   - selection: A binding to manage the selected date.
    public func mUITimePicker(isPresented: Binding<Bool>, selection: Binding<Date>) -> some View {
        return self.modifier(MUITimePickerModifier(isPresented: isPresented, selection: selection))
    }
}

// MARK: - MUITimePickerModifier

/// A view modifier that adds the MaterialUI style time picker  presentation behavior to any view.
@available(iOS 17.0, *)
private struct MUITimePickerModifier: ViewModifier {
    
    // MARK: - Properties
    
    @Binding public var isPresented: Bool
    @Binding public var selection: Date
    
    // MARK: - Body
    
    func body(content: Content) -> some View {
        content.overlay(
            MUITimePickerView(isPresented: $isPresented, selection: $selection)
        )
    }
}

// MARK: - MUITimePickerView

/// A custom Material UI style time picker view that can be presented over other views.
@available(iOS 17.0, *)
private struct MUITimePickerView: View {
    
    // MARK: - Properties
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Environment(\.verticalSizeClass) private var verticalSizeClass
    @Environment(\.colorScheme) private var colorScheme
    
    @Binding public var isPresented: Bool
    @Binding public var selection: Date
    @State private var animationFlag: Bool = false
    
    // MARK: - View Body
    
    public var body: some View {
        ZStack {
            Color.gray.opacity(0.0)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading, spacing: 10) {
                // For portrait mode
                if horizontalSizeClass == .compact && verticalSizeClass == .regular {
                    portraitDatePicker()
                    
                    // For landscope mode
                } else if horizontalSizeClass == .compact && verticalSizeClass == .compact {
                    landscapeDatePicker()
                    
                    // Default
                } else {
                    portraitDatePicker()
                }
            }
            .padding(15)
            .background(MaterialUI.tint.iconColor(colorScheme))
            .cornerRadius(25)
            .padding(15)
            .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 1)
        }
        // In Animation
        .scaleEffect(animationFlag ? 1 : 0)
        .opacity(animationFlag ? 1 : 0)
        .onChange(of: isPresented) { oldValue, newValue in
            withAnimation(.bouncy) {
                animationFlag = isPresented
            }
        }
    }
}

// MARK: - Extension MUITimePickerView

@available(iOS 17.0, *)
extension MUITimePickerView {
    
    /// Returns the dismiss button bar for the time picker.
    private func dismissDatePicker() -> some View {
        HStack {
            Spacer()
            
            Button {
                withAnimation(.bouncy) {
                    isPresented.toggle()
                }
            } label: {
                Text("OK")
                    .textButtonStyle(10, colorScheme)
            }
        }
    }
    
    /// Returns the time picker view for portrait mode.
    private func portraitDatePicker() -> some View {
        VStack(alignment: .leading, spacing: 10) {
            // Time
            Text("\(selection.formatted(date: .omitted, time: .shortened))")
                .font(.title)
                .fontWeight(.medium)
                .foregroundColor(MaterialUI.tint.primaryTitle(colorScheme))
                .padding(.top, 5)
                .padding(.leading, 10)
            
            MUIDivider()
            
            // SwiftUI's default timepicker
            DatePicker("", selection: $selection, displayedComponents: .hourAndMinute)
                .datePickerStyle(.wheel)
                .tint(MaterialUI.tint.accent(colorScheme))
            
            MUIDivider()
            
            dismissDatePicker()
        }
    }
    
    /// Returns the time picker view for landscape mode.
    private func landscapeDatePicker() -> some View {
        VStack(alignment: .leading, spacing: 10) {
            // Time
            Text("\(selection.formatted(date: .omitted, time: .shortened))")
                .font(.title)
                .fontWeight(.medium)
                .foregroundColor(MaterialUI.tint.primaryTitle(colorScheme))
                .padding(.top, 5)
                .padding(.leading, 10)
            
            MUIDivider()
            
            ScrollView {
                // SwiftUI's default timepicker
                DatePicker("", selection: $selection, displayedComponents: .hourAndMinute)
                    .datePickerStyle(.wheel)
                    .tint(MaterialUI.tint.accent(colorScheme))
            }
            
            MUIDivider()
            
            dismissDatePicker()
        }
        .frame(width: UIScreen.main.bounds.height)
    }
}

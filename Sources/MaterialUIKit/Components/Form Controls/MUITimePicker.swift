//
// MUITimePicker.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 30/12/23
//

import SwiftUI

// MARK: - Extension View

@available(iOS 15.0, *)
extension View {
    
    /// Presents a Material Design time picker.
    ///
    /// - Parameters:
    ///   - isPresented: A binding to control the presentation of the time picker.
    ///   - selection: A binding to manage the selected date.
    public func muiTimePicker(isPresented: Binding<Bool>, selection: Binding<Date>) -> some View {
        return self.modifier(MUITimePickerModifier(isPresented: isPresented, selection: selection))
    }
}

// MARK: - MUITimePickerModifier

/// A view modifier that adds the MaterialUI style time picker  presentation behavior to any view.
@available(iOS 15.0, *)
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
@available(iOS 15.0, *)
private struct MUITimePickerView: View {
    
    // MARK: - Properties
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Environment(\.verticalSizeClass) private var verticalSizeClass
    
    @Binding public var isPresented: Bool
    @Binding public var selection: Date
    @State private var animationFlag: Bool = false
    
    // MARK: - View Body
    
    public var body: some View {
        ZStack {
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
            // Time picker styling
            .padding(20)
            .background(.muiTonal)
            .cornerRadius(MUIConstants.cornerRadius)
            // Stroke
            .padding(0.8)
            .background(.muiSecondaryTitle.opacity(0.4))
            .cornerRadius(MUIConstants.cornerRadius)
            // Scale-In animation
            .scaleEffect(animationFlag ? 1 : 0)
            .padding(20)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.45))
        // Opacity animation
        .opacity(animationFlag ? 1 : 0)
        .onChangeWithFallback(of: isPresented) { oldValue, newValue in
            withAnimation(.bouncy) {
                animationFlag = isPresented
            }
        }
    }
}

// MARK: - Extension MUITimePickerView

@available(iOS 15.0, *)
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
                    .textButtonStyle(10)
            }
        }
    }
    
    /// Returns the time picker view for portrait mode.
    private func portraitDatePicker() -> some View {
        VStack(alignment: .leading, spacing: 10) {
            // Time
            Text("\(selection.formatted(date: .omitted, time: .shortened))")
                .font(.title2)
                .fontWeightWithFallback(.medium)
                .foregroundStyle(.muiPrimaryTitle)
                .padding(.top, 5)
                .padding(.leading, 10)
            
            MUIDivider()
            
            // SwiftUI's default timepicker
            DatePicker("", selection: $selection, displayedComponents: .hourAndMinute)
                .datePickerStyle(.wheel)
                .tint(.muiAccent)
            
            MUIDivider()
            
            dismissDatePicker()
        }
    }
    
    /// Returns the time picker view for landscape mode.
    private func landscapeDatePicker() -> some View {
        VStack(alignment: .leading, spacing: 10) {
            // Time
            Text("\(selection.formatted(date: .omitted, time: .shortened))")
                .font(.title2)
                .fontWeightWithFallback(.medium)
                .foregroundStyle(.muiPrimaryTitle)
                .padding(.top, 5)
                .padding(.leading, 10)
            
            MUIDivider()
            
            ScrollView {
                // SwiftUI's default timepicker
                DatePicker("", selection: $selection, displayedComponents: .hourAndMinute)
                    .datePickerStyle(.wheel)
                    .tint(.muiAccent)
            }
            
            MUIDivider()
            
            dismissDatePicker()
        }
        .frame(width: UIScreen.main.bounds.height, height: UIScreen.main.bounds.height / 1.2)
    }
}

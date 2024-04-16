//
// MUIDatePicker.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 30/12/23
//

import SwiftUI

// MARK: - View Extension

@available(iOS 15.0, *)
extension View {
    
    /// Presents a Material Design date picker.
    ///
    /// - Parameters:
    ///   - isPresented: A binding to control the presentation of the date picker.
    ///   - selection: A binding to manage the selected date.
    public func muiDatePicker(isPresented: Binding<Bool>, selection: Binding<Date>) -> some View {
        return self.modifier(MUIDatePickerModifier(isPresented: isPresented, selection: selection))
    }
    
}

// MARK: - MUIDatePickerModifier

/// A view modifier that adds the MaterialUI style date picker  presentation behavior to any view.
@available(iOS 15.0, *)
private struct MUIDatePickerModifier: ViewModifier {
    
    // MARK: - Properties
    
    @Binding internal var isPresented: Bool
    @Binding internal var selection: Date
    
    // MARK: - Body
    
    func body(content: Content) -> some View {
        content.overlay(
            MUIDatePickerView(isPresented: $isPresented, selection: $selection)
        )
    }
}

// MARK: - MUIDatePickerView

/// A custom Material UI style date picker view that can be presented over other views.
@available(iOS 15.0, *)
private struct MUIDatePickerView: View {
    
    // MARK: - Properties
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Environment(\.verticalSizeClass) private var verticalSizeClass
    
    @Binding internal var isPresented: Bool
    @Binding internal var selection: Date
    @State private var animationFlag: Bool = false
    
    // MARK: - View Body
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 10) {
                if horizontalSizeClass == .compact && verticalSizeClass == .regular {
                    // For portrait mode
                    portraitDatePicker()
                } else if horizontalSizeClass == .compact && verticalSizeClass == .compact {
                    // For landscope mode
                    landscapeDatePicker()
                } else {
                    portraitDatePicker()
                }
            }
            // Date picker styling
            .padding(20)
            .background(.muiTonal)
            .cornerRadius(MUIConstants.cornerRadius)
            // Stroke
            .padding(0.8)
            .background(.muiSecondaryTitle.opacity(0.5))
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

// MARK: - Extension MUIDatePickerView

@available(iOS 15.0, *)
extension MUIDatePickerView {
    
    /// Returns the dismiss button bar for the date picker.
    private func dismissDatePicker() -> some View {
        HStack {
            Spacer()
            
            Button {
                withAnimation {
                    isPresented.toggle()
                }
            } label: {
                Text("OK")
                    .textButtonStyle(10)
            }
        }
    }
    
    /// Returns the date picker view for portrait mode.
    private func portraitDatePicker() -> some View {
        VStack(alignment: .leading, spacing: 10) {
            // Selected date
            Text("\(selection.formattedMUIDate())")
                .font(.title2)
                .fontWeightWithFallback(.medium)
                .foregroundStyle(.muiPrimaryTitle)
                .padding(.top, 5)
                .padding(.leading, 10)
            
            MUIDivider()
            
            // SwiftUI's default datepicker
            DatePicker("", selection: $selection, displayedComponents: .date)
                .datePickerStyle(.graphical)
                .tint(.muiAccent)
            
            MUIDivider()
            
            dismissDatePicker()
        }
    }
    
    /// Returns the date picker view for landscape mode.
    private func landscapeDatePicker() -> some View {
        VStack(alignment: .leading, spacing: 10) {
            // Selected date
            Text("\(selection.formattedMUIDate())")
                .font(.title2)
                .fontWeightWithFallback(.medium)
                .foregroundStyle(.muiPrimaryTitle)
                .padding(.top, 5)
                .padding(.leading, 10)
            
            MUIDivider()
            
            ScrollView {
                // SwiftUI's default datepicker
                DatePicker("", selection: $selection, displayedComponents: .date)
                    .datePickerStyle(.graphical)
                    .tint(.muiAccent)
            }
            
            MUIDivider()
            
            dismissDatePicker()
        }
        .frame(width: UIScreen.main.bounds.height, height: UIScreen.main.bounds.height / 1.2)
    }
}

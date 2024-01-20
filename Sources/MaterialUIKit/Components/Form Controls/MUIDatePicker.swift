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
    public func mUIDatePicker(isPresented: Binding<Bool>, selection: Binding<Date>) -> some View {
        return self.modifier(MUIDatePickerModifier(isPresented: isPresented, selection: selection))
    }
    
}

// MARK: - MUIDatePickerModifier

/// A view modifier that adds the MaterialUI style date picker  presentation behavior to any view.
@available(iOS 15.0, *)
private struct MUIDatePickerModifier: ViewModifier {
    
    // MARK: - Properties
    
    @Binding public var isPresented: Bool
    @Binding public var selection: Date
    
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
    
    @Binding public var isPresented: Bool
    @Binding public var selection: Date
    @State private var animationFlag: Bool = false
    
    // MARK: - View Body
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.0)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading, spacing: 10) {
                if horizontalSizeClass == .compact && verticalSizeClass == .regular { // For portrait mode
                    
                    portraitDatePicker()
                    
                } else if horizontalSizeClass == .compact && verticalSizeClass == .compact { // For landscope mode
                    
                    landscapeDatePicker()
                    
                } else { // Default̉
                    portraitDatePicker()
                }
            }
            .padding(15)
            .background(MaterialUI.tint.iconColor())
            .cornerRadius(25)
            .padding(15)
            .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 1)
        }
        // In Animation
        .scaleEffect(animationFlag ? 1 : 0)
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
                .font(.title)
                .fontWeightWithFallback(.medium)
                .foregroundColor(MaterialUI.tint.primaryTitle())
                .padding(.top, 5)
                .padding(.leading, 10)
            
            MUIDivider()
            
            // SwiftUI's default datepicker
            DatePicker("", selection: $selection, displayedComponents: .date)
                .datePickerStyle(.graphical)
                .tint(MaterialUI.tint.accent())
            
            MUIDivider()
            
            dismissDatePicker()
        }
    }
    
    /// Returns the date picker view for landscape mode.
    private func landscapeDatePicker() -> some View {
        VStack(alignment: .leading, spacing: 10) {
            // Selected date
            Text("\(selection.formattedMUIDate())")
                .font(.title)
                .fontWeightWithFallback(.medium)
                .foregroundColor(MaterialUI.tint.primaryTitle())
                .padding(.top, 5)
                .padding(.leading, 10)
            
            MUIDivider()
            
            ScrollView {
                // SwiftUI's default datepicker
                DatePicker("", selection: $selection, displayedComponents: .date)
                    .datePickerStyle(.graphical)
                    .tint(MaterialUI.tint.accent())
            }
            
            MUIDivider()
            
            dismissDatePicker()
        }
        .frame(width: UIScreen.main.bounds.height)
    }
}

// MARK: - Extension Date

/// An extension on `Date` to format dates in a specific format.
@available(iOS 15.0, *)
extension Date {
    
    /// Formats the date in the "E, MMM D" style.
    /// - Returns: A formatted string representing the date.
    public func formattedMUIDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, MMM d"
        return dateFormatter.string(from: self)
    }
}

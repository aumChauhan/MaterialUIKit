//
// MaterialTimePicker.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 30/12/23
//

import SwiftUI

extension View {
    
    /// Presents a Material Design styled time picker.
    ///
    /// - Parameters:
    ///   - isPresented: A binding to control the presentation of the time picker.
    ///   - selection: A binding to manage the selected date.
    public func muiTimePicker(isPresented: Binding<Bool>, selection: Binding<Date>) -> some View {
        return self.modifier(MaterialTimePickerModifier(isPresented: isPresented, selection: selection))
    }
}

// MARK: - MaterialTimePickerModifier

/// A view modifier that adds time picker to any view.
private struct MaterialTimePickerModifier: ViewModifier {
    
    // MARK: - Properties
    
    @Binding internal var isPresented: Bool
    @Binding internal var selection: Date
    
    // MARK: - Body
    
    func body(content: Content) -> some View {
        content.overlay(
            MaterialTimePickerView(isPresented: $isPresented, selection: $selection)
        )
    }
}

// MARK: - MaterialTimePickerView

/// A Material UI styled time picker.
@available(iOS 15.0, *)
private struct MaterialTimePickerView: View {
    
    // MARK: - Properties
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Environment(\.verticalSizeClass) private var verticalSizeClass
    
    @Binding internal var isPresented: Bool
    @Binding internal var selection: Date
    @State private var animationFlag: Bool = false
    
    // MARK: - View Body
    
    public var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 10) {
                if horizontalSizeClass == .compact && verticalSizeClass == .regular {
                    portraitDatePicker()
                } else if horizontalSizeClass == .compact && verticalSizeClass == .compact {
                    landscapeDatePicker()
                } else {
                    portraitDatePicker()
                }
            }
            .padding(20)
            .background(.muiTonal)
            .cornerRadius(MaterialUIKitConstants.cornerRadius)
            .padding(0.8)
            .background(.muiSecondaryTitle.opacity(0.4))
            .cornerRadius(MaterialUIKitConstants.cornerRadius)

            .scaleEffect(animationFlag ? 1 : 0)
            .padding(20)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.45))
        .opacity(animationFlag ? 1 : 0)
        .onChangeWithFallback(of: isPresented) { oldValue, newValue in
            withAnimation(.bouncy) {
                animationFlag = isPresented
            }
        }
    }
    
    // MARK: - Helpers

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
                        .textStyledBackground(10)
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
                
                MaterialDivider()
                
                // SwiftUI's default timepicker
                DatePicker("", selection: $selection, displayedComponents: .hourAndMinute)
                    .datePickerStyle(.wheel)
                    .tint(.muiAccent)
                
                MaterialDivider()
                
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
                
                MaterialDivider()
                
                ScrollView {
                    // SwiftUI's default timepicker
                    DatePicker("", selection: $selection, displayedComponents: .hourAndMinute)
                        .datePickerStyle(.wheel)
                        .tint(.muiAccent)
                }
                
                MaterialDivider()
                
                dismissDatePicker()
            }
            .frame(width: UIScreen.main.bounds.height, height: UIScreen.main.bounds.height / 1.2)
        }
}

//
// MaterialTimePicker.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 30/12/23
//

import SwiftUI

extension View {
    
    /// Presents a Material UI style time picker.
    ///
    /// - Parameters:
    ///   - isPresented: A binding to control the presentation of the time picker.
    ///   - selection: A binding to manage the selected date.
    public func materialTimePicker(isPresented: Binding<Bool>, selection: Binding<Date>) -> some View {
        return self.modifier(MaterialTimePickerViewModifier(isPresented: isPresented, selection: selection))
    }
}

// MARK: - MaterialTimePickerViewModifier

/// A view modifier that adds time picker to any view.
fileprivate struct MaterialTimePickerViewModifier: ViewModifier {
    
    // MARK: - Properties
    
    @Binding var isPresented: Bool
    @Binding var selection: Date
    
    // MARK: - Body
    
    func body(content: Content) -> some View {
        content.overlay(
            MaterialTimePickerView(isPresented: $isPresented, selection: $selection)
        )
    }
}

// MARK: - MaterialTimePickerView

/// A Material UI styled time picker.
fileprivate struct MaterialTimePickerView: View {
    
    // MARK: - Properties
    
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Environment(\.verticalSizeClass) private var verticalSizeClass
    
    @Binding var isPresented: Bool
    @Binding var selection: Date
    @State private var animationFlag: Bool = false
    
    // MARK: - View Body
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: MaterialUIKit.configuration.stackSpacing) {
                if horizontalSizeClass == .compact && verticalSizeClass == .regular {
                    portraitDatePicker()
                } else if horizontalSizeClass == .compact && verticalSizeClass == .compact {
                    landscapeDatePicker()
                } else {
                    portraitDatePicker()
                }
            }
            .frame(width: UIScreen.main.bounds.width/1.3)
            .primaryBackground()
            .scaleEffect(animationFlag ? 1 : 1.1)
        }
        .modalBackdrop(isPresented: $isPresented, animationFlag: $animationFlag)
    }
    
    /// Returns the dismiss button bar for the time picker.
    private func dismissDatePicker() -> some View {
        Button {
            withMaterialAnimation {
                isPresented.toggle()
            }
        } label: {
            Text("OK")
                .textStyledBackground()
        }
        .align(.trailing)
    }
    
    /// Returns the time picker view for portrait mode.
    private func portraitDatePicker() -> some View {
        VStack {
            Text("\(selection.formatted(date: .omitted, time: .shortened))")
                .font(.title)
                .padding(.top, MaterialUIKit.configuration.verticalPadding)
                .fontWeightWithFallback(.medium)
                .foregroundStyle(.materialPrimaryTitle)
            
            MaterialDivider()
            
            DatePicker("", selection: $selection, displayedComponents: .hourAndMinute)
                .datePickerStyle(.wheel)
                .tint(.materialAccent)
            
            dismissDatePicker()
        }
    }
    
    /// Returns the time picker view for landscape mode.
    private func landscapeDatePicker() -> some View {
        VStack {
            Text("\(selection.formatted(date: .omitted, time: .shortened))")
                .font(.title)
                .padding(.top, MaterialUIKit.configuration.verticalPadding)
                .fontWeightWithFallback(.medium)
                .foregroundStyle(.materialPrimaryTitle)
            
            MaterialDivider()
            
            ScrollView {
                DatePicker("", selection: $selection, displayedComponents: .hourAndMinute)
                    .datePickerStyle(.wheel)
                    .tint(.materialAccent)
            }
            
            dismissDatePicker()
        }
        .frame(width: UIScreen.main.bounds.height, height: UIScreen.main.bounds.height/1.2)
    }
}

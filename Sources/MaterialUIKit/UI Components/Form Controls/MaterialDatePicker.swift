//
// MaterialDatePicker.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 30/12/23
//

import SwiftUI

extension View {
    
    /// Presents a Material UI style date picker.
    ///
    /// - Parameters:
    ///   - isPresented: A binding to control the presentation state of the date picker.
    ///   - selection: A binding to manage the selected date.
    public func materialDatePicker(isPresented: Binding<Bool>, selection: Binding<Date>) -> some View {
        return self.modifier(MaterialDatePickerViewModifier(isPresented: isPresented, selection: selection))
    }
    
}

// MARK: - MaterialDatePickerViewModifier

/// A view modifier that adds date picker presentation behavior to any view.
fileprivate struct MaterialDatePickerViewModifier: ViewModifier {
    
    // MARK: - Properties
    
    @Binding var isPresented: Bool
    @Binding var selection: Date
    
    // MARK: - Body
    
    func body(content: Content) -> some View {
        content.overlay(
            MaterialDatePickerView(isPresented: $isPresented, selection: $selection)
        )
    }
}

// MARK: - MaterialDatePickerView

/// A Material Design styled date picker.
fileprivate struct MaterialDatePickerView: View {
    
    // MARK: - Properties
    
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Environment(\.verticalSizeClass) private var verticalSizeClass
    
    @Binding var isPresented: Bool
    @Binding var selection: Date
    @State private var animationFlag: Bool = false
    
    // MARK: - View Body
    
    var body: some View {
        VStack(alignment: .leading) {
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
        .modalBackdrop(isPresented: $isPresented, animationFlag: $animationFlag)
    }
    
    /// Returns the dismiss button bar for the date picker.
    private func dismissDatePicker() -> some View {
        Button {
            withMaterialAnimation {
                isPresented.toggle()
            }
        } label: {
            Text("Okay")
                .font(MaterialUIKit.configuration.h4)
                .fontWeightWithFallback(.semibold)
        }
        .tint(.materialAccent)
        .align(.trailing)
        .padding(.horizontal, 10)
    }
    
    /// Returns the date picker view for portrait mode.
    private func portraitDatePicker() -> some View {
        VStack(alignment: .leading) {
            Text("\(selection.formattedMUIDate())")
                .font(MaterialUIKit.configuration.h1)
                .fontWeightWithFallback(.medium)
                .foregroundStyle(.materialPrimaryTitle)

            MaterialDivider()
            
            DatePicker("", selection: $selection, displayedComponents: .date)
                .datePickerStyle(.graphical)
                .tint(.materialAccent)
            
            dismissDatePicker()
        }
    }
    
    /// Returns the date picker view for landscape mode.
    private func landscapeDatePicker() -> some View {
        VStack(alignment: .leading) {
            Text("\(selection.formattedMUIDate())")
                .font(MaterialUIKit.configuration.h1)
                .fontWeightWithFallback(.medium)
                .foregroundStyle(.materialPrimaryTitle)
            
            MaterialDivider()
            
            ScrollView {
                DatePicker("", selection: $selection, displayedComponents: .date)
                    .datePickerStyle(.graphical)
                    .tint(.materialAccent)
            }
            
            dismissDatePicker()
        }
        .frame(height: UIScreen.main.bounds.height/1.3)
    }
}

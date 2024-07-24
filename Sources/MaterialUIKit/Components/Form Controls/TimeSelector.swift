//
// TimeSelector.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 30/12/23
//

import SwiftUI

extension View {
    
    /// Presents a Material UI style time selector.
    ///
    /// - Parameters:
    ///   - isPresented: A binding to control the presentation of the time picker.
    ///   - selection: A binding to manage the selected date.
    public func timeSelector(isPresented: Binding<Bool>, selection: Binding<Date>) -> some View {
        return self.modifier(TimeSelectorViewModifier(isPresented: isPresented, selection: selection))
    }
}

// MARK: - TimeSelectorViewModifier

/// A view modifier that adds time picker to any view.
fileprivate struct TimeSelectorViewModifier: ViewModifier {
    
    // MARK: - Properties
    
    @Binding var isPresented: Bool
    @Binding var selection: Date
    
    // MARK: - Body
    
    func body(content: Content) -> some View {
        content.overlay(
            TimePicker(isPresented: $isPresented, selection: $selection)
        )
    }
}

// MARK: - TimePicker

/// A Material UI styled time picker.
fileprivate struct TimePicker: View {
    
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
    
    /// Returns the dismiss button bar for the time picker.
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
        .tint(.materialUIAccent)
        .align(.trailing)
        .padding(.horizontal, 10)
    }
    
    /// Returns the time picker view for portrait mode.
    private func portraitDatePicker() -> some View {
        VStack {
            Text("\(selection.formatted(date: .omitted, time: .shortened))")
                .font(MaterialUIKit.configuration.h1)
                .fontWeightWithFallback(.medium)
                .foregroundStyle(.materialUIPrimaryTitle)
            
            Separator()
            
            DatePicker("", selection: $selection, displayedComponents: .hourAndMinute)
                .datePickerStyle(.wheel)
                .tint(.materialUIAccent)
            
            dismissDatePicker()
        }
    }
    
    /// Returns the time picker view for landscape mode.
    private func landscapeDatePicker() -> some View {
        VStack {
            Text("\(selection.formatted(date: .omitted, time: .shortened))")
                .font(MaterialUIKit.configuration.h1)
                .fontWeightWithFallback(.medium)
                .foregroundStyle(.materialUIPrimaryTitle)
            
            Separator()
            
            ScrollView {
                DatePicker("", selection: $selection, displayedComponents: .hourAndMinute)
                    .datePickerStyle(.wheel)
                    .tint(.materialUIAccent)
            }
            
            dismissDatePicker()
        }
        .frame(height: UIScreen.main.bounds.height/1.3)
    }
}

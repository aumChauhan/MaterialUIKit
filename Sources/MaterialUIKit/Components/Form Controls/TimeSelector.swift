//
// TimeSelector.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 30/12/23
//

import SwiftUI

// MARK: - PUBLIC

extension View {
    
    /// Presents a time selector with a binding to control the presentation state and a binding to manage the selected time.
    ///
    /// - Parameters:
    ///   - isPresented: A binding to control the presentation of the time picker.
    ///   - selection: A binding to manage the selected time.
    @available(iOS 15.0, *)
    public func timeSelector(isPresented: Binding<Bool>, selection: Binding<Date>) -> some View {
        return self.modifier(TimeSelectorViewModifier(isPresented: isPresented, selection: selection))
    }
}

// MARK: - FILE PRIVATE

/// Adds time picker over the view.
fileprivate struct TimeSelectorViewModifier: ViewModifier {
    
    // MARK: - PROPERTIES
    
    @Binding var isPresented: Bool
    @Binding var selection: Date
    
    // MARK: - BODY
    
    func body(content: Content) -> some View {
        content.overlay(
            TimePicker(isPresented: $isPresented, selection: $selection)
        )
    }
}

/// Represents a Material UI styled time selector for picking time values.
fileprivate struct TimePicker: View {
    
    // MARK: - PROPERTIES
    
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Environment(\.verticalSizeClass) private var verticalSizeClass
    
    @Binding var isPresented: Bool
    @Binding var selection: Date
    @State private var animationFlag: Bool = false
    
    // MARK: - VIEW BODY
    
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
        .secondaryBackground()
        .scaleEffect(animationFlag ? 1 : 1.1)
        .modalBackdrop(isPresented: $isPresented, animationFlag: $animationFlag)
        .hapticFeedbackOnChange(of: selection)
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

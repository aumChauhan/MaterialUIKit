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
            timePicker()
        }
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
            Text("Done")
                .font(MaterialUIKit.configuration.h4)
                .fontWeightWithFallback(.semibold)
        }
        .tint(.materialUIAccent)
        .align(.trailing)
        .padding(.horizontal, 10)
    }
    
    /// Returns the time picker view.
    private func timePicker() -> some View {
        VStack {
            Text("\(selection.formatted(date: .omitted, time: .shortened))")
                .font(MaterialUIKit.configuration.h1)
                .fontWeightWithFallback(.semibold)
                .foregroundStyle(.materialUIPrimaryTitle)
            
            Separator()
            
            DatePicker("", selection: $selection, displayedComponents: .hourAndMinute)
                .datePickerStyle(.wheel)
                .tint(.materialUIAccent)
                .if(isLandscape()) { view in
                    view
                }
            
            dismissDatePicker()
        }
        .frame(width: isLandscape() ? UIScreen.main.bounds.width/3 : UIScreen.main.bounds.width/1.3)
    }
    
    /// Determines whether the current device orientation is portrait.
    private func isPortrait() -> Bool {
        return horizontalSizeClass == .compact && verticalSizeClass == .regular
    }
    
    /// Determines whether the current device orientation is landscape.
    private func isLandscape() -> Bool {
        return horizontalSizeClass == .compact && verticalSizeClass == .compact
    }
}

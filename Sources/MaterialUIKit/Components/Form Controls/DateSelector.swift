//
// DateSelector.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 30/12/23
//

import SwiftUI

// MARK: - PUBLIC

extension View {
    
    /// Presents a date selector with a binding to control the presentation state and a binding to manage the selected date.
    ///
    /// - Parameters:
    ///   - isPresented: A binding to control the presentation state of the date picker.
    ///   - selection: A binding to manage the selected date.
    @available(iOS 15.0, *)
    public func dateSelector(isPresented: Binding<Bool>, selection: Binding<Date>) -> some View {
        return self.modifier(DateSelectorViewModifier(isPresented: isPresented, selection: selection))
    }
    
}

// MARK: - FILE PRIVATE

/// Adds date selector presentation over the view.
fileprivate struct DateSelectorViewModifier: ViewModifier {
    
    // MARK: - PROPERTIES
    
    @Binding var isPresented: Bool
    @Binding var selection: Date
    
    // MARK: - BODY
    
    func body(content: Content) -> some View {
        content.overlay(
            DateSelector(isPresented: $isPresented, selection: $selection)
        )
    }
}

/// Represents a Material UI styled date selector for picking date values.
fileprivate struct DateSelector: View {
    
    // MARK: - PROPERTIES
    
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Environment(\.verticalSizeClass) private var verticalSizeClass
    
    @Binding var isPresented: Bool
    @Binding var selection: Date
    @State private var animationFlag: Bool = false
    
    // MARK: - VIEW BODY
    
    var body: some View {
        VStack(alignment: .leading) {
            datePicker()
        }
        .secondaryBackground()
        .scaleEffect(animationFlag ? 1 : 1.1)
        .modalBackdrop(isPresented: $isPresented, animationFlag: $animationFlag)
        .hapticFeedbackOnChange(of: selection)
    }
    
    /// Returns the dismiss button bar for the date picker.
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
    
    /// Returns the date picker.
    private func datePicker() -> some View {
        VStack(alignment: .leading) {
            Text("\(selection.formattedMUIDate())")
                .font(MaterialUIKit.configuration.h1)
                .fontWeightWithFallback(.semibold)
                .foregroundStyle(.materialUIPrimaryTitle)
            
            Separator()
            
            DatePicker("", selection: $selection, displayedComponents: .date)
                .datePickerStyle(.graphical)
                .tint(.materialUIAccent)
                .if(isLandscape()) { view in
                    ScrollView { view }
                }
            
            dismissDatePicker()
        }
        .frame(width: isLandscape() ? UIScreen.main.bounds.width/2 : UIScreen.main.bounds.width/1.3)
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

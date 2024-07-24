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
    
    /// Presents a Material UI style date selector.
    ///
    /// - Parameters:
    ///   - isPresented: A binding to control the presentation state of the date picker.
    ///   - selection: A binding to manage the selected date.
    public func dateSelector(isPresented: Binding<Bool>, selection: Binding<Date>) -> some View {
        return self.modifier(DateSelectorViewModifier(isPresented: isPresented, selection: selection))
    }
    
}

// MARK: - FILE PRIVATE

/// A view modifier that adds date selector presentation behavior to any view.
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

/// A Material Design styled date selector.
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
        .tint(.materialUIAccent)
        .align(.trailing)
        .padding(.horizontal, 10)
    }
    
    /// Returns the date picker view for portrait mode.
    private func portraitDatePicker() -> some View {
        VStack(alignment: .leading) {
            Text("\(selection.formattedMUIDate())")
                .font(MaterialUIKit.configuration.h1)
                .fontWeightWithFallback(.medium)
                .foregroundStyle(.materialUIPrimaryTitle)

            Separator()
            
            DatePicker("", selection: $selection, displayedComponents: .date)
                .datePickerStyle(.graphical)
                .tint(.materialUIAccent)
            
            dismissDatePicker()
        }
    }
    
    /// Returns the date picker view for landscape mode.
    private func landscapeDatePicker() -> some View {
        VStack(alignment: .leading) {
            Text("\(selection.formattedMUIDate())")
                .font(MaterialUIKit.configuration.h1)
                .fontWeightWithFallback(.medium)
                .foregroundStyle(.materialUIPrimaryTitle)
            
            Separator()
            
            ScrollView {
                DatePicker("", selection: $selection, displayedComponents: .date)
                    .datePickerStyle(.graphical)
                    .tint(.materialUIAccent)
            }
            
            dismissDatePicker()
        }
        .frame(height: UIScreen.main.bounds.height/1.3)
    }
}

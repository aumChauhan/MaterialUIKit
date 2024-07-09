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
        return self.modifier(MaterialDatePickerModifier(isPresented: isPresented, selection: selection))
    }
    
}

// MARK: - MaterialDatePickerModifier

/// A view modifier that adds date picker presentation behavior to any view.
fileprivate struct MaterialDatePickerModifier: ViewModifier {
    
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
@available(iOS 15.0, *)
fileprivate struct MaterialDatePickerView: View {
    
    // MARK: - Properties
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Environment(\.verticalSizeClass) private var verticalSizeClass
    
    @Binding var isPresented: Bool
    @Binding var selection: Date
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
            .padding(20)
            .background(.materialTonal)
            .cornerRadius(MaterialUIKitConstants.cornerRadius)
            .padding(0.8)
            .background(.materialSecondaryTitle.opacity(0.5))
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
                    .textStyledBackground(10)
            }
        }
    }
    
    /// Returns the date picker view for portrait mode.
    private func portraitDatePicker() -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("\(selection.formattedMUIDate())")
                .font(.title2)
                .fontWeightWithFallback(.medium)
                .foregroundStyle(.materialPrimaryTitle)
                .padding(.top, 5)
                .padding(.leading, 10)
            
            MaterialDivider()
            
            DatePicker("", selection: $selection, displayedComponents: .date)
                .datePickerStyle(.graphical)
                .tint(.materialAccent)
            
            MaterialDivider()
            
            dismissDatePicker()
        }
    }
    
    /// Returns the date picker view for landscape mode.
    private func landscapeDatePicker() -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("\(selection.formattedMUIDate())")
                .font(.title2)
                .fontWeightWithFallback(.medium)
                .foregroundStyle(.materialPrimaryTitle)
                .padding(.top, 5)
                .padding(.leading, 10)
            
            MaterialDivider()
            
            ScrollView {
                DatePicker("", selection: $selection, displayedComponents: .date)
                    .datePickerStyle(.graphical)
                    .tint(.materialAccent)
            }
            
            MaterialDivider()
            
            dismissDatePicker()
        }
        .frame(width: UIScreen.main.bounds.height, height: UIScreen.main.bounds.height / 1.2)
    }
}

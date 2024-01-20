//
// View+FallbackModifiers.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 20/01/24
//

import Foundation
import SwiftUI

@available(iOS 15.0, *)
extension View {
    
    /// Adjusts font weight with fallback for older iOS versions.
    /// - Parameter weight: The font weight to apply of type `Font.Weight`.
    /// - Returns: A view with adjusted font weight.
    public func fontWeightWithFallback(_ weight: Font.Weight) -> some View {
        if #available(iOS 16.0, *) {
            return self
                .fontWeight(weight)
        } else {
            return self
                .font(Font.headline.weight(weight))
        }
    }
    
    /// Adds a modifier for this view that fires an action when a specific value changes with fallback for older iOS versions.
    /// - Parameters:
    ///   - value: The value to check against when determining whether
    ///     to run the closure.
    ///   - initial: Whether the action should be run when this view initially
    ///     appears.
    ///   - action: A closure to run when the value changes.
    ///   - oldValue: The old value that failed the comparison check (or the
    ///     initial value when requested).
    ///   - newValue: The new value that failed the comparison check.
    ///
    /// - Returns: A view that fires an action when the specified value changes.
    public func onChangeWithFallback<V>(of value: V, initial: Bool = false, _ action: @escaping (_ oldValue: V, _ newValue: V) -> Void) -> some View where V: Equatable {
        
        if #available(iOS 17.0, *) {
            return self
                .onChange(of: value) { oldValue, newValue in
                    action(oldValue, newValue)
                }
        } else {
            return self
                .onChange(of: value, perform: { newValue in
                    action(newValue, newValue)
                })
        }
    }
}

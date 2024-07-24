//
// MUICheckboxStyle.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 08/07/24
//

import SwiftUI

/// Visual representation of the Material design styled checkbox.
package struct MUICheckboxStyle: ToggleStyle {
    package func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
                .align(.leading)
            
            Image(systemName: configuration.isOn ? "checkmark.square.fill" : "square")
                .font(.title2)
                .foregroundStyle(configuration.isOn ? .materialUIAccent : .materialUIOnDisabled)
                .onTapGesture {
                    withAnimation(MaterialUIKit.configuration.animationType) {
                        configuration.isOn.toggle()
                    }
                }
        }
    }
}

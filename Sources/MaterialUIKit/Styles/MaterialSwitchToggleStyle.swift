//
// MaterialSwitchToggleStyle.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 13/07/24
//

import SwiftUI

/// Visual representation of the Material Design styled toggle switch.
package struct MaterialSwitchToggleStyle: ToggleStyle {
    package func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            
            Spacer()
            
            RoundedRectangle(cornerRadius: MaterialUIKit.configuration.cornerRadius)
                .foregroundStyle(configuration.isOn ? .materialAccent : .materialPrimaryBackground)
                .frame(width: 42, height: 24)
                .overlay(alignment: configuration.isOn ? .trailing : .leading) {
                    Circle()
                        .frame(width: configuration.isOn ? 18 : 14)
                        .foregroundStyle(configuration.isOn ? .materialTonal : .materialOnDisabled)
                        .padding(.horizontal, configuration.isOn ? 2 : 4)
                }
                .overlay(
                    RoundedRectangle(cornerRadius: .infinity)
                        .stroke(.materialOutline, lineWidth: MaterialUIKit.configuration.borderWidth)
                        .frame(maxWidth: .infinity)
                )
                .onTapGesture {
                    withAnimation(MaterialUIKit.configuration.animationType) {
                        configuration.isOn.toggle()
                    }
                }
        }
    }
}

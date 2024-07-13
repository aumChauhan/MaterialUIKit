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
        HStack(alignment: .center) {
            configuration.label

            Spacer()
            
            RoundedRectangle(cornerRadius: 20)
                .foregroundStyle(configuration.isOn ? .materialAccent : .materialPrimaryBackground)
                .frame(width: 40, height: 22)
                .overlay(alignment: configuration.isOn ? .trailing : .leading) {
                    Circle()
                        .frame(width: 18)
                        .foregroundStyle(configuration.isOn ? .materialTonal : .materialSecondaryTitle)
                        .padding(.horizontal, 2)
                }
                .overlay(
                    RoundedRectangle(cornerRadius: .infinity)
                        .stroke(.materialSecondaryTitle, lineWidth: MaterialUIKit.configuration.borderWidth)
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

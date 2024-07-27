//
// MaterialClassic.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 06/07/24
//

import SwiftUI

/// The `MaterialClassic` provides a predefined color scheme with a classic appearance.
package struct MaterialClassic: ColorScheme {
    package var accent = Color(lightHex: "246488", darkHex: "94CDF8")
    
    package var tonal = Color(lightHex: "EDF2F6", darkHex: "202529")
    
    package var primaryBackground = Color(lightHex: "f8f9fa", darkHex: "212529")
    
    package var secondaryBackground = Color(lightHex: "e9ecef", darkHex: "343a40")
    
    package var tertiaryBackground = Color(lightHex: "dee2e6", darkHex: "495057")
    
    package var quaternaryBackground = Color(lightHex: "ced4da", darkHex: "6c757d")
    
    package var primaryTitle = Color(lightHex: "343a40", darkHex: "e9ecef")
    
    package var secondaryTitle = Color(lightHex: "6c757d", darkHex: "ced4da")
    
    package var highlight = Color(lightHex: "246488", darkHex: "94CDF8")
    
    package var separator: Color = Color(lightHex: "ced4da", darkHex: "6c757d")
    
    package var onError: Color = Color(lightHex: "8b575c", darkHex: "c98986")
    
    package var onDisabled: Color = Color(lightHex: "33415c", darkHex: "7d8597")
    
    package var outline: Color = Color(lightHex: "33415c", darkHex: "7d8597")
}

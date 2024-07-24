//
// MaterialClassic.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 06/07/24
//

import SwiftUI

/// A default implementation of a classic Material color scheme.
public struct MaterialClassic: MUIColorScheme {
    public var accent = Color(lightHex: "246488", darkHex: "94CDF8")
    
    public var tonal = Color(lightHex: "EDF2F6", darkHex: "202529")
    
    public var primaryBackground = Color(lightHex: "f8f9fa", darkHex: "212529")
    
    public var secondaryBackground = Color(lightHex: "e9ecef", darkHex: "343a40")
    
    public var tertiaryBackground = Color(lightHex: "dee2e6", darkHex: "495057")
    
    public var quaternaryBackground = Color(lightHex: "ced4da", darkHex: "6c757d")
    
    public var primaryTitle = Color(lightHex: "343a40", darkHex: "e9ecef")
    
    public var secondaryTitle = Color(lightHex: "6c757d", darkHex: "ced4da")
        
    public var highlight = Color(lightHex: "246488", darkHex: "94CDF8")
    
    public var separator: Color = Color(lightHex: "ced4da", darkHex: "6c757d")
    
    public var onError: Color = Color(lightHex: "8b575c", darkHex: "c98986")
    
    public var onDisabled: Color = Color(lightHex: "33415c", darkHex: "7d8597")
    
    public var outline: Color = Color(lightHex: "33415c", darkHex: "7d8597")
}

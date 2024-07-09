//
// DefaultColorScheme.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 06/07/24
//

import SwiftUI

public struct DefaultColorScheme: MaterialColorScheme {
    public var error: Color = Color(lightHex: "DB362E", darkHex: "F2B8B6")
    
    public var accent = Color(lightHex: "246488", darkHex: "94CDF8")
    
    public var tonal = Color(lightHex: "EDF2F6", darkHex: "202529")
    
    public var primaryBackground = Color(lightHex: "f8f9fa", darkHex: "#212529")
    
    public var secondaryBackground = Color(lightHex: "e9ecef", darkHex: "343a40")
    
    public var tertiaryBackground = Color(lightHex: "dee2e6", darkHex: "495057")
    
    public var primaryTitle = Color(lightHex: "212529", darkHex: "f8f9fa")
    
    public var secondaryTitle = Color(lightHex: "495057", darkHex: "dee2e6")
    
    public var quaternaryBackground = Color(lightHex: "ced4da", darkHex: "6c757d")
    
    public var highlight = Color(lightHex: "33415c", darkHex: "5c677d")
}

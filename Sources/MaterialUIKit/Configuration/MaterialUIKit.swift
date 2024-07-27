//
// MaterialUIKit.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 30/12/23
//

import SwiftUI

/// MaterialUIKit module containing configuration settings.
///
/// This class provides a centralized place for configuring global settings for MaterialUIKit components.
/// It includes options for setting layout, styling, and feedback properties that apply to all MaterialUIKit elements.
@available(iOS 15.0, *)
open class MaterialUIKit {
    
    /// A static instance of `MUIKitConfiguration` that holds the global configuration settings for MaterialUIKit components.
    ///
    /// Use this property to customize the appearance and behavior of MaterialUIKit components throughout your app.
    public static var configuration: MUIKitConfiguration = MUIKitConfiguration()
}


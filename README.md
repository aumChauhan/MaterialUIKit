# MaterialUIKit

Material Design-inspired UI components for SwiftUI.

## Overview
                                            
MaterialUIKit is a SwiftUI package offering a set of user interface components inspired by Google's Material Design. These components are designed to provide a consistent and visually appealing look to your SwiftUI applications.


## Requirements

- Xcode 14.0 and above
- iOS 17.0 and above

## Installation

To integrate MaterialUIKit into your project, you can use `CocoaPods` or `Swift Package Manager`.
                                            
<details>
<summary> CocoaPods </summary>
                                            
Add the following line to your Podfile:

```ruby
pod 'MaterialUIKit'
```

Then run `pod install` to install the framework.
                                            
</details>

<details>
<summary> Swift Package Manager </summary>

In Xcode, go to File -> Swift Packages -> Add Package Dependency and enter the repository URL:

```other
https://github.com/aumChauhan/MaterialUIKit.git
```
                                            
</details>

## Getting Started

- To quickly enhance your SwiftUI app with MaterialUI components, **Set Color Palette Tint:** Customize the color palette used throughout MaterialUI components by setting the `tint` property. Add this code to your app's entry point.

```swift
import SwiftUI
import MaterialUIKit

@main
struct YourApp: App {
    init() {
        MaterialUI.tint = MaterialUIColorThemes.blue
    }

    var body: some Scene {
        // Your app's main scene configuration
    }
}
```
`MaterialUIColorThemes` include Blue, Green, Pink, and Purple color palettes.

> NOTE: If you don't explicitly set a theme in the `init` block, MaterialUI will use the Pink theme by default.

## Documentation

Detailed documentation for each component can be found [here](DOCUMENTATION). Make sure to check it out for comprehensive usage examples and customization options.

## License

MaterialUIKit is released under the [MIT License](LICENSE)

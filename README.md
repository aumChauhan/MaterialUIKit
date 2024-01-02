![MUILogo70x70](https://github.com/aumChauhan/MaterialUIKit/assets/83302656/cd2d537e-436b-4ca2-b5e6-0893894192e2)

# MaterialUIKit

Material Design-inspired UI components for SwiftUI.

## Overview
                                            
MaterialUIKit is a SwiftUI package offering a set of user interface components inspired by Google's Material Design. These components are designed to provide a consistent and visually appealing look to your SwiftUI applications.

## Requirements

- Xcode 14.0 and above
- iOS 17.0 and above

## Preview

<details>
  <summary> Get a glimpse of MaterialUI components: </summary>
  
### Alert
  ![Alert](https://github.com/aumChauhan/MaterialUIKit/assets/83302656/f3098833-2f6e-4758-a5a3-9da37c72aa97)

### Button
![Button](https://github.com/aumChauhan/MaterialUIKit/assets/83302656/8a1fa8ab-84ab-4058-bfa1-a8aa8d7da1b6)

### Card View
![CardView](https://github.com/aumChauhan/MaterialUIKit/assets/83302656/366b24f4-78a1-4c67-bde6-76ce3e83c2b8)

### Checkbox
![Checkbox](https://github.com/aumChauhan/MaterialUIKit/assets/83302656/2fdcfad1-7456-4e0f-94c5-00a683627539)

### Date Picker
![DatePicker](https://github.com/aumChauhan/MaterialUIKit/assets/83302656/ce23247f-4fa4-4c75-9841-8c062902adbc)

### Floating Button
![FAB](https://github.com/aumChauhan/MaterialUIKit/assets/83302656/fca45946-4c95-4d65-b834-054763e456ba)

### Icon Button
![IconButton](https://github.com/aumChauhan/MaterialUIKit/assets/83302656/001f5052-38e6-46c0-aa06-f187b690730c)

### List
![List](https://github.com/aumChauhan/MaterialUIKit/assets/83302656/00589eb0-14bf-445a-a525-20a02dbf4065)

### Navigation View
![NavigationView](https://github.com/aumChauhan/MaterialUIKit/assets/83302656/f94f73cb-0a8d-4f49-b122-3c8ce46b9614)

### Progress View
![ProgressView](https://github.com/aumChauhan/MaterialUIKit/assets/83302656/6ab95c67-6b4a-4618-a2d7-c421df4e4e79)

### SearchBar
![SearchBar](https://github.com/aumChauhan/MaterialUIKit/assets/83302656/40b05fa6-24a5-41fe-9e2b-d89b4fb14611)

### Segmented Control
![SegmentedControl](https://github.com/aumChauhan/MaterialUIKit/assets/83302656/4e048a08-c759-4b59-8d18-bbd6568e1bcd)

### Snackbar
![SnackBar](https://github.com/aumChauhan/MaterialUIKit/assets/83302656/aa5bd193-4463-48f4-8d30-7415fa13630f)

### Switch
![Switch](https://github.com/aumChauhan/MaterialUIKit/assets/83302656/fe3c6276-1c2b-4acd-a5df-1145dc999d45)

### TabView
![TabVIew](https://github.com/aumChauhan/MaterialUIKit/assets/83302656/f38be0ad-8195-466b-a889-470813b2db5c)

### TimePicker
![TimePicker](https://github.com/aumChauhan/MaterialUIKit/assets/83302656/bca2c916-e30f-40b6-969e-6703b865b37d)

### Text & Secure Field
![TextField](https://github.com/aumChauhan/MaterialUIKit/assets/83302656/093b5ed5-1d39-4ba4-966d-ef68fc5f0939)

</details>

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

Detailed documentation for each component can be found [here](https://github.com/aumChauhan/MaterialUIKit/blob/main/DOCUMENTATION.md). Make sure to check it out for comprehensive usage examples and customization options.

## License

MaterialUIKit is released under the [MIT License](LICENSE)


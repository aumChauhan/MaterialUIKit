# MaterialUIKit Documentation

## Form Controls

<details>
<summary>Date Picker</summary>

# MUIDatePicker

The `MUIDatePicker` SwiftUI component provides a Material Design-style date picker with customizable appearance and behavior.

## Usage

To use the `MUIDatePicker`, you can apply the `mUIDatePicker` view modifier to any SwiftUI view. This will present a Material Design-style date picker over the existing content.

```swift
MUIDatePicker(isPresented: $isDatePickerPresented, selection: $selectedDate)
```

## Parameters

- `isPresented`: A binding to control the presentation of the date picker.
- `selection`: A binding to manage the selected date.

## Example

```swift
struct ContentView: View {
    @State private var isDatePickerPresented = false
    @State private var selectedDate = Date()

    var body: some View {
        VStack {
            Button("Show Date Picker") {
                isDatePickerPresented.toggle()
            }
            .mUIDatePicker(isPresented: $isDatePickerPresented, selection: $selectedDate)
        }
    }
}
```

## Date Formatting

The date picker includes a formatted representation of the selected date. The `formattedMUIDate` method is used to format the date as "E, MMM d". The formatting can be customized as needed.

Feel free to integrate this Material Design-style date picker into your SwiftUI app to provide an enhanced and consistent user experience for date selection.

</details>

<details>
<summary>Time Picker</summary>

# MUITimePicker

The `MUITimePicker` SwiftUI component provides a Material Design-style time picker with customizable appearance and behavior.

## Usage

To use the `MUITimePicker`, you can add the `mUITimePicker` modifier to any SwiftUI view. Below is an example of how to use it:

```swift
struct ContentView: View {
    @State private var isTimePickerPresented = false
    @State private var selectedTime = Date()

    var body: some View {
        VStack {
            Button("Open Time Picker") {
                isTimePickerPresented.toggle()
            }
            .mUITimePicker(isPresented: $isTimePickerPresented, selection: $selectedTime)
        }
    }
}
```

This example demonstrates how to use the `MUITimePicker` in a SwiftUI view. The time picker is presented when the button is tapped, and the selected time is bound to a `Date` variable.

## Parameters

- `isPresented`: A binding to control the presentation of the time picker.
- `selection`: A binding to manage the selected date.

## Example

```swift
struct ContentView: View {
    @State private var isTimePickerPresented = false
    @State private var selectedTime = Date()

    var body: some View {
        VStack {
            Button("Select Time") {
                isTimePickerPresented.toggle()
            }
            .mUITimePicker(isPresented: $isTimePickerPresented, selection: $selectedTime)
        }
    }
}
```

</details>

<details>
<summary> TextField </summary>

# MUITextField

The `MUITextField` SwiftUI component provides a Material Design-style text field with customizable appearance and behavior.

## Usage

To use the `MUITextField`, you can instantiate it with different parameters based on your needs. Below are the available initializers:

### Basic Usage

```swift
MUITextField("Username", text: $username)
```

### With System Symbol

```swift
MUITextField(systemSymbol: "person", "Username", text: $username)
```

### With System Symbol and Custom Background

```swift
MUITextField(systemSymbol: "person", "Username", text: $username, background: .green)
```

## Parameters

- `text`: A binding to the text value of the text field.
- `systemSymbol`: System symbol for the text field (optional).
- `titleKey`: Title key for the text field.
- `background`: Custom background color for the text field (optional).

## Example

```swift
struct ContentView: View {
    @State private var username = ""

    var body: some View {
        VStack {
            MUITextField("Username", text: $username)
            .padding()
        }
    }
}
```

</details>

<details>
<summary> SecureField </summary>

# MUISecureField

The `MUISecureField` SwiftUI component provides a Material Design-style secure field with customizable appearance and behavior.

## Usage

To use the `MUISecureField`, you can instantiate it with different parameters based on your needs. Below are the available initializers:

### Basic Usage

```swift
MUISecureField("Password", text: $password)
```

### With System Symbol

```swift
MUISecureField(systemSymbol: "lock", "Password", text: $password)
```

### With System Symbol and Custom Background

```swift
MUISecureField(systemSymbol: "lock", "Password", text: $password, .blue)
```

## Parameters

- `text`: A binding to the text value of the secure field.
- `systemSymbol`: System symbol for the secure field (optional).
- `titleKey`: Title key for the secure field.
- `background`: Custom background color for the secure field (optional).

## Example

```swift
struct ContentView: View {
    @State private var password = ""

    var body: some View {
        VStack {
            MUISecureField("Password", text: $password)
            .padding()
        }
    }
}
```
</details>

## Interactive Elements

<details>
<summary> Button </summary>

# MUIButton

The `MUIButton` SwiftUI component provides a versatile button with various styles to suit different design needs.

## Usage

To use the MUIButton, you can create an instance of it by providing a title, style, and an action closure. Below is an example of how to use it:

## Parameters

- `title`: The text to display on the button.
- `style`: The style of the button.
- `action`: The closure to execute when the button is pressed.

## `MUIButtonStyle`

- `.elevated`: A button with an elevated background and rounded corners.
- `.filled`: A button with a filled background and rounded corners.
- `.tonal`: A button with a tonal background and rounded corners.
- `.outline`: A button with an outlined border and rounded corners.
- `.text`: A text-only button with no background.
- `.elevatedInfinity`: A button with an elevated background and rounded corners, occupying full available width.
- `.filledInfinity`: A button with a filled background and rounded corners, occupying full available width.
- `.tonalInfinity`: A button with a tonal background and rounded corners, occupying full available width.
- `.outlineInfinity`: A button with an outlined border and rounded corners, occupying full available width.

## Example

```swift
MUIButton("Title", action: {
    // Action
})

MUIButton("Title", style: .elevated, action: {
    // Action
})
```

</details>


<details>
<summary> Card </summary>

# MUICardView

The `MUICardView` SwiftUI component represents a MaterialUI style card.

## Usage

To use MUICardView, you can create an instance by providing the necessary parameters. There are two initializers available for creating cards with automatic or specified layouts and styles.

## Parameters
- `heading`: The heading text of the card.
- `subheading`: The subheading text of the card.
- `image`: The image name for the card.
- `cardType`: The type of card layout.
- `cardStyle`: The style of the card.
- `content`: The content view of the card.

## `MUICardType`

An enumeration to specify the type of card layout.

- `.automatic`: Automatically determines the card layout based on content.
- `.horizontal`: Horizontal card layout.
- `.stack`: Stack card layout.

## `MUICardStyle`

An enumeration to specify the style of the card.

- `.elevated`: Elevated card style.
- `.tonal`: Tonal card style.

## Example
- Default Card: The card type is set to `.automatic`, and the card style is set to .tonal.

```swift
MUICardView(
    heading: "Automatic Card",
    subheading: "Subtitle",
    image: "cardImage",
    content: {
        Text("Content goes here.")
    }
)
```

- Custom Card: The card type is set to `.horizontal`, and the card style is set to `.elevated`. Additional content, such as a Text view, can be added.

```swift
MUICardView(
    heading: "Custom Card",
    subheading: "Subtitle",
    image: "cardImage",
    cardType: .horizontal,
    cardStyle: .elevated,
    content: {
        Text("Content goes here.")
    }
)
```

</details>

<details>
<summary> Checkbox </summary>

# MUICheckbox

`MUICheckbox` provides a checkbox with a clean and modern MaterialUI design. It allows users to toggle between the checked and unchecked states by tapping the checkbox.

## Usage

To use `MUICheckbox`, create an instance by providing the necessary parameters.

## Parameters

- `title: String`: The title of the checkbox.
- `isOn: Binding<Bool>`: A binding to a boolean value that determines the on/off state of the checkbox.

## Example

```swift
@State private var isChecked: Bool = false

MUICheckbox("Enable Feature", isOn: $isChecked)
    .padding()
```

</details>

<details>
<summary> Floating Button </summary>

# MUIFloatingButton

A SwiftUI button designed for floating action button (FAB) functionality with various initialization options. MUIIconButton provides the flexibility to create circular icon buttons with different styles, allowing you to choose from elevated, filled, tonal, or secondary background styles.

## Parameters
- `systemSymbol`: SF Symbol string for system-provided icons.
- `image`: Custom SwiftUI `Image` for a personalized button icon.
- `title`: Optional title for a textual label beside the button.
- `action`: The closure to execute when the button is pressed.

## Usage
To use MUIFloatingButton, create an instance by choosing the appropriate initialization option based on your design preferences.

## Example
```swift
// Example with SF Symbol
MUIFloatingButton(systemSymbol: "plus", title: "Add") {
    // Action to perform when the button is pressed
}

// Example with custom image
MUIFloatingButton(image: "customIcon", title: "Custom") {
    // Action to perform when the button is pressed
}
```
</details>

<details>
<summary> Icon Button </summary>

# MUIIconButton

`MUIIconButton` provides the flexibility to create circular icon buttons with different styles, allowing you to choose from elevated, filled, tonal, or secondary background styles.

## Usage
To use `MUIIconButton`, create an instance by choosing the appropriate style based on your design preferences.

## Parameters

- `systemSymbol: String?`: SF Symbol string for system-provided icons.
- `image: String?`: String representing the name of a custom image.
- `style: MUIIconButtonStyle`: The style of the button, defined by `MUIIconButtonStyle`.
- `action: () -> Void`: The closure to execute when the button is pressed.

## Example

```swift
// Example with SF Symbol
MUIIconButton(systemSymbol: "heart.fill", style: .elevated) {
    // Action to perform when the button is pressed
}

// Example with custom image
MUIIconButton("customImage", style: .filled) {
    // Action to perform when the button is pressed
}
```

</details>

<details>
<summary> Switch </summary>

# MUISwitch

`MUISwitch` is a SwiftUI view representing a MaterialUI style switch.it provides a custom-styled switch with a MaterialUI design, offering a unique appearance for toggling between states.

## Usage

To use `MUISwitch`, create an instance by providing the title and a binding to a boolean value that determines the on/off state of the switch.

## Parameters

- `title: String`: The title of the switch.
- `isOn: Binding<Bool>`: A binding to a boolean value that determines the on/off state of the switch.

## Example

```swift
MUISwitch("Enable Feature", isOn: $isEnabled)
    .tint(MaterialUI.tint.accent(colorScheme))
    .padding()
```

</details>

## Dialog & Alerts

<details>
<summary> Alerts </summary>


# MUIAlert

`MUIAlert` provides a convenient way to present a MaterialUI style alert over the current view.

`.mUIAlert()` is an extension to the `View` protocol in SwiftUI, offering a modifier that can be applied to any view. This modifier presents a MaterialUI style alert with customizable parameters such as title, message, primary button title, and actions associated with primary and secondary buttons.

## Usage

To use `MUIAlert`, apply the `mUIAlert` modifier to a SwiftUI view and provide the necessary parameters:

## Parameters

- `isPresented: Binding<Bool>`: Binding to control the presentation state of the alert.
- `title: String`: The title of the alert.
- `message: String?`: The message displayed in the alert (optional).
- `primaryButtonTitle: String`: The title of the primary (main) button.
- `primaryAction: @escaping () -> Void`: The action to be executed when the primary button is tapped.
- `secondaryButtonTitle: String?`: The title of the secondary button (optional).
- `secondaryAction: (() -> Void)?`: The action to be executed when the secondary button is tapped (optional).

## Example

```swift
struct ContentView: View {
    @State private var showAlert = false

    var body: some View {
        VStack {
            Button("Show Alert") {
                showAlert.toggle()
            }
            .mUIAlert(
                isPresented: $showAlert,
                title: "Alert Title",
                message: "This is a sample alert message.",
                primaryButtonTitle: "OK",
                primaryAction: {
                    // Handle OK button tap
                },
                secondaryButtonTitle: "Cancel",
                secondaryAction: {
                    // Handle Cancel button tap
                }
            )
        }
    }
}
```

</details>

<details>
<summary> Snackbar </summary>

# MUISnackbar
`MUISnackbar` provides a customizable MaterialUI style snackbar that can be displayed at the bottom of the screen.

`.mUISnackbar()` is an extension to the `View` protocol in SwiftUI, offering a modifier that can be applied to any view. This modifier presents a MaterialUI style snackbar with customizable parameters such as message, duration, and an optional primary action button.

## Usage

To use `MUISnackbar`, apply the `mUISnackbar` modifier to a SwiftUI view and provide the necessary parameters:

## Parameters

- `isPresented: Binding<Bool>`: Binding to control the presentation state of the snackbar.
- `message: String`: The message displayed in the snackbar.
- `duration: Double?`: The duration (in seconds) for which the snackbar is visible before automatically toggling off (optional, default is 5 seconds).
- `primaryButtonTitle: String?`: The title of the primary (main) button (optional).
- `primaryAction: (() -> Void)?`: The action to be executed when the primary button is tapped (optional).

## Example

```swift
struct ContentView: View {
    @State private var showSnackbar = false

    var body: some View {
        VStack {
            Button("Show Snackbar") {
                showSnackbar.toggle()
            }
            .mUISnackbar(
                isPresented: $showSnackbar,
                message: "This is a sample snackbar message.",
                duration: 3,
                primaryButtonTitle: "Dismiss",
                primaryAction: {
                    // Handle dismiss button tap
                }
            )
        }
    }
}
```
</details>

## Navigation & Structure

<details>
<summary> List </summary>

# MUIList
`MUIList` is a SwiftUI view that provides a MaterialUI-styled list with various visual styles. The `MUIList` view is designed to display a collection of elements with different visual styles such as plain, inset, or insetGrouped. It conforms to the MaterialUI design principles, providing a consistent and aesthetically pleasing list layout.

## Usage

To use `MUIList`, create an instance of the view by specifying the data, a key path to uniquely identify each element, and a closure that returns the content view for a given element. Additionally, you can customize the list style.

## Parameters

- `data: Data`: A collection of elements to display in the list.
- `id: KeyPath<Data.Element, ID>`: A key path to an `ID` property on each element to uniquely identify them.
- `listStyle: MUIListStyle`: The style of the list, such as `.plain`, `.inset`, or `.insetGrouped`.
- `content: (Data.Element) -> Content`: A closure that returns the content view for a given element.

## Example

```swift
struct ContentView: View {
    let items = ["Item 1", "Item 2", "Item 3"]

    var body: some View {
        MUIList(items, id: \.self, listStyle: .insetGrouped) { item in
            Text(item)
        }
    }
}
```
</details>

<details>
<summary> Navigation View </summary>

# MUINavigationView

`MUINavigationView` is a custom navigation view that provides a MaterialUI-styled navigation bar. It wraps the specified content in a visually appealing navigation bar, allowing you to create a consistent and polished look for your app's navigation.

## Usage

### Creating a Basic MUINavigationView

```swift
MUINavigationView {
    // Your content goes here
    Text("Hello, World!")
}
```

### Customizing the Navigation Bar
- You can customize the appearance of the navigation bar using modifiers provided by the `MUINavigationView`.

```swift
MUINavigationView {
    // Your content goes here
    Text("Hello, World!")

    .mUINavigationTitle("My Title") // Set the title of the navigation bar
    
    .mUINavigationHeaderStyle(.large) // Set the style of the navigation bar header
    
    .mUIToolbar {
        // Your toolbar content goes here
        Button("Action") {
            // Handle the action
        }
    }
    
    .mUINavigationBarBackButtonHidden(true) // Hide the back button
}

```

### Using `MUINavigationLink`:
- `MUINavigationLink` is a navigation link that automatically embeds the destination view in a `MUINavigationView`.

```swift
MUINavigationLink(destination: {
    // Your destination content goes here
    Text("Destination View")
}, label: {
    // Your label content goes here
    Text("Go to Destination")
})
```

## MUINavigationHeaderStyle

`MUINavigationHeaderStyle` is an enumeration representing different styles for navigation bar headers.

- `.large`: A large-style navigation bar header.
- `.inline`: An inline-style navigation bar header.

</details>

<details>
<summary> Tab View</summary>

# MUITabView

The `MUITabView` SwiftUI component combines main content with a MaterialUI-style tab bar for easy navigation.

## Usage

### Tab Item
- To set up a tab bar item with a specified system image, title, and selection binding, use the `mUITabBarItem` modifier:

```swift
YourView()
    .mUITabBarItem(systemImage: "heart.fill", title: "Favorites", selection: $selection)
```

### Tab View
- Create a `MUITabBarView` by wrapping your main content with the tab bar:

```swift
MUITabBarView(selection: $selection) {
    YourContentView()
        .mUITabBarItem(systemImage: "house.fill", title: "Home", selection: $selection)
    AnotherView()
        .mUITabBarItem(systemImage: "heart.fill", title: "Favorites", selection: $selection)
    YetAnotherView()
        .mUITabBarItem(systemImage: "person.fill", title: "Profile", selection: $selection)
}
```

</details>

<details>
<summary> Segmented Control </summary>

# MUISegmentedControl

The `MUISegmentedControl` SwiftUI component provides a segmented control with customizable appearance and behavior.

## Usage

To use the `MUISegmentedControl`, create an instance of it by passing a collection of elements, a key path to uniquely identify each element, and a binding to the currently selected element. Customize the appearance of each segment using the `content` closure.

```swift
MUISegmentedControl(["Option 1", "Option 2", "Option 3"], id: \.self, selectedItem: $selectedOption) { option in
    Text(option)
        .padding(10)
}
```

## Parameters

- `data`: A collection of elements to display in the segmented control.
- `id`: A key path to a property on each element to uniquely identify them.
- `selectedItem`: A binding to the currently selected element in the segmented control.
- `content`: A closure that returns the content view for a given element.

## Example

```swift
struct ContentView: View {
    @State private var selectedOption = "Option 1"

    var body: some View {
        MUISegmentedControl(["Option 1", "Option 2"], id: \.self, selectedItem: $selectedOption) { option in
            Text(option)
                .padding(10)
        }
    }
}
```

</details>

## Presentation

<details>
<summary> Divider </summary>

# MUIDivider

The `MUIDivider` SwiftUI component represents a MaterialUI-style divider with customizable orientation.

## Usage

To use the `MUIDivider`, create an instance of it and include it in your SwiftUI view. You can create both horizontal and vertical dividers.

```swift
MUIDivider() // Horizontal divider
```

```swift
MUIDivider(.vertical) // Vertical divider
```

## Parameters

- `orientation`: An enum specifying the orientation of the divider. Choose between `.horizontal` (default) and `.vertical`.

## Example

```swift
struct ContentView: View {
    var body: some View {
        VStack {
            Text("Content Above Divider")
            MUIDivider()
            Text("Content Below Divider")
        }
    }
}
```
</details>


<details>
<summary> Progress View </summary>

# MUIProgressView

The `MUIProgressView` SwiftUI component represents a MaterialUI-style progress view with customizable line width.

## Usage

To use the `MUIProgressView`, create an instance of it and include it in your SwiftUI view. You can create a progress view with the default line width or specify a custom line width.

```swift
MUIProgressView() // Default line width
```

```swift
MUIProgressView(lineWidth: 5) // Custom line width
```

## Parameters

- `lineWidth`: A CGFloat representing the stroke width of the progress view. Use it to customize the thickness of the progress indicator's stroke. Default is 3.

## Example

```swift
struct ContentView: View {
    var body: some View {
        VStack {
        Text("Loading...")
        MUIProgressView()
        }
    }
}
```
</details>

## Search

<details>
<summary> SearchBar </summary>

# MUISearchBar

The `MUISearchBar` SwiftUI component represents a MaterialUI-style search bar with a customizable placeholder and search text binding.

## Usage

To use the `MUISearchBar`, create an instance of it and include it in your SwiftUI view. You can create a search bar with the default placeholder text or specify a custom placeholder text.

```swift
MUISearchBar(searchText: $searchText, action)
```

```swift
MUISearchBar("Find items", searchText: $searchText, action)
```

## Parameters

- `searchText`: A binding to the text that the user enters into the search bar.
- `action`: A closure to execute when the user triggers the search action.
- `placeholder`: A String representing the placeholder text to display when the search bar is empty. Default is "Search".

## Example

```swift
struct ContentView: View {
    @State private var searchText = ""

    var body: some View {
        MUISearchBar(searchText: $searchText) {
        // Perform search action here
        print("Searching for: \(searchText)")
    }
    .padding()
    }
}
```
</details>

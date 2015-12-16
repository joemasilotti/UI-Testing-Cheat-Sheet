# UI Testing Cheat Sheet

This repository is complementary code for my post, [UI Testing Cheat Sheet and Examples](http://masilotti.com/ui-testing-cheat-sheet/). The post goes into more detail with example images for most examples.

The included Xcode 7 project highlights working code with a simple Test Host. This was last updated for Xcode 7 GM.

## Contents

- [Basic Functionality](https://github.com/joemasilotti/UI-Testing-Cheat-Sheet#basic-functionality)
  - [Testing if an element exists](https://github.com/joemasilotti/UI-Testing-Cheat-Sheet#testing-if-an-element-exists) 
  - [Waiting for an element to appear](https://github.com/joemasilotti/UI-Testing-Cheat-Sheet#waiting-for-an-element-to-appear) 
- [Interacting with System Controls](https://github.com/joemasilotti/UI-Testing-Cheat-Sheet#interacting-with-system-controls)
  - [Tapping buttons](https://github.com/joemasilotti/UI-Testing-Cheat-Sheet#tapping-buttons) 
  - [Typing text](https://github.com/joemasilotti/UI-Testing-Cheat-Sheet#typing-text) 
  - [Dismissing alerts](https://github.com/joemasilotti/UI-Testing-Cheat-Sheet#dismissing-alerts) 
  - [Handling system alerts](https://github.com/joemasilotti/UI-Testing-Cheat-Sheet#handling-system-alerts) 
  - [Sliding sliders](https://github.com/joemasilotti/UI-Testing-Cheat-Sheet#sliding-sliders) 
  - [Interacting with pickers](https://github.com/joemasilotti/UI-Testing-Cheat-Sheet#interacting-with-pickers) 
  - [Tapping links in web views](https://github.com/joemasilotti/UI-Testing-Cheat-Sheet#tapping-links-in-web-views) 
- [Interactions](https://github.com/joemasilotti/UI-Testing-Cheat-Sheet#interactions)
  - [Verifying the current controller's title](https://github.com/joemasilotti/UI-Testing-Cheat-Sheet#verifying-the-current-controllers-title) 
  - [Reordering table cells](https://github.com/joemasilotti/UI-Testing-Cheat-Sheet#reordering-table-cells) 
  - [Pull to refresh](https://github.com/joemasilotti/UI-Testing-Cheat-Sheet#pull-to-refresh) 
  - [Pushing and popping view controllers](https://github.com/joemasilotti/UI-Testing-Cheat-Sheet#pushing-and-popping-view-controllers)

## Basic Functionality

### Testing if an element exists

````swift
XCTAssert(app.staticTexts["Welcome"].exists)
````

### Waiting for an element to appear
Set up an expectation to use with `XCTest`. The predicate will wait until the element's `-exist` property is true.

````swift
let goLabel = self.app.staticTexts["Go!"]
XCTAssertFalse(goLabel.exists)

let exists = NSPredicate(format: "exists == true")
expectationForPredicate(exists, evaluatedWithObject: goLabel, handler: nil)

app.buttons["Ready, set..."].tap()
waitForExpectationsWithTimeout(5, handler: nil)
XCTAssert(goLabel.exists)
````

## Interacting with System Controls

### Tapping buttons
Identify buttons by their accessibility label.

````swift
app.buttons["Add"].tap()
````

### Typing text
First make sure the text field has focus by tapping on it.

````swift
let textField = app.textFields["Username"]
textField.tap()
textField.typeText("joemasilotti")
````

### Dismissing alerts
````swift
app.alerts["Alert Title"].buttons["Button Title"].tap()
````

### Handling system alerts
Present a location services authorization dialog to the user and dismiss it with the following code.

Before presenting the alert add a UI Interuption Handler. When this fires, dismiss with the "Allow" button.

````swift
addUIInterruptionMonitorWithDescription("Location Services") { (alert) -> Bool in
  alert.buttons["Allow"].tap()
  return true
}

app.buttons["Request Location"].tap()
app.tap() // need to interact with the app again for the handler to fire
````

### Sliding sliders
This will slide the value of the slider to 70%.

````swift
app.sliders.element.adjustToNormalizedSliderPosition(0.7)
````

### Interacting with pickers
A picker with one wheel:

````swift
app.pickerWheels.element.adjustToPickerWheelValue("Picker Wheel Item Title")
````

A picker with multiple wheels. Make sure to set the accessibility delegate so the framework can identify the different wheels.

````swift
let firstPredicate = NSPredicate(format: "label BEGINSWITH 'First Picker'")
let firstPicker = app.pickerWheels.elementMatchingPredicate(firstPredicate)
firstPicker.adjustToPickerWheelValue("first value")

let secondPredicate = NSPredicate(format: "label BEGINSWITH 'Second Picker'")
let secondPicker = app.pickerWheels.elementMatchingPredicate(secondPredicate)
secondPicker.adjustToPickerWheelValue("second value")

````

### Tapping links in web views
````swift
app.links["Tweet this"].tap()
````

## Interactions

### Verifying the current controller's title
````swift
XCTAssert(app.navigationBars["Details"].exists)
````

### Reordering table cells
If you have a `UITableViewCell` with default style and set the text to "Title", the reorder control's accessibility label becomes "Reorder Title".

Using this we can drag one reorder control to another, essentially reordering the cells.

````swift
let topButton = app.buttons["Reorder Top Cell"]
let bottomButton = app.buttons["Reorder Bottom Cell"]
bottomButton.pressForDuration(0.5, thenDragToElement: topButton)

XCTAssertLessThanOrEqual(bottomButton.frame.maxY, topButton.frame.minY)
````

### Pull to refresh

Create a `XCUICoordinate` from the first cell in your table and another one with a `dy` of six. Then drag the first coordinate to the second.

````swift
let firstCell = app.staticTexts["Adrienne"]
let start = firstCell.coordinateWithNormalizedOffset(CGVectorMake(0, 0))
let finish = firstCell.coordinateWithNormalizedOffset(CGVectorMake(0, 6))
start.pressForDuration(0, thenDragToCoordinate: finish)
````

### Pushing and popping view controllers

Test if a view controller was pushed onto the navigation stack.

```swift
app.buttons["More Info"].tap()
XCTAssert(app.navigationBars["Volleyball?"].exists)
```

Pop a view controller by tapping the back button in the navigation bar and assert that the title in the navigation bar has changed.

```swift
app.navigationBars.buttons.elementBoundByIndex(0).tap()
XCTAssert(app.navigationBars["Volley"].exists)
```
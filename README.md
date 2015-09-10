# UI Testing Cheat Sheet

The included Xcode 7 project highlights working code with a simple Test Host. This was last updated for Xcode 7 GM.

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

let existsPredicate = NSPredicate(format: "exists == 1")
expectationForPredicate(existsPredicate, evaluatedWithObject: goLabel, handler: nil)

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

Note that this will correctly dismiss the alert, but the test suite will crash. See [radar://4979891669827584](http://openradar.appspot.com/radar?id=4979891669827584).

````swift
app.alerts.buttons["Allow"].tap()
````

### Sliding sliders
This will slide the value of the slider to 70%.

````swift
app.sliders.element.adjustToNormalizedSliderPosition(0.7)
````

### Interacting with pickers
````swift
app.pickerWheels.element.adjustToPickerWheelValue("Picker Wheel Item Title")
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

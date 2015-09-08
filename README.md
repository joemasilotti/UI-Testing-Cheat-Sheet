# UI Testing Cheat Sheet

The included Xcode 7 project highlights working code with a simple Test Host. This was last updated for Xcode 7 Beta 6.

## Basic Functionality

### Testing if an element exists

````swift
XCTAssert(app.buttons["Bump, Set..."].exists)
````

### Waiting for an element to appear
````swift
let zeroLabel = self.app.staticTexts["0"]
XCTAssertFalse(zeroLabel.exists)

let existsPredicate = NSPredicate(format: "exists == 1")
expectationForPredicate(existsPredicate, evaluatedWithObject: zeroLabel, handler: nil)

app.buttons["5, 4, 3, 2..."].tap()
waitForExpectationsWithTimeout(5, handler: nil)
XCTAssert(zeroLabel.exists)
````

## Interacting with System Controls

### Tapping buttons
````swift
XCTAssertFalse(app.staticTexts["Spike!"].exists)
app.buttons["Bump, Set..."].tap()
XCTAssert(app.staticTexts["Spike!"].exists)
````

### Typing text
````swift
let textField = app.textFields["Team Name"]
textField.tap()
textField.typeText("Dig Newtons")
````

### Dismissing alerts
````swift
app.buttons["End Game"].tap()
app.alerts["You won!"].buttons["Awesome!"].tap()
````

### Handling system alerts (broken, see [radar://4979891669827584](http://openradar.appspot.com/radar?id=4979891669827584))
````swift
app.buttons["Where did you play?"].tap()
app.alerts.buttons["Allow"].tap() // works, but crashes the test suite.
XCTAssert(app.staticTexts["Authorized"].exists)
````

### Sliding sliders
````swift
app.sliders.element.adjustToNormalizedSliderPosition(0.7)
XCTAssert(app.staticTexts["7"].exists)
````

### Interacting with pickers
````swift
let selectedFormationLabel = app.staticTexts["6-2 Formation"]
XCTAssertFalse(selectedFormationLabel.exists)

app.pickerWheels.element.adjustToPickerWheelValue("6-2 Formation")
XCTAssert(selectedFormationLabel.exists)
````

### Tapping links in web views
````swift
app.buttons["More Information"].tap() // loads https://wikipedia.org/wiki/Volleyball
app.links["Volleyball (disambiguation)"].tap()
````

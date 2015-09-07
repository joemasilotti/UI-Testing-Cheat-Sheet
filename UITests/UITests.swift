//
//  UITests.swift
//  UITests
//
//  Created by Joe Masilotti on 9/7/15.
//  Copyright © 2015 Masilotti.com. All rights reserved.
//

import XCTest

class UI_Testing_Cheat_SheetUITests: XCTestCase {
    let app = XCUIApplication()

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app.launch()
    }

    func testElementExists() {
        XCTAssert(app.buttons["Bump, Set..."].exists)
    }

    func testTappingAButton() {
        XCTAssertFalse(app.staticTexts["Spike!"].exists)

        app.buttons["Bump, Set..."].tap()
        XCTAssert(app.staticTexts["Spike!"].exists)
    }

    func testTypingText() {
        let textField = app.textFields["Team Name"]
        textField.tap()
        textField.typeText("Dig Newtons")
    }

    func testDismissingAnAlert() {
        app.buttons["End Game"].tap()
        app.alerts["You won!"].buttons["Awesome!"].tap()
    }

    /* By not starting this test with "test" it will not be run.
     * This test is not being run because dismissing the system alert
     * causes the test suite to crash.
     * Bug report: http://openradar.appspot.com/radar?id=4979891669827584
    */
    func _testDismissingASystemAlert() {
        app.buttons["Where did you play?"].tap()
        app.alerts.buttons["Allow"].tap() // works, but crashes the test suite.
        XCTAssert(app.staticTexts["Authorized"].exists)
    }

    func testAdjustingASlider() {
        app.sliders.element.adjustToNormalizedSliderPosition(0.7)
        XCTAssert(app.staticTexts["7"].exists)
    }

    func testAdjustingAPicker() {
        let selectedFormationLabel = app.staticTexts["6-2 Formation"]
        XCTAssertFalse(selectedFormationLabel.exists)

        app.pickerWheels.element.adjustToPickerWheelValue("6-2 Formation")
        XCTAssert(selectedFormationLabel.exists)
    }

    func testWaitingForAnElementToAppear() {
        let zeroLabel = self.app.staticTexts["0"]
        XCTAssertFalse(zeroLabel.exists)

        let existsPredicate = NSPredicate(format: "exists == 1")
        expectationForPredicate(existsPredicate, evaluatedWithObject: zeroLabel, handler: nil)

        app.buttons["5, 4, 3, 2..."].tap()
        waitForExpectationsWithTimeout(5, handler: nil)
        XCTAssert(zeroLabel.exists)
    }
}

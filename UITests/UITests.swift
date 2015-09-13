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
        XCTAssert(app.staticTexts["Volley"].exists)
    }

    func testElementExistsWithPredicate() {
        let predicate = NSPredicate(format: "label BEGINSWITH[cd] 'set your team details'")
        let label = app.staticTexts.elementMatchingPredicate(predicate)
        XCTAssert(label.exists)
    }

    func testTappingAButton() {
        app.buttons["More Info"].tap()
        XCTAssert(app.navigationBars["Volleyball?"].exists)
    }

    func testTypingText() {
        app.staticTexts["Manage Team"].tap()

        let textField = app.textFields["Team Name"]
        textField.tap()
        textField.typeText("Dig Newtons")
    }

    func testDismissingAnAlert() {
        app.staticTexts["View Schedule"].tap()

        app.buttons["Finish Game"].tap()
        app.alerts["You won!"].buttons["Awesome!"].tap()
    }

    /* By not starting this test with "test" it will not be run.
     * This test is not being run because dismissing the system alert
     * causes the test suite to crash.
     * Bug report: http://openradar.appspot.com/radar?id=4979891669827584
    */
    func _testDismissingASystemAlert() {
        app.staticTexts["View Schedule"].tap()

        app.buttons["Find Games Nearby?"].tap()
        app.alerts.buttons["Allow"].tap() // works, but crashes the test suite.
        XCTAssert(app.staticTexts["Authorized"].exists)
    }

    func testAdjustingASlider() {
        app.staticTexts["Manage Team"].tap()

        app.sliders.element.adjustToNormalizedSliderPosition(0.7)
        XCTAssert(app.staticTexts["7"].exists)
    }

    func testAdjustingAPicker() {
        app.staticTexts["Manage Team"].tap()

        let selectedFormationLabel = app.staticTexts["6-2 Formation"]
        XCTAssertFalse(selectedFormationLabel.exists)

        app.pickerWheels.element.adjustToPickerWheelValue("6-2 Formation")
        XCTAssert(selectedFormationLabel.exists)
    }

    func testWaitingForAnElementToAppear() {
        app.staticTexts["View Schedule"].tap()

        let nextGameLabel = self.app.staticTexts["Game 4 - Tomorrow"]
        let existsPredicate = NSPredicate(format: "exists == 1")
        expectationForPredicate(existsPredicate, evaluatedWithObject: nextGameLabel, handler: nil)

        app.buttons["Load More Games"].tap()

        waitForExpectationsWithTimeout(5, handler: nil)
        XCTAssert(nextGameLabel.exists)
    }

    func testCellReordering() {
        app.staticTexts["Manage Roster"].tap()

        let joeButton = app.buttons["Reorder Joe"]
        let brianButton = app.buttons["Reorder Brian"]
        joeButton.pressForDuration(0.5, thenDragToElement: brianButton)

        XCTAssertLessThanOrEqual(joeButton.frame.maxY, brianButton.frame.minY)
    }

    func testTextExistsInAWebView() {
        app.buttons["More Info"].tap()

        let volleyballLabel = app.staticTexts["Volleyball"]
        waitForElementToAppear(volleyballLabel)
        XCTAssert(volleyballLabel.exists)
    }

    func testTappingALinkInAWebView() {
        app.buttons["More Info"].tap()

        let disambiguationLink = app.links["Volleyball (disambiguation)"]
        waitForElementToAppear(disambiguationLink)
        XCTAssert(disambiguationLink.exists)

        disambiguationLink.tap()

        let volleyballLink = app.links["Volleyball (ball)"]
        waitForElementToAppear(volleyballLink)
        XCTAssert(volleyballLink.exists)
    }

    func testPushingAController() {
        app.buttons["More Info"].tap()
        XCTAssert(app.navigationBars["Volleyball?"].exists)
    }

    private func waitForElementToAppear(element: XCUIElement) {
        let existsPredicate = NSPredicate(format: "exists == 1")
        expectationForPredicate(existsPredicate, evaluatedWithObject: element, handler: nil)
        waitForExpectationsWithTimeout(5, handler: nil)
    }
}

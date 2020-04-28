//
//  UITests.swift
//  UITests
//
//  Created by Joe Masilotti on 9/7/15.
//  Copyright © 2015 Masilotti.com. All rights reserved.
//

import XCTest

class UITests: XCTestCase {
    let app = XCUIApplication()

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app.launch()
    }

    func testElementExists() {
        XCTAssert(app.staticTexts["Volley"].exists)
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

    func testDismissingASystemAlert() {
        app.staticTexts["View Schedule"].tap()

        addUIInterruptionMonitor(withDescription: "Location Services") { (alert) -> Bool in
            alert.buttons["Allow Once"].tap()
            return true
        }

        app.buttons["Find Games Nearby?"].tap()
        app.tap() // need to interact with the app for the handler to fire
        XCTAssert(app.staticTexts["Authorized"].exists)
    }

    func testAdjustingASlider() {
        app.staticTexts["Manage Team"].tap()

        app.sliders.element.adjust(toNormalizedSliderPosition: 0.7)
        XCTAssert(app.staticTexts["7"].exists)
    }

    func testAdjustingAPicker() {
        app.staticTexts["Manage Team"].tap()

        let selectedFormationLabel = app.staticTexts["5 attackers, 1 setter"]
        XCTAssertFalse(selectedFormationLabel.exists)

        let attackersPredicate = NSPredicate(format: "label BEGINSWITH 'Attackers Formation'")
        let attackersPicker = app.pickerWheels.element(matching: attackersPredicate)
        attackersPicker.adjust(toPickerWheelValue: "5 attackers")

        let settersPredicate = NSPredicate(format: "label BEGINSWITH 'Setters Formation'")
        let settersPicker = app.pickerWheels.element(matching: settersPredicate)
        settersPicker.adjust(toPickerWheelValue: "1 setter")

        XCTAssert(selectedFormationLabel.exists)
    }

    func testPushingAController() {
        app.buttons["More Info"].tap()
        XCTAssert(app.navigationBars["Volleyball?"].exists)
    }

    func testPoppingAViewController() {
        app.buttons["More Info"].tap()
        XCTAssert(app.navigationBars["Volleyball?"].exists)
        app.navigationBars.buttons.element(boundBy: 0).tap()
        XCTAssert(app.navigationBars["Volley"].exists)
    }

    // Advanced

    func testWaitingForAnElementToAppear() {
        app.staticTexts["View Schedule"].tap()
        app.buttons["Load More Games"].tap()

        let nextGameLabel = self.app.staticTexts["Game 4 - Tomorrow"]
        XCTAssert(nextGameLabel.waitForExistence(timeout: 5))
    }

    func testCellReordering() {
        app.staticTexts["Manage Roster"].tap()

        let joeButton = app.buttons["Reorder Joe"]
        let brianButton = app.buttons["Reorder Brian"]
        joeButton.press(forDuration: 0.5, thenDragTo: brianButton)

        XCTAssertLessThanOrEqual(joeButton.frame.maxY, brianButton.frame.minY)
    }

    func testTextExistsInAWebView() {
        app.buttons["More Info"].tap()
        let volleyballLabel = app.staticTexts["Volleyball"]
        XCTAssert(volleyballLabel.waitForExistence(timeout: 5))
    }

    func testTappingALinkInAWebView() {
        app.buttons["More Info"].tap()

        let disambiguationLink = app.links["Volleyball (disambiguation)"]
        XCTAssert(disambiguationLink.waitForExistence(timeout: 5))

        disambiguationLink.tap()

        let volleyballLink = app.links["Volleyball (ball)"]
        XCTAssert(volleyballLink.waitForExistence(timeout: 5))
    }

    func testRefreshControl() {
        app.staticTexts["Manage Roster"].tap()

        addUIInterruptionMonitor(withDescription: "Roster Refreshed") { (alert) -> Bool in
            alert.buttons["Dismiss"].tap()
            return true
        }

        let firstCell = app.staticTexts["Adrienne"]
        let coordinate = firstCell.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 0))
        let bottom = firstCell.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 10))
        coordinate.press(forDuration: 0, thenDragTo: bottom)
    }
}

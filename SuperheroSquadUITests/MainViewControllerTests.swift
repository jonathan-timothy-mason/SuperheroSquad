//
//  MainViewControllerTests.swift
//  SuperheroSquadUITests
//
//  Created by Jonathan Mason on 06/12/2021.
//

import XCTest
@testable import SuperheroSquad

class MainViewControllerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        let app = XCUIApplication()
        
        // Indciate to app UI tests are running.
        // From "Xcode UI Testing Cheat Sheet" by Paul Hudson:
        // https://www.hackingwithswift.com/articles/148/xcode-ui-testing-cheat-sheet
        app.launchArguments = ["RunningUITests"]
        
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        
        // Wait until CollectionView has loadeded a few characters before going on to run each test.
        let cell = XCUIApplication().collectionViews.children(matching: .cell).firstMatch
        _ = cell.waitForExistence(timeout: 5)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    /// Ensure TableView is initially empty.
    func testTableViewInitiallyEmpty() throws {
        // Get number of cells in TableView.
        let numCells = XCUIApplication().tables.children(matching: .cell).count
        
        // Ensure result is as expected.
        XCTAssertEqual(0, numCells, "TableView not empty.")
    }
    
    /// Ensure collectionView is NOT initially empty.
    func testCollectionViewNOTInitiallyEmpty() throws {
        // Get number of cells in CollectionView.
        let numCells = XCUIApplication().collectionViews.children(matching: .cell).count
        
        // Ensure result is as expected.
        XCTAssert(numCells > 0, "CollectionView empty.")
    }

    /// Ensure tapping a CollectionView cell displays Review screen.
    func testTappingRecuitDisplaysReviewScreen() throws {
        // Ensure CollectionView not empty.
        let numCells = XCUIApplication().collectionViews.children(matching: .cell).count
        XCTAssert(numCells > 0, "CollectionView empty.")
        
        // Tap first recruit.
        XCUIApplication().collectionViews.children(matching: .cell).element(boundBy: 0).children(matching: .other).element.tap()
        
        // Ensure Review screen is displayed.
        let recruitLabel = XCUIApplication().staticTexts["Recruit?"]
        XCTAssert(recruitLabel.exists, "Review screen not displayed.")
    }
    
    /// Ensure recruit can be added to squad.
    func testCanAddRecruit() throws {
        // Ensure CollectionView not empty.
        let numCollectionViewCells = XCUIApplication().collectionViews.children(matching: .cell).count
        XCTAssert(numCollectionViewCells > 0, "CollectionView empty.")
        
        // Ensure TableView empty.
        let numInitialTableViewCells = XCUIApplication().tables.children(matching: .cell).count
        XCTAssertEqual(0, numInitialTableViewCells, "TableView not empty.")
        
        // Tap first recruit.
        XCUIApplication().collectionViews.children(matching: .cell).element(boundBy: 0).children(matching: .other).element.tap()
        
        // Ensure Review screen is displayed.
        let initialRecruitLabel = XCUIApplication().staticTexts["Recruit?"]
        XCTAssert(initialRecruitLabel.exists, "Review screen not displayed.")
        
        // Press YES to recruit character.
        let yesButton = XCUIApplication().buttons["Yes"]
        XCTAssert(yesButton.exists, "Yes button does not exist.")
        yesButton.tap()
        
        // Ensure Review screen is NOT displayed.
        let subsequentRecruitLabel = XCUIApplication().staticTexts["Recruit?"]
        XCTAssert(subsequentRecruitLabel.exists == false, "Review screen is still displayed.")
      
        // Ensure TableView NOT empty.
        let numSubsequentTableViewCells = XCUIApplication().tables.children(matching: .cell).count
        XCTAssertEqual(1, numSubsequentTableViewCells, "TableView has incorrect number cells.")
    }
    
    /// Ensure recruit cannot be added to squad twice.
    func testCannotAddRecruitTwice() throws {
        // Ensure CollectionView not empty.
        let numCollectionViewCells = XCUIApplication().collectionViews.children(matching: .cell).count
        XCTAssert(numCollectionViewCells > 0, "CollectionView empty.")
        
        // Ensure TableView empty.
        let numInitialTableViewCells = XCUIApplication().tables.children(matching: .cell).count
        XCTAssertEqual(0, numInitialTableViewCells, "TableView not empty.")
        
        // Tap first recruit.
        XCUIApplication().collectionViews.children(matching: .cell).element(boundBy: 0).children(matching: .other).element.tap()
        
        // Ensure Review screen is displayed.
        let initialRecruitLabel = XCUIApplication().staticTexts["Recruit?"]
        XCTAssert(initialRecruitLabel.exists, "Review screen not displayed.")
        
        // Press YES to recruit character.
        let yesButton = XCUIApplication().buttons["Yes"]
        XCTAssert(yesButton.exists, "Yes button does not exist.")
        yesButton.tap()
        
        // Ensure Review screen is NOT displayed.
        let subsequentRecruitLabel = XCUIApplication().staticTexts["Recruit?"]
        XCTAssert(subsequentRecruitLabel.exists == false, "Review screen is still displayed.")
      
        // Ensure TableView NOT empty.
        let numSubsequentTableViewCells = XCUIApplication().tables.children(matching: .cell).count
        XCTAssertEqual(1, numSubsequentTableViewCells, "TableView has incorrect number cells.")
        
        // Tap first recruit again.
        XCUIApplication().collectionViews.children(matching: .cell).element(boundBy: 0).children(matching: .other).element.tap()
        
        // Ensure Review screen is displayed again.
        let finalRecruitLabel = XCUIApplication().staticTexts["Recruit?"]
        XCTAssert(finalRecruitLabel.exists, "Review screen not displayed.")
        
        // Ensure YES button is disabled.
        let subsequentYesButton = XCUIApplication().buttons["Yes"]
        XCTAssert(subsequentYesButton.isEnabled == false, "Yes button is enabled.")
    }
}

//
//  MainViewControllerTests.swift
//  SuperheroSquadUITests
//
//  Created by Jonathan Mason on 06/12/2021.
//

import XCTest
@testable import SuperheroSquad

class MainViewControllerTests: XCTestCase {
    
    static let existsTimeout = 5.0

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
        
        waitForCollectionViewToLoad()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    /// Wait for CollectionView to load characters.
    func waitForCollectionViewToLoad() {
        let cell = XCUIApplication().collectionViews.children(matching: .cell).element(boundBy: 0).children(matching: .other).element
        _ = cell.waitForExistence(timeout: MainViewControllerTests.existsTimeout)
        XCTAssert(cell.exists, "CollectionView empty.")
    }
    
    /// Ensure TableView is initially empty.
    func testTableViewInitiallyEmpty() throws {
        // Get number of cells in TableView.
        let numCells = XCUIApplication().tables.children(matching: .cell).count
        
        // Ensure result is as expected.
        XCTAssertEqual(0, numCells, "TableView not empty.")
    }

    /// Ensure tapping a CollectionView cell displays Review (Recruit?) screen.
    func testTappingRecuitDisplaysReviewScreen() throws {
        // Tap first recruit.
        XCUIApplication().collectionViews.children(matching: .cell).element(boundBy: 0).children(matching: .other).element.tap()
        
        // Ensure Review (Recruit?) screen is displayed.
        let recruitLabel = XCUIApplication().staticTexts["Recruit?"]
        XCTAssert(recruitLabel.exists, "Review (Recruit?) screen not displayed.")
    }
    
    /// Ensure recruit can be added to squad.
    func testCanAddRecruit() throws {
        // Ensure TableView empty.
        let numInitialTableViewCells = XCUIApplication().tables.children(matching: .cell).count
        XCTAssertEqual(0, numInitialTableViewCells, "TableView not empty.")
        
        // Tap first recruit.
        XCUIApplication().collectionViews.children(matching: .cell).element(boundBy: 0).children(matching: .other).element.tap()
        
        // Ensure Review (Recruit?) screen is displayed.
        let initialRecruitLabel = XCUIApplication().staticTexts["Recruit?"]
        XCTAssert(initialRecruitLabel.exists, "Review (Recruit?) screen not displayed.")
        
        // Press YES to recruit character.
        let yesButton = XCUIApplication().buttons["Yes"]
        XCTAssert(yesButton.exists, "Yes button does not exist.")
        yesButton.tap()
        
        // Ensure Review (Recruit?) screen is NOT displayed.
        let subsequentRecruitLabel = XCUIApplication().staticTexts["Recruit?"]
        _ = subsequentRecruitLabel.waitForExistence(timeout: MainViewControllerTests.existsTimeout)
        XCTAssert(subsequentRecruitLabel.exists == false, "Review (Recruit?) screen is still displayed.")
      
        // Ensure TableView NOT empty.
        let numSubsequentTableViewCells = XCUIApplication().tables.children(matching: .cell).count
        XCTAssertEqual(1, numSubsequentTableViewCells, "TableView has incorrect number cells.")
    }
    
    /// Ensure recruit cannot be added to squad twice.
    func testCannotAddRecruitTwice() throws {
        // Ensure TableView empty.
        let numInitialTableViewCells = XCUIApplication().tables.children(matching: .cell).count
        XCTAssertEqual(0, numInitialTableViewCells, "TableView not empty.")
        
        // Tap first recruit.
        XCUIApplication().collectionViews.children(matching: .cell).element(boundBy: 0).children(matching: .other).element.tap()
        
        // Ensure Review (Recruit?) screen is displayed.
        let initialRecruitLabel = XCUIApplication().staticTexts["Recruit?"]
        XCTAssert(initialRecruitLabel.exists, "Review (Recruit?) screen not displayed.")
        
        // Press YES to recruit character.
        let yesButton = XCUIApplication().buttons["Yes"]
        XCTAssert(yesButton.exists, "Yes button does not exist.")
        yesButton.tap()
        
        // Ensure Review (Recruit?) screen is NOT displayed.
        let subsequentRecruitLabel = XCUIApplication().staticTexts["Recruit?"]
        _ = subsequentRecruitLabel.waitForExistence(timeout: MainViewControllerTests.existsTimeout)
        XCTAssert(subsequentRecruitLabel.exists == false, "Review (Recruit?) screen is still displayed.")
      
        // Ensure TableView NOT empty.
        let numSubsequentTableViewCells = XCUIApplication().tables.children(matching: .cell).count
        XCTAssertEqual(1, numSubsequentTableViewCells, "TableView has incorrect number cells.")
        
        // Tap first recruit again.
        XCUIApplication().collectionViews.children(matching: .cell).element(boundBy: 0).children(matching: .other).element.tap()
        
        // Ensure Review (Recruit?) screen is displayed again.
        let finalRecruitLabel = XCUIApplication().staticTexts["Recruit?"]
        XCTAssert(finalRecruitLabel.exists, "Review (Recruit?) screen not displayed.")
        
        // Ensure YES button is disabled.
        let subsequentYesButton = XCUIApplication().buttons["Yes"]
        XCTAssert(subsequentYesButton.isEnabled == false, "Yes button is enabled.")
    }
    
    /// Ensure tapping a TableView cell displays Review (Fire?) screen.
    func testTappingSquadMemberDisplaysReviewScreen() throws {
        // Ensure TableView empty.
        let numInitialTableViewCells = XCUIApplication().tables.children(matching: .cell).count
        XCTAssertEqual(0, numInitialTableViewCells, "TableView not empty.")
        
        // Tap first recruit.
        XCUIApplication().collectionViews.children(matching: .cell).element(boundBy: 0).children(matching: .other).element.tap()
        
        // Ensure Review (Recruit?) screen is displayed.
        let initialRecruitLabel = XCUIApplication().staticTexts["Recruit?"]
        XCTAssert(initialRecruitLabel.exists, "Review (Recruit?) screen not displayed.")
        
        // Press YES to recruit character.
        let yesButton = XCUIApplication().buttons["Yes"]
        XCTAssert(yesButton.exists, "Yes button does not exist.")
        yesButton.tap()
        
        // Ensure Review (Recruit?) screen is NOT displayed.
        let subsequentRecruitLabel = XCUIApplication().staticTexts["Recruit?"]
        _ = subsequentRecruitLabel.waitForExistence(timeout: MainViewControllerTests.existsTimeout)
        XCTAssert(subsequentRecruitLabel.exists == false, "Review (Recruit?) screen is still displayed.")
      
        // Ensure TableView NOT empty.
        let numSubsequentTableViewCells = XCUIApplication().tables.children(matching: .cell).count
        XCTAssertEqual(1, numSubsequentTableViewCells, "TableView has incorrect number cells.")
        
        // Wait for TableView to reload with new squad member.
        let tableViewCell = XCUIApplication().tables.children(matching: .cell).firstMatch
        _ = tableViewCell.waitForExistence(timeout: MainViewControllerTests.existsTimeout)
        XCTAssert(tableViewCell.exists, "TableView empty.")

        // Tap newly added squad member.
        tableViewCell.tap()
        
        // Ensure Review (Fire?) screen is displayed.
        let fireLabel = XCUIApplication().staticTexts["Fire?"]
        XCTAssert(fireLabel.exists, "Review (Fire?) screen not displayed.")
    }
}

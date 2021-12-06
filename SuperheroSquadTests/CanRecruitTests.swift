//
//  CanRecruitTests.swift
//  SuperheroSquadTests
//
//  Created by Jonathan Mason on 06/12/2021.
//

import XCTest
@testable import SuperheroSquad

class CanRecruitTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    /// Helper to create full squad.
    /// - Returns: Full squad.
    func createFullSquad(numberSquadMembers: Int = 5) -> [SquadMemberProtocol] {
        var squad = [SquadMemberProtocol]()
        squad.append(TestSquadMember(name: "Superman", bio: "He flies like bird."))
        squad.append(TestSquadMember(name: "Batman", bio: "He's like a bat."))
        squad.append(TestSquadMember(name: "Spiderman", bio: "He's like a spider."))
        squad.append(TestSquadMember(name: "Mr. Incredible", bio: "He's a family man."))
        squad.append(TestSquadMember(name: "Hulk", bio: "He's green."))
        return squad
    }

    /// Test function under test returns false if squad full.
    func testCannotRecruitWhenFull() {
        let expectedResult = false
        
        let ironMan = Character(name: "Iron Man", bio: "He's into technology.")
        let fullSquad = createFullSquad()
        
        // Call function under test.
        let actualResult = fullSquad.canRecruite(character: ironMan)
        
        // Ensure result is as expected.
        XCTAssertEqual(expectedResult, actualResult, "Allows recruitment when squad full.")
    }
    
    /// Test function under test returns true if squad not full.
    func testCanRecruitWhenNotFull() {
        let expectedResult = true
        
        let ironMan = Character(name: "Iron Man", bio: "He's into technology.")
        var notFullSquad = createFullSquad()
        notFullSquad.remove(at: 4)
        
        // Call function under test.
        let actualResult = notFullSquad.canRecruite(character: ironMan)
        
        // Ensure result is as expected.
        XCTAssertEqual(expectedResult, actualResult, "Doesn't allow recruitment when squad not full.")
    }
    
    /// Test function under test returns false if squad not full, but character already in squad.
    func testCannotRecruitWhenInSquad() {
        let expectedResult = false
        
        let ironMan = Character(name: "Iron Man", bio: "He's into technology.")
        let squad: [SquadMemberProtocol] = [TestSquadMember(name: "Iron Man", bio: "He's into technology.")]
        
        // Call function under test.
        let actualResult = squad.canRecruite(character: ironMan)
        
        // Ensure result is as expected.
        XCTAssertEqual(expectedResult, actualResult, "Allows character to be recruited when already in squad.")
    }
    
    /// Test function under test returns true if squad not full and character not in squad.
    func testCanRecruitWhenNotRecruited() {
        let expectedResult = true
        
        let ironMan = Character(name: "Iron Man", bio: "He's into technology.")
        let squad = [SquadMemberProtocol]()
        
        // Call function under test.
        let actualResult = squad.canRecruite(character: ironMan)
        
        // Ensure result is as expected.
        XCTAssertEqual(expectedResult, actualResult, "Doesn't allow character to be recruited when not in squad.")
    }
}

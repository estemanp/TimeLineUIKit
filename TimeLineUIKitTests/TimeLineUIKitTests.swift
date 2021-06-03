//
//  TimeLineUIKitTests.swift
//  TimeLineUIKitTests
//
//  Created by Andres Esteban Perez Ramirez on 30/05/21.
//

import XCTest
@testable import TimeLineUIKit


private final class DummyTimeLineViewController: UIViewController {}

final class DummyTimeLinePresenter: TimeLinePresenterProtocol {
    
    var dummyGetSections: Int = 0
    var dummyShow: Int = 0

    var teamHomeName: String {
        return "Team A"
    }
    
    var teamAwayName: String {
        return "Team B"
    }
    
    func show() {
        dummyShow += 1
    }
    
    func getSections() -> Dictionary<Int8, [Event]> {
        dummyGetSections += 1
        return Dictionary<Int8, [Event]>()
    }
}

final class DummyTimeLineWireframe: TimeLineWireframeProtocol {
    
    var dummyShow: Int = 0
    
    func show(with presenter: TimeLineViewOutput) {
        dummyShow += 1
    }
}

final class DummyTimeLineInteractor: TimeLineInteractorProtocol {
    var dummyGetEvents: Int = 0
    var dummyTeamNames: Int = 0

    var teamNames: Dictionary<String, String> {
        dummyGetEvents += 1
        return Dictionary<String, String>()
    }
    
    func getEvents() -> [Event] {
        dummyGetEvents += 1
        return []
    }
}

final class TimeLineUIKitTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    func testTimeLineModuleStart() {
        let presenter = DummyTimeLinePresenter()
        let module = TimeLineModule(navigation: DummyTimeLineViewController(), presenter: presenter)

        module.show()
        XCTAssertEqual(presenter.dummyShow, 1)
    }

    func testTimeLinePresenterTeamAwayNameNil() {
        let interactor = DummyTimeLineInteractor()
        let wireframe = DummyTimeLineWireframe()
        let presenter = TimeLinePresenter(wireframe: wireframe, interactor: interactor)
        XCTAssertEqual(presenter.teamAwayName, "Away")
    }
    
    func testTimeLinePresenterTeamHomeNameNil() {
        let interactor = DummyTimeLineInteractor()
        let wireframe = DummyTimeLineWireframe()
        let presenter = TimeLinePresenter(wireframe: wireframe, interactor: interactor)
        XCTAssertEqual(presenter.teamHomeName, "Home")
    }
    
    func testTimeLinePresenterTeamAwayName() {
        let interactor = TimeLineInteractor()
        let wireframe = DummyTimeLineWireframe()
        let presenter = TimeLinePresenter(wireframe: wireframe, interactor: interactor)
        XCTAssertEqual(presenter.teamAwayName, "Team B")
    }
    
    func testTimeLinePresenterTeamHomeName() {
        let interactor = TimeLineInteractor()
        let wireframe = DummyTimeLineWireframe()
        let presenter = TimeLinePresenter(wireframe: wireframe, interactor: interactor)
        XCTAssertEqual(presenter.teamHomeName, "Team A")
    }
    
    func testTimeLinePresenterShowFlow() {
        let interactor = DummyTimeLineInteractor()
        let wireframe = DummyTimeLineWireframe()
        let presenter = TimeLinePresenter(wireframe: wireframe, interactor: interactor)
        presenter.show()
        XCTAssertEqual(wireframe.dummyShow, 1)
    }
    
    func testTimeLinePresenterFlowGetSectionsFlow() {
        let interactor = DummyTimeLineInteractor()
        let wireframe = DummyTimeLineWireframe()
        let presenter = TimeLinePresenter(wireframe: wireframe, interactor: interactor)
        _ = presenter.getSections()
        XCTAssertEqual(interactor.dummyGetEvents, 1)
    }
    
    func testTimeLinePresenterFlowGetSections() {
        let interactor = TimeLineInteractor()
        let wireframe = DummyTimeLineWireframe()
        let presenter = TimeLinePresenter(wireframe: wireframe, interactor: interactor)
        let results = presenter.getSections()
        XCTAssertEqual(results.count, 9)
        XCTAssertEqual(results[0]?.count, 2)
    }
    
    func testTimeLinePresenterFlowGetSectionsWithMocksOne() {
        let interactor = TimeLineInteractor(timeLineProvider: TimeLineMockTestOne())
        let wireframe = DummyTimeLineWireframe()
        let presenter = TimeLinePresenter(wireframe: wireframe, interactor: interactor)
        let results = presenter.getSections()
        XCTAssertEqual(results.count, 10)
        XCTAssertEqual(results[8]?.count, 2)
    }
    
    func testTimeLinePresenterFlowGetSectionsWithMocksTwo() {
        let interactor = TimeLineInteractor(timeLineProvider: TimeLineMockTestTwo())
        let wireframe = DummyTimeLineWireframe()
        let presenter = TimeLinePresenter(wireframe: wireframe, interactor: interactor)
        let results = presenter.getSections()
        XCTAssertEqual(results.count, 2)
    }
    
    func testTimeLinePresenterFlowGetSectionsWithMocksThree() {
        let interactor = TimeLineInteractor(timeLineProvider: TimeLineMockTestThree())
        let wireframe = DummyTimeLineWireframe()
        let presenter = TimeLinePresenter(wireframe: wireframe, interactor: interactor)
        let results = presenter.getSections()
        XCTAssertNil(results[0])
        XCTAssertNil(results[8])
        XCTAssertNil(results[9])
    }
}


//MARK: Constraints

final class TimeLineMockTestOne: TimeLineProvider {
    
    private var timeLineEvents: [Event] = []
    var teamNames: Dictionary<String, String> {
        return ["Home": "Team Test 1",
                "Away": "Team Test 2"]
    }
    
    func getEvents() -> [Event] {
        return [
            Event(eventSide: "home", timeStamp: 0),
            Event(eventSide: "home", timeStamp: 10),
            Event(eventSide: "away", timeStamp: 20),
            Event(eventSide: "home", timeStamp: 30),
            Event(eventSide: "home", timeStamp: 40),
            Event(eventSide: "away", timeStamp: 50),
            Event(eventSide: "away", timeStamp: 60),
            Event(eventSide: "away", timeStamp: 70),
            Event(eventSide: "home", timeStamp: 80),
            Event(eventSide: "away", timeStamp: 90)
        ]
    }
}

final class TimeLineMockTestTwo: TimeLineProvider {
    
    private var timeLineEvents: [Event] = []
    var teamNames: Dictionary<String, String> {
        return ["Home": "Team Test 1",
                "Away": "Team Test 2"]
    }
    
    func getEvents() -> [Event] {
        return [
            Event(eventSide: "home", timeStamp: 2),
            Event(eventSide: "home", timeStamp: 11)
        ]
    }
}

final class TimeLineMockTestThree: TimeLineProvider {
    
    private var timeLineEvents: [Event] = []
    var teamNames: Dictionary<String, String> {
        return ["Home": "Team Teast 1",
                "Away": "Team Teast 2"]
    }
    
    func getEvents() -> [Event] {
        return [
            Event(eventSide: "home", timeStamp: -1),
            Event(eventSide: "home", timeStamp: 14),
            Event(eventSide: "away", timeStamp: 25),
            Event(eventSide: "away", timeStamp: 91)
        ]
    }
}

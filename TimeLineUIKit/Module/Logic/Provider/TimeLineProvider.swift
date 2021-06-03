//
//  TimeLineProvider.swift
//  TimeLineUIKit
//
//  Created by Andres Esteban Perez Ramirez on 30/05/21.
//

import Foundation

protocol TimeLineProvider {
    var  teamNames: Dictionary<String, String> { get }
    func getEvents() -> [Event]
}


final class TimeLineMock: TimeLineProvider {
    
    private var timeLineEvents: [Event] = []
    var teamNames: Dictionary<String, String> {
        return ["Home": "Team A",
                "Away": "Team B"]
    }
    
    init() {
        setupEvents1()
    }
    
    func getEvents() -> [Event] {
        return timeLineEvents
    }
    
    private func setupEvents1() {
        let timeLineEvents: Array<Event> = [
            Event(eventSide: "home", timeStamp: 10),
            Event(eventSide: "home", timeStamp: 8),
            Event(eventSide: "away", timeStamp: 7),
            Event(eventSide: "home", timeStamp: 11),
            Event(eventSide: "home", timeStamp: 24),
            Event(eventSide: "away", timeStamp: 36),
            Event(eventSide: "away", timeStamp: 44),
            Event(eventSide: "away", timeStamp: 56),
            Event(eventSide: "home", timeStamp: 51),
            Event(eventSide: "away", timeStamp: 66),
            Event(eventSide: "away", timeStamp: 69),
            Event(eventSide: "home", timeStamp: 57),
            Event(eventSide: "home", timeStamp: 59),
            Event(eventSide: "home", timeStamp: 71),
            Event(eventSide: "home", timeStamp: 85),
            Event(eventSide: "away", timeStamp: 89)
        ]
        self.timeLineEvents = timeLineEvents
    }
}

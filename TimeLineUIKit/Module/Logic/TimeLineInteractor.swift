//
//  TimeLineInteractor.swift
//  TimeLineUIKit
//
//  Created by Andres Esteban Perez Ramirez on 30/05/21.
//

protocol TimeLineInteractorProtocol {
    var  teamNames: Dictionary<String, String> { get }
    func getEvents() -> [Event]
}

final class TimeLineInteractor: TimeLineInteractorProtocol {
    
    private let provider: TimeLineProvider
    private var timeLineEvents: [Event] = []
    var teamNames: Dictionary<String, String> {
        return provider.teamNames
    }
    
    init(timeLineProvider: TimeLineProvider = TimeLineMock()) {
        self.provider = timeLineProvider
    }
    
    func getEvents() -> [Event] {
        return provider.getEvents()
    }
}

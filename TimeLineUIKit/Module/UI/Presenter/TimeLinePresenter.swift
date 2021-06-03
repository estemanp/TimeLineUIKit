//
//  TimeLinePresenter.swift
//  TimeLineUIKit
//
//  Created by Andres Esteban Perez Ramirez on 30/05/21.
//

import UIKit

protocol TimeLinePresenterProtocol: TimeLineViewOutput {
    func show()
}

final class TimeLinePresenter: TimeLinePresenterProtocol {
    
    private let wireframe: TimeLineWireframeProtocol
    private let interactor: TimeLineInteractorProtocol
    
    var teamHomeName: String {
        interactor.teamNames["Home"] ?? "Home"
    }
    
    var teamAwayName: String {
        interactor.teamNames["Away"] ?? "Away"
    }
    
    init(wireframe: TimeLineWireframeProtocol, interactor: TimeLineInteractorProtocol) {
        self.wireframe = wireframe
        self.interactor = interactor
    }
    
    func show() {
        wireframe.show(with: self)
    }
    
    func getSections() -> Dictionary<Int8, [Event]> {
        let events = interactor.getEvents().filter{ $0.timeStamp >= 0 && $0.timeStamp <= 90 }
        var sections = Dictionary(grouping: events, by: { $0.timeStamp / 10 })
        checkNinetyMinutes(sections: &sections, events: events)
        return sections
    }
    
    private func checkNinetyMinutes(sections: inout Dictionary<Int8, [Event]>, events: [Event]) {
        if let events = sections[9], let event = events.first(where: { $0.timeStamp == 90 }) {
            sections[8]?.append(event)
        }
    }
}

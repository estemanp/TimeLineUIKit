//
//  TimeLineModule.swift
//  TimeLineUIKit
//
//  Created by Andres Esteban Perez Ramirez on 30/05/21.
//

import UIKit

final class TimeLineModule {
    
    private let presenter: TimeLinePresenterProtocol
    
    init(navigation: UIViewController? = nil, presenter: TimeLinePresenterProtocol? = nil) {
        if let presenter = presenter {
            self.presenter = presenter
        } else {
            let interactor: TimeLineInteractorProtocol = TimeLineInteractor()
            let wireframe: TimeLineWireframeProtocol = TimeLineWireframe(baseController: navigation)
            self.presenter = TimeLinePresenter(wireframe: wireframe, interactor: interactor)
        }
    }
    
    func show() {
        presenter.show()
    }
}

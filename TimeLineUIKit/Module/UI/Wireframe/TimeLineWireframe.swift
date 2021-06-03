//
//  TimeLineWireframe.swift
//  TimeLineUIKit
//
//  Created by Andres Esteban Perez Ramirez on 30/05/21.
//

import UIKit

protocol TimeLineWireframeProtocol {
    func show(with presenter: TimeLineViewOutput)
}

final class TimeLineWireframe: TimeLineWireframeProtocol {
    
    private weak var baseController: UIViewController?
    private var topView: UIViewController?
    
    private weak var navigation: UINavigationController? {
        if let navigation = baseController?.presentedViewController as? UINavigationController {
            return navigation
        } else if let navigation = baseController as? UINavigationController {
            return navigation
        }
        return nil
    }
    
    init(baseController: UIViewController?) {
        self.baseController = baseController
    }
    
    func show(with presenter: TimeLineViewOutput) {
        if let navigation = navigation {
            let viewController = TimeLineViewController(presenter: presenter)
            navigation.pushViewController(viewController, animated: true)
        } else {
            topView = TimeLineViewController(presenter: presenter)
            //windowTopViewController?.present(topView ?? UIViewController(), animated: true)
        }
    }
}

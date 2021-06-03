//
//  TimeLineStyle.swift
//  TimeLineUIKit
//
//  Created by Andres Esteban Perez Ramirez on 30/05/21.
//

import UIKit

final class TimeLineStyle {

    // MARK: - Color palette
    static let color: TimeLineColorPaletteProtocol = TimeLineColorPalette()
    static let dimentions: TimeLineDimentionsProtocol = TimeLineDimentions()
}

protocol TimeLineColorPaletteProtocol {
    var timeLine: UIColor { get }
    var homeTeam: UIColor { get }
    var awayTeam: UIColor { get }
}

final class TimeLineColorPalette: TimeLineColorPaletteProtocol {
    var timeLine: UIColor = UIColor(named: "timeLine") ?? .cyan
    var homeTeam: UIColor = UIColor(named: "homeTeam") ?? .blue
    var awayTeam: UIColor = UIColor(named: "awayTeam") ?? .red
}

protocol TimeLineDimentionsProtocol {
    var scale: CGFloat { get }
    var radius: CGFloat { get }
}

final class TimeLineDimentions: TimeLineDimentionsProtocol {
    
    var scale: CGFloat = 12
    var radius: CGFloat = 6
    
}

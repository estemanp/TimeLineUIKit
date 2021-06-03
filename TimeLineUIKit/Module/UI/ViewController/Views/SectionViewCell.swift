//
//  SectionViewCell.swift
//  TimeLineUIKit
//
//  Created by Andres Esteban Perez Ramirez on 30/05/21.
//

import UIKit

class SectionViewCell: UICollectionViewCell {
    
    private let itemWidth: CGFloat = UIScreen.main.bounds.width / 12
    private let itemHeight: CGFloat = UIScreen.main.bounds.height / 12
    private let minutesBySection: Int8 = 10
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.addSubview(sectionTimeLineView)
    }
    
    private func setupLayout() {
        let margins = self.safeAreaLayoutGuide
        print("UIScreen.main.bounds.width es: \(UIScreen.main.bounds.width)" )
        print("El ancho es: \(itemWidth)" )
        print("UIScreen.main.bounds.height es: \(UIScreen.main.bounds.height)" )
        print("la altura es: \(itemHeight)" )
        
        sectionTimeLineViewConstraint(with: margins, width: itemWidth, height: itemHeight)
    }
    
    private func sectionTimeLineViewConstraint(with margins: UILayoutGuide, width: CGFloat, height: CGFloat) {
        NSLayoutConstraint.activate([
            sectionTimeLineView.topAnchor.constraint(equalTo: margins.topAnchor),
            sectionTimeLineView.centerXAnchor.constraint(equalTo: margins.centerXAnchor),
            sectionTimeLineView.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -1),
            sectionTimeLineView.widthAnchor.constraint(equalToConstant: width)
        ])
    }
    
    private func createHomeEvent(event: Event, key: Int8) {
        let x: CGFloat = TimeLineStyle.dimentions.radius * -1
        let posY: CGFloat = CGFloat(event.timeStamp - (key * minutesBySection))
        let y: CGFloat = ((posY * itemHeight) / CGFloat(minutesBySection)) - TimeLineStyle.dimentions.radius
        let view = UIView(frame: CGRect(x: x, y: y, width: TimeLineStyle.dimentions.scale, height: TimeLineStyle.dimentions.scale))
        view.layer.cornerRadius =  TimeLineStyle.dimentions.scale / 2
        view.clipsToBounds = true
        view.backgroundColor = TimeLineStyle.color.homeTeam
        addEventGesture(event: event, view: view)
        sectionTimeLineView.addSubview(view)
    }
    
    private func createAwayEvent(event: Event, key: Int8) {
        let x: CGFloat = itemWidth - TimeLineStyle.dimentions.radius
        let posY: CGFloat = CGFloat(event.timeStamp - (key * minutesBySection))
        let y: CGFloat = ((posY * itemHeight) / CGFloat(minutesBySection)) - TimeLineStyle.dimentions.radius
        let view = UIView(frame: CGRect(x: x, y: y, width: TimeLineStyle.dimentions.scale, height: TimeLineStyle.dimentions.scale))
        view.layer.cornerRadius = TimeLineStyle.dimentions.scale / 2
        view.clipsToBounds = true
        view.backgroundColor = TimeLineStyle.color.awayTeam
        addEventGesture(event: event, view: view)
        sectionTimeLineView.addSubview(view)
    }
    
    private func addHomeTeamEvents(key: Int8, events: [Event]?) {
        guard let events = events else { return }
        for event in events {
            createHomeEvent(event: event, key: key)
        }
    }
    
    private func addAwayTeamEvents(key: Int8, events: [Event]?) {
        guard let events = events else { return }
        for event in events {
            createAwayEvent(event: event, key: key)
        }
    }
    
    private func addEventGesture(event: Event, view: UIView) {
        let tapped = EventTapGesture.init(target: self, action: #selector(handleTap))
        tapped.event = event
        view.addGestureRecognizer(tapped)
    }
    
    @objc private func handleTap(recognizer: EventTapGesture) {
        guard let minute = recognizer.event?.timeStamp else { return }
        let alert = UIAlertController(title: "An event", message: "an event occurred: \(minute) minutes", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))

        self.window?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    private func addEventsToTimeLine(key: Int8, events: [Event]?) {
        guard let events = events else { return }
        let homeEvents = events.filter( {$0.eventSide == .home } )
        let awayEvents = events.filter( {$0.eventSide == .away } )
        addHomeTeamEvents(key: key, events: homeEvents)
        addAwayTeamEvents(key: key, events: awayEvents)
    }
    
    private func setupCorners(key: Int8) {
        if key == 0 {
            sectionTimeLineView.layer.cornerRadius = 16
            sectionTimeLineView.layer.cornerCurve = .circular
            sectionTimeLineView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        } else if key == 8 {
            sectionTimeLineView.layer.cornerRadius = 16
            sectionTimeLineView.layer.cornerCurve = .circular
            sectionTimeLineView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        }
    }
    
    func setupView(key: Int8, events: [Event]?) {
        setupCorners(key: key)
        addEventsToTimeLine(key: key, events: events)
    }
    
    //MARK: Lazy variables
    
    lazy var sectionTimeLineView: UIView = {
        let view = UIView()
        view.backgroundColor = TimeLineStyle.color.timeLine
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
}

//
//  TimeLineViewController.swift
//  TimeLineUIKit
//
//  Created by Andres Esteban Perez Ramirez on 30/05/21.
//

import UIKit


// MARK: - ViewOutput
protocol TimeLineViewOutput {
    var teamHomeName: String { get }
    var teamAwayName: String { get }
    func getSections() -> Dictionary<Int8, [Event]>
}

final class TimeLineViewController: UIViewController {
    
    unowned var timeLineView: TimeLineView { return self.view as! TimeLineView }
    unowned var homeLabel: UILabel { return timeLineView.homeLabel }
    unowned var awayLabel: UILabel { return timeLineView.awayLabel }
    unowned var collectionView: UICollectionView { return timeLineView.collectionView }
    
    private let presenter: TimeLineViewOutput
    private let cellId: String = "SectionViewCell"
    private var sections: Dictionary<Int8, [Event]> = Dictionary<Int8, [Event]>()
    
    init(presenter: TimeLineViewOutput) {
        self.presenter = presenter
        sections = presenter.getSections()
        super.init(nibName: String(describing: TimeLineViewController.self), bundle: .main)
    }
    
    override func loadView() {
        self.view = TimeLineView(frame: UIScreen.main.bounds)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        setuTexts()
        setupCollectionView()
    }
    
    private func setuTexts() {
        homeLabel.text = presenter.teamHomeName
        awayLabel.text = presenter.teamAwayName
    }
    
    private func setupCollectionView() {
        collectionView.register(SectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.dataSource = self
    }
}

extension TimeLineViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let sectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? SectionViewCell else { return UICollectionViewCell() }
        let key: Int8 = Int8(indexPath.row)
        let events = sections[key]
        sectionCell.setupView(key: key, events: events)
        return sectionCell
    }
}

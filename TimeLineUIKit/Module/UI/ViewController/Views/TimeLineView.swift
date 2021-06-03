//
//  TimeLineView.swift
//  TimeLineUIKit
//
//  Created by Andres Esteban Perez Ramirez on 30/05/21.
//

import UIKit

final class TimeLineView: UIView {
    
    private let heighItem: CGFloat = UIScreen.main.bounds.height / 12
    private let radius: CGFloat = 20
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupViews()
        setupLayout()
    }
    
    private func setupViews() {
        self.addSubview(matchTitleView)
        matchTitleView.addSubview(homeLabel)
        matchTitleView.addSubview(awayLabel)
        matchTitleView.addSubview(circleHomeView)
        matchTitleView.addSubview(circleAwayView)
        self.addSubview(collectionView)
    }
    
    private func setupLayout() {
        let margins = self.safeAreaLayoutGuide
        
        matchTitleViewConstraint(with: margins)
        collectionViewConstraint(with: margins)
    }
    
    //MARK: Constraints
    
    private func matchTitleViewConstraint(with margins: UILayoutGuide) {
        NSLayoutConstraint.activate([
            matchTitleView.topAnchor.constraint(equalTo: margins.topAnchor, constant: 20),
            matchTitleView.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 16),
            matchTitleView.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -16),
            matchTitleView.heightAnchor.constraint(equalToConstant: 40),
            matchTitleView.bottomAnchor.constraint(equalTo: collectionView.topAnchor),
            
            circleHomeView.centerYAnchor.constraint(equalTo: homeLabel.centerYAnchor),
            circleHomeView.leadingAnchor.constraint(equalTo: matchTitleView.leadingAnchor),
            circleHomeView.heightAnchor.constraint(equalToConstant: radius),
            circleHomeView.widthAnchor.constraint(equalToConstant: radius),
            
            homeLabel.topAnchor.constraint(equalTo: matchTitleView.topAnchor),
            homeLabel.leadingAnchor.constraint(equalTo: circleHomeView.trailingAnchor, constant: 2),
            homeLabel.trailingAnchor.constraint(equalTo: awayLabel.leadingAnchor, constant: -16),
            homeLabel.bottomAnchor.constraint(equalTo: matchTitleView.bottomAnchor),
            
            awayLabel.topAnchor.constraint(equalTo: matchTitleView.topAnchor),
            awayLabel.trailingAnchor.constraint(equalTo: circleAwayView.leadingAnchor, constant: -2),
            awayLabel.bottomAnchor.constraint(equalTo: matchTitleView.bottomAnchor),
            
            circleAwayView.centerYAnchor.constraint(equalTo: awayLabel.centerYAnchor),
            circleAwayView.trailingAnchor.constraint(equalTo: matchTitleView.trailingAnchor),
            circleAwayView.heightAnchor.constraint(equalToConstant: radius),
            circleAwayView.widthAnchor.constraint(equalToConstant: radius)
        ])
    }
    
    private func collectionViewConstraint(with margins: UILayoutGuide) {
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -16),
            collectionView.bottomAnchor.constraint(equalTo: margins.bottomAnchor)
        ])
    }
    
    //MARK: Lazy variables
    
    lazy var matchTitleView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var circleHomeView: UIView = {
        let view = UIView()
        view.backgroundColor = TimeLineStyle.color.homeTeam
        view.layer.cornerRadius = radius / 2
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var circleAwayView: UIView = {
        let view = UIView()
        view.backgroundColor = TimeLineStyle.color.awayTeam
        view.layer.cornerRadius = radius / 2
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var homeLabel: UILabel = {
        let label = UILabel()
        label.textColor = TimeLineStyle.color.homeTeam
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = UIFont(name: "SansSerifBldFLF",size: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var awayLabel: UILabel = {
        let label = UILabel()
        label.textColor = TimeLineStyle.color.awayTeam
        label.numberOfLines = 1
        label.textAlignment = .right
        label.font = UIFont(name: "SansSerifBldFLF",size: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: heighItem + 1)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let view = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
}

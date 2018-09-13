//
//  ScreenshotsCell.swift
//  AppStore
//
//  Created by Sherif  Wagih on 9/6/18.
//  Copyright © 2018 Sherif  Wagih. All rights reserved.
//

import UIKit
class ScreenShotsCell: BaseCellClass,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var app:App?{
        didSet{
            collectionView.reloadData()
        }
    }
    let imageShotCellId = "imageShotCellId"
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return app?.Screenshots?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: imageShotCellId, for: indexPath) as! ScreenShotImageCell
        if let imageName = app?.Screenshots?[indexPath.item]
        {
            cell.scImageView.image = UIImage(named: imageName)
            print(imageName)
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 250, height: frame.height - 20)
    }
    override func setupViews()
    {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ScreenShotImageCell.self, forCellWithReuseIdentifier: imageShotCellId)
        addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            ])
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    let collectionView:UICollectionView =
    {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    private class ScreenShotImageCell:BaseCellClass
    {
        override func setupViews() {
//            layer.masksToBounds = true
            addSubview(scImageView)
            NSLayoutConstraint.activate([
                scImageView.heightAnchor.constraint(equalTo: heightAnchor),
                scImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
                scImageView.widthAnchor.constraint(equalTo:widthAnchor)
                ])
        }
        let scImageView:UIImageView = {
           let iv = UIImageView()
            iv.translatesAutoresizingMaskIntoConstraints = false
            iv.contentMode = .scaleAspectFill
            iv.clipsToBounds = true
            return iv
        }()
    }
}

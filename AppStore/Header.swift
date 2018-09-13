//
//  Header.swift
//  AppStore
//
//  Created by Sherif  Wagih on 9/5/18.
//  Copyright © 2018 Sherif  Wagih. All rights reserved.
//

import UIKit
class Header: ApplicationsCell
{
    var bannerCategory:BannerCategory?{
        didSet{
            appsCollectionView.reloadData()
        }
    }
    let bannerCellId = "bannerCellId"
    override func setupViews() {
        appsCollectionView.dataSource = self
        appsCollectionView.delegate = self
        appsCollectionView.register(BannerCell.self, forCellWithReuseIdentifier: bannerCellId)
        addSubview(appsCollectionView)
        NSLayoutConstraint.activate([
            appsCollectionView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            appsCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            appsCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            appsCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = appsCollectionView.dequeueReusableCell(withReuseIdentifier: bannerCellId, for: indexPath) as! BannerCell
        if let app = bannerCategory?.apps[indexPath.item]
        {
            cell.app = app
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return  bannerCategory?.apps.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: frame.height )
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        featuredApps?.showCategory(for: (bannerCategory?.apps[indexPath.item])!)
    }
    
    private class BannerCell:ApplicationItemCell
    {
        override func setupViews() {
            appImageView.layer.cornerRadius = 0
            appImageView.layer.borderWidth = 0.5
            appImageView.layer.borderColor = UIColor(white: 0.5, alpha: 0.8).cgColor
            addSubview(appImageView)
            NSLayoutConstraint.activate(
                [
                    appImageView.topAnchor.constraint(equalTo: topAnchor),
                    appImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
                    appImageView.leftAnchor.constraint(equalTo: leftAnchor),
                    appImageView.rightAnchor.constraint(equalTo: rightAnchor)
                ]
            )
        }
    }
}

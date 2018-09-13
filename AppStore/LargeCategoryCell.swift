//
//  LargeCategoryCell.swift
//  AppStore
//
//  Created by Sherif  Wagih on 9/5/18.
//  Copyright © 2018 Sherif  Wagih. All rights reserved.
//

import UIKit

class LargeCategoryCell: ApplicationsCell
{
    let largeItemCellIdentifier = "largeItemCellIdentifier"
    override func setupViews() {
        super.setupViews()
        appsCollectionView.register(LargeAppItemCell.self, forCellWithReuseIdentifier: largeItemCellIdentifier)
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = appsCollectionView.dequeueReusableCell(withReuseIdentifier: largeItemCellIdentifier, for: indexPath) as! LargeAppItemCell
        if let app = category?.apps![indexPath.item]
        {
            cell.app = app
        }
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: frame.height - nameLabel.frame.height - 30)
    }
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    private class LargeAppItemCell:ApplicationItemCell
    {
        override func setupViews() {
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

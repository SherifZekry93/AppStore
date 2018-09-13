//
//  ApplicationItem.swift
//  AppStore
//
//  Created by Sherif  Wagih on 9/5/18.
//  Copyright © 2018 Sherif  Wagih. All rights reserved.
//

import UIKit
class ApplicationItemCell: UICollectionViewCell
{
    var app:App?{
        didSet{
            if let name = app?.ImageName
            {
                print(name)
                appImageView.image = UIImage(named: name)
            }
            if let label = app?.Name
            {
                nameLabel.text = label
            }
            if let category = app?.Category
            {
                
                categoryLabel.text = category
            }
            if let price = app?.Price
            {
                priceLabel.text = "\(price)"
            }
        }
    }
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        setupViews()
    }
    func setupViews()
    {
        backgroundColor = .clear
        addSubview(appImageView)
        addSubview(nameLabel)
        addSubview(categoryLabel)
        addSubview(priceLabel)
        NSLayoutConstraint.activate([
            appImageView.topAnchor.constraint(equalTo: topAnchor),
            appImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            appImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            appImageView.heightAnchor.constraint(equalTo: widthAnchor)
            ])
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: appImageView.bottomAnchor, constant: 5),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor ,constant: 2),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor,constant: 2),
            ])
        NSLayoutConstraint.activate(
            [
                categoryLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor,constant:2),
                categoryLabel.leadingAnchor.constraint(equalTo: leadingAnchor ,constant: 2),
                categoryLabel.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -2),
                ]
            
        )
        NSLayoutConstraint.activate(
            [
                priceLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor,constant:2),
                priceLabel.leadingAnchor.constraint(equalTo: leadingAnchor ,constant: 2),
                priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -2),
                ])
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    let appImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "flag")
        imageView.layer.cornerRadius = 16
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .gray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Disney Build It: Frozen"
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Entertainment"
        label.font = UIFont.systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .gray
        return label
    }()
    let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "$3.99"
        label.font = UIFont.systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .gray
        return label
    }()
}

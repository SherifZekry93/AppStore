//
//  ApplicationsCell.swift
//  AppStore
//
//  Created by Sherif  Wagih on 9/5/18.
//  Copyright © 2018 Sherif  Wagih. All rights reserved.
//

import UIKit
class ApplicationsCell: UICollectionViewCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    var category:AppCategory?{
        didSet
        {
            if let name = category?.name
            {
                nameLabel.text = name
            }
            else
            {
                return
            }
        }
    }
    var featuredApps:FeaturedApplicationsVC?
    let cellId = "applicatioinCell"
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = category?.apps?.count
        {
            return count
        }
        else
        {
            return 0
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        featuredApps?.showCategory(for: (category?.apps![indexPath.item])!)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = appsCollectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ApplicationItemCell
        if let app = category?.apps![indexPath.item]
        {
            cell.app = app
        }
        return cell
    }
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        setupViews()
        appsCollectionView.delegate = self
        appsCollectionView.dataSource = self
        appsCollectionView.register(ApplicationItemCell.self, forCellWithReuseIdentifier: cellId)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: frame.height - nameLabel.frame.height - 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews()
    {
        addSubview(appsCollectionView)
        addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            ])
        NSLayoutConstraint.activate([
            appsCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            appsCollectionView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 0),
            appsCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            appsCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            ])
        addSubview(dividerLineView)
        NSLayoutConstraint.activate([
            dividerLineView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            dividerLineView.heightAnchor.constraint(equalToConstant:1),
            dividerLineView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            dividerLineView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            ])
    }
    
    let appsCollectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    let dividerLineView:UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        lineView.translatesAutoresizingMaskIntoConstraints = false
        return lineView
    }()
    let nameLabel : UILabel = {
        let label = UILabel();
       // label.text = "Best New Apps"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
}

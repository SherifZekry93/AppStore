//
//  ViewController.swift
//  AppStore
//
//  Created by Sherif  Wagih on 9/5/18.
//  Copyright © 2018 Sherif  Wagih. All rights reserved.
//

import UIKit

class FeaturedApplicationsVC: UICollectionViewController,UICollectionViewDelegateFlowLayout{
    
    private let normalCategoryCellId = "normalCategoryCell"
    private let largeCategoryCellId = "largeCategoryCell"
    private let headerId = "headerId"
    var featuredApps:Featured?
    var appCategories:[AppCategory]?
    
    func loadApps()
    {
        Featured.fetchFeaturedApps(completionHandler: { (featuredApps) in
            self.featuredApps = featuredApps
            self.appCategories = featuredApps.categories
            self.collectionView?.reloadData()
        })
    }
    func showCategory(for app:App)
    {
        let layout = UICollectionViewFlowLayout()
        let controller = ApplicationDetailsController(collectionViewLayout: layout)
        controller.app = app
        navigationController?.pushViewController(controller, animated: true)
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        loadApps()
        collectionView?.register(ApplicationsCell.self, forCellWithReuseIdentifier: normalCategoryCellId)
        collectionView?.register(LargeCategoryCell.self, forCellWithReuseIdentifier: largeCategoryCellId)
        collectionView?.register(Header.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        collectionView?.backgroundColor = .white
        title = "Featured Apps"
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let newController = UIViewController()
        navigationController?.pushViewController(newController, animated: true)
    }
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! Header
        header.bannerCategory = featuredApps?.bannerCategory
        header.featuredApps = self
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 120)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = appCategories?.count
        {
            return count
        }
        return 0
    }
    
 
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item != 2
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: normalCategoryCellId, for: indexPath) as! ApplicationsCell
            if let category = appCategories?[indexPath.item]
            {
                cell.category = category
            }
            cell.featuredApps = self
            return cell
        }
        else
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: largeCategoryCellId, for: indexPath) as! LargeCategoryCell
            if let category = appCategories?[indexPath.item]
            {
                cell.category = category
            }
            cell.featuredApps = self
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 2
        {
            return CGSize(width: view.frame.size.width, height: 180)
        }
        return CGSize(width: view.frame.size.width, height: 290)
    }
}

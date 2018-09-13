//
//  ApplicationDetailsController.swift
//  AppStore
//
//  Created by Sherif  Wagih on 9/5/18.
//  Copyright © 2018 Sherif  Wagih. All rights reserved.
//

import UIKit
class ApplicationDetailsController:UICollectionViewController,UICollectionViewDelegateFlowLayout
{
    let headerId = "headerId"
    let screenShotsCellId = "screenShotsCellId"
    let AppDetailsCellId = "AppDetailsCellId"
    var app:App?{
        didSet{
            title = app?.Name
            if app?.Screenshots != nil
            {
                return
            }
            if let id = app?.Id
            {
                if let urlString = URL(string: "https://api.letsbuildthatapp.com/appstore/appdetail?id=\(id)")
                {
                URLSession.shared.dataTask(with: urlString) { (data, response, error) in
                    if error != nil
                    {
                        return
                    }
                    else
                    {
                        do
                        {
                            self.app =  try JSONDecoder().decode(App.self,from:data!)
                        }
                        catch let error
                        {
                            print(error)
                        }
                    }
                    DispatchQueue.main.async {
                        self.collectionView?.reloadData()
                    }
                }.resume()
                }
                }
                
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .white
        collectionView?.register(AppHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        collectionView?.register(ScreenShotsCell.self, forCellWithReuseIdentifier: screenShotsCellId)
        collectionView?.register(AppDetails.self, forCellWithReuseIdentifier: AppDetailsCellId)
    }
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! AppHeader
        header.app = app
        return header
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 250)
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 1
        {
            let dummysize = CGSize(width: view.frame.width, height: 1000)
            let options = NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin)
            let rect = descriptionAttributedText().boundingRect(with: dummysize, options: options, context: nil)
         return CGSize(width: view.frame.width, height: rect.height + 40)
        }
        return CGSize(width: view.frame.width, height: 200)
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 1
        {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppDetailsCellId, for: indexPath) as! AppDetails
            cell.textView.attributedText = descriptionAttributedText()
            return cell
        }
       else
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: screenShotsCellId, for: indexPath) as! ScreenShotsCell
            cell.app = app
            return cell
        }
        
    }
    private func descriptionAttributedText() -> NSAttributedString
    {
        let attributedText = NSMutableAttributedString(string: "Description:\n\n", attributes: [
             NSAttributedStringKey.font:UIFont.systemFont(ofSize: 20)
            ])
        if let desc = app?.description
        {
            attributedText.append(NSAttributedString(string: desc, attributes: [
                NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16),
                NSAttributedStringKey.foregroundColor:UIColor.gray
                ]))

        }
        return attributedText
    }
}

class AppDetails: BaseCellClass {
    let textView : UITextView = {
        let tv = UITextView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.text = "Sample Description"
        return tv
    }()
    let dividerLine: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    override func setupViews() {
        addSubview(textView)
        addSubview(dividerLine)
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            textView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            textView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            textView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            ])
        NSLayoutConstraint.activate([
            dividerLine.heightAnchor.constraint(equalToConstant: 1),
            dividerLine.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            dividerLine.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 14),
            dividerLine.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -14),
            ])
    }
}
class AppHeader: BaseCellClass
{
    
    var app:App?{
        didSet{
            if let imageName = app?.ImageName
            {
                appImageView.image = UIImage(named: imageName)
            }
            
            if let name = app?.Name
            {
                nameLabel.text = name
            }
            if let category = app?.Category
            {
                categoryLabel.text = category
            }

            if let price = app?.Price
            {
                print(price)
                buyButton.setTitle("\(price)", for: .normal)
            }
            
        }
    }
    
    let appImageView:UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleToFill
        iv.backgroundColor = .red
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 14
        return iv
    }()
    let dividerLine: UIView = {
       let view = UIView()
       view.backgroundColor = .lightGray
       view.translatesAutoresizingMaskIntoConstraints = false
       return view
    }()
    let segmentControl : UISegmentedControl = {
        let sg = UISegmentedControl(items: ["Details","Reviews","Related"])
        sg.translatesAutoresizingMaskIntoConstraints = false
        sg.selectedSegmentIndex = 0
        sg.tintColor = .gray
        return sg
    }()
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    let buyButton:UIButton = {
        let btn = UIButton(type: .system)
       btn.setTitle("Buy", for: .normal)
       btn.layer.borderColor = UIColor.blue.cgColor
       btn.layer.borderWidth = 0.6
       btn.translatesAutoresizingMaskIntoConstraints = false
       return btn
    }()
    override func setupViews() {
        addSubview(appImageView)
        addSubview(segmentControl)
        addSubview(nameLabel)
        addSubview(categoryLabel)
        addSubview(buyButton)
        addSubview(dividerLine)
        
        appImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            appImageView.topAnchor.constraint(equalTo: topAnchor,constant:14),
            appImageView.leadingAnchor.constraint(equalTo: leadingAnchor,constant:14),
            appImageView.heightAnchor.constraint(equalToConstant: 150),
            appImageView.widthAnchor.constraint(equalToConstant: 150)
            ])
        NSLayoutConstraint.activate([
            segmentControl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            segmentControl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            segmentControl.bottomAnchor.constraint(equalTo: bottomAnchor,constant:-20),
            segmentControl.heightAnchor.constraint(equalToConstant: 44)
            ])
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: appImageView.trailingAnchor, constant: 8),
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 14),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
            ])
        NSLayoutConstraint.activate([
            categoryLabel.leadingAnchor.constraint(equalTo: appImageView.trailingAnchor, constant: 8),
            categoryLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 14),
            categoryLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
            ])
        NSLayoutConstraint.activate([
            buyButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            buyButton.bottomAnchor.constraint(equalTo: appImageView.bottomAnchor, constant: 0),
            buyButton.widthAnchor.constraint(equalToConstant: 60)
            ])
        NSLayoutConstraint.activate([
            dividerLine.trailingAnchor.constraint(equalTo: trailingAnchor),
            dividerLine.bottomAnchor.constraint(equalTo: bottomAnchor),
            dividerLine.leadingAnchor.constraint(equalTo: leadingAnchor),
            dividerLine.heightAnchor.constraint(equalToConstant: 1),
            ])
    }
}
class BaseCellClass: UICollectionViewCell
{
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupViews()
    {
        
    }
}

//
//  ReviewsDetailCollectionCell.swift
//  CarSale
//
//  Created by Vadim on 5/18/17.
//  Copyright © 2017 Vadim Prosviryakov. All rights reserved.
//

import UIKit


final class ReviewsDetailImageCell: UICollectionViewCell {
    
    static let cellString = String(describing: ReviewsDetailImageCell.self)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    func setupViews() {
        addSubview(imageView)
        imageView.frame = CGRect(x: 0, y: 8, width: self.bounds.width, height: self.bounds.height)
    }
}


final class ReviewsDetailCollectionCell: UITableViewCell {
    
    static let cellString = String(describing: ReviewsDetailCollectionCell.self)
    var newFormImage: [UIImage]?
    var collectionView: UICollectionView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ReviewsDetailImageCell.self, forCellWithReuseIdentifier: ReviewsDetailImageCell.cellString)
        collectionView.translatesAutoresizingMaskIntoConstraints = true 
        collectionView.backgroundColor = UIColor.clear
        self.addSubview(collectionView)
        addConstraintsWithFormat("H:|[v0]|", views: collectionView)
        addConstraintsWithFormat("V:|[v0]|", views: collectionView)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension ReviewsDetailCollectionCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: self.bounds.width, height: self.bounds.height) // The size of one cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(10, 0, 10, 0) // margin between cells
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.bounds.width, height: self.bounds.height)
    }
    
}

// MARK: UICollectionViewDataSource
extension ReviewsDetailCollectionCell: UICollectionViewDataSource {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newFormImage!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReviewsDetailImageCell.cellString, for: indexPath as IndexPath) as! ReviewsDetailImageCell
        
        if !(newFormImage?.isEmpty)! {
            cell.imageView.image = newFormImage![indexPath.row]
        }
        return cell
    }
}


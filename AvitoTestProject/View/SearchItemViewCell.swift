//
//  SearchItemViewCell.swift
//  AvitoTestProject
//
//  Created by Alibek Ismagulov on 10.04.2024.
//

import UIKit

//Custom reusable cell for preview on main screen

class SearchItemViewCell: UICollectionViewCell {
    
    var previewLabel : UILabel = UILabel(frame: CGRect.zero)
    var previewType : UIImageView = UIImageView(frame: CGRect.zero)
    var previewImage : UIImageView = UIImageView(frame: CGRect.zero)
    
    override init(frame:CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: -- Extensions

extension SearchItemViewCell {
    func setupLayout() {


        contentView.addSubview(previewImage)
        configureImage()
        contentView.addSubview(previewLabel)
        configureLabel()
        contentView.addSubview(previewType)
        configureType()
    }
    
    func configureLabel() {
    
        previewLabel.frame.origin = CGPoint(x: 0, y: 136)
        previewLabel.frame.size = CGSize(width: self.frame.width, height: 45)
        previewLabel.textAlignment = .center
        previewLabel.numberOfLines = 0
        previewLabel.backgroundColor = UIColor(red: 55/255, green: 120/255, blue: 250/255, alpha: 1)
        previewLabel.layer.borderWidth = 3
        previewLabel.layer.borderColor = UIColor(red: 55/255, green: 120/255, blue: 250/255, alpha: 1).cgColor
        previewLabel.textColor = .white
    
    }
    
    func configureImage() {
        
        previewImage.frame.size = CGSize(width: self.frame.width, height: self.frame.height)
    
    }
    func configureType() {
        previewType.tintColor = .white
        previewType.frame.size = CGSize(width: 15, height: 15)
    
    }
    
}


//
//  SecondViewController.swift
//  AvitoTestProject
//
//  Created by Alibek Ismagulov on 07.04.2024.
//

import UIKit

class ResultViewController: UITableViewController {
    
    var resultItem = SearchItems()
    
    var authorDetails = Author()
    
    let nameLabel = UILabel()
    let artistName = UILabel()
    let wrapperType = UILabel()
    let artistType = UILabel()
    let artistGenre = UILabel()
    let longDescription = UILabel()
    
    let posterImage = UIImageView()
    let titleLabel = UILabel()

    let posterDownloadController = PosterDownloadController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
    }
}

extension ResultViewController {
    
    func setupLayout() {

        configureTitleLabel()
        
        view.addSubview(posterImage)
        configureImage()
        view.addSubview(nameLabel)
        setupNameLabel()
        view.addSubview(artistName)
        setupArtistName()
        view.addSubview(wrapperType)
        setupWrapperType()
        view.addSubview(artistType)
        view.addSubview(artistGenre)
//        setupArtist()
        view.addSubview(longDescription)
        setupDescription()
        
//        setupConstraints()
        
        navigationItem.titleView = titleLabel
        
    }
    
    func setupNameLabel() {
        
        if resultItem.name == nil {
            nameLabel.text = resultItem.backUpName
        } else {
            nameLabel.text = resultItem.name
        }
        
        nameLabel.textColor = UIColor(red: 55/255, green: 120/255, blue: 250/255, alpha: 1)
        nameLabel.textAlignment = .center
        nameLabel.numberOfLines = 0
        nameLabel.font = .systemFont(ofSize: 25)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: posterImage.bottomAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            nameLabel.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),

        ])
        
    }
    
    func setupArtistName() {
        
        if let name = resultItem.author {
            artistName.text = name
        }
        artistName.textColor = UIColor(red: 55/255, green: 120/255, blue: 250/255, alpha: 1)
        artistName.textAlignment = .center
        artistName.numberOfLines = 0
        artistName.font = .systemFont(ofSize: 20)
        artistName.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            artistName.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            artistName.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            artistName.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),

        ])
        
    }
    
    func setupWrapperType() {
        
        if let itemType = resultItem.kind {
            wrapperType.text = "Type is: \(itemType)"
        } else {
            wrapperType.text = "Type is: \(resultItem.type!)"
        }
        
        wrapperType.textColor = UIColor(red: 55/255, green: 120/255, blue: 250/255, alpha: 1)
        wrapperType.textAlignment = .center
        wrapperType.numberOfLines = 0
        wrapperType.font = .systemFont(ofSize: 15)
        wrapperType.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([

            wrapperType.topAnchor.constraint(equalTo: artistName.bottomAnchor),
            wrapperType.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            wrapperType.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),

        ])
        
    }
    
//    func setupArtist() {
//        
//        let fetchItems = FetchItems()
//        if let authorId = resultItem.authorID {
//            fetchItems.fetchAuthor(authorId) { result in
//                switch result {
//                case .success(let success):
//                    self.authorDetails = success
//                case .failure(_):
//                    break
//                }
//            }
//        }
//        artistType.textColor = UIColor(red: 55/255, green: 120/255, blue: 250/255, alpha: 1)
//        artistType.textAlignment = .center
//        artistType.numberOfLines = 0
//        artistType.font = .systemFont(ofSize: 15)
//        artistType.translatesAutoresizingMaskIntoConstraints = false
//        if let unWrappedType = self.authorDetails.artistType {
//            artistType.text = unWrappedType
//        }
//        
//        artistGenre.textColor = UIColor(red: 55/255, green: 120/255, blue: 250/255, alpha: 1)
//        artistGenre.textAlignment = .center
//        artistGenre.numberOfLines = 0
//        artistGenre.font = .systemFont(ofSize: 15)
//        artistGenre.translatesAutoresizingMaskIntoConstraints = false
//        
//        if let unWrappedGenre = self.authorDetails.primaryGenreName {
//            artistGenre.text = unWrappedGenre
//        }
//        NSLayoutConstraint.activate([
//
//            artistType.topAnchor.constraint(equalTo: wrapperType.bottomAnchor),
//            artistType.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
//            artistType.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
//            artistGenre.topAnchor.constraint(equalTo: artistType.bottomAnchor),
//            artistGenre.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
//            artistGenre.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
//
//        ])
//    }
//    
    func setupDescription() {

        guard let description = resultItem.description else { return }
        
        longDescription.text = description
        longDescription.textColor = UIColor(red: 55/255, green: 120/255, blue: 250/255, alpha: 1)
        longDescription.textAlignment = .center
        longDescription.numberOfLines = 0
        longDescription.font = .systemFont(ofSize: 15)
        
        longDescription.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            longDescription.topAnchor.constraint(equalTo:  wrapperType.bottomAnchor),
            longDescription.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            longDescription.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),

        ])
        
    }
    
    func configureTitleLabel() {
       
        titleLabel.numberOfLines = 0
        titleLabel.font = .systemFont(ofSize: 25)
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        if resultItem.name == nil {
            titleLabel.text = resultItem.backUpName
        } else {
            titleLabel.text = resultItem.name
        }
    }
    
    func configureImage() {
        
        posterImage.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height/2)
        posterImage.bounds = posterImage.frame.insetBy(dx: 10, dy: 10)
        
        guard let poster = resultItem.poster else { return }
        posterDownloadController.download(searchURL: poster) { result in
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    self.posterImage.image = UIImage(data: success!)
                }
            case .failure(_):
                self.posterImage.image = UIImage(systemName: "person.slash.fill")
            }
        }
        
        NSLayoutConstraint.activate([
            posterImage.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            posterImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        ])
    }
    
//    func setupConstraints() {
//        
//        NSLayoutConstraint.activate([
//            posterImage.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
//            posterImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            nameLabel.topAnchor.constraint(equalTo: posterImage.bottomAnchor),
//            nameLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
//            nameLabel.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
//            artistName.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
//            artistName.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
//            artistName.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
//            wrapperType.topAnchor.constraint(equalTo: artistName.bottomAnchor),
//            wrapperType.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
//            wrapperType.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
////            artistType.topAnchor.constraint(equalTo: wrapperType.bottomAnchor),
////            artistType.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
////            artistType.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
////            artistGenre.topAnchor.constraint(equalTo: artistType.bottomAnchor),
////            artistGenre.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
////            artistGenre.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
//            longDescription.topAnchor.constraint(equalTo:  wrapperType.bottomAnchor),
//            longDescription.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
//            longDescription.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
//
//        ])
//    }
}


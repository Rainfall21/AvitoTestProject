//
//  ViewController.swift
//  AvitoTestProject
//
//  Created by Alibek Ismagulov on 07.04.2024.
//

import UIKit


//MARK: - View Controller

final class SearchViewController: UICollectionViewController {

    //MARK: -- Variables
    
    let posterDownloadController = PosterDownloadController()
    let historySavingController = HistorySavingController()
    var searchHistory = [String]()
    var filteredQuery = [String]()
    var searchItems : [SearchItems] = []
    let searchBar = UISearchBar()
    var searchHistoryView  = UITableView()
    var filterView = UIView()
    
    var limitResult = true
    //query limit is for limiting query result counts
    var queryLimit = true
    
    let columnLayout = ColumnFlowLayout(
        
        cellsPerRow: 2,
        minimumInteritemSpacing: 10,
        minimumLineSpacing: 10,
        sectionInset: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    )

    //MARK: -- ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: -- Delegates
        searchHistoryView.dataSource = self
        searchHistoryView.delegate = self
        collectionView.delegate = self
        
        filteredQuery = historySavingController.readData()
        searchHistory = filteredQuery

        collectionView.addSubview(searchHistoryView)
        collectionView.addSubview(filterView)
        
        filterView.isHidden = true
        searchHistoryView.isHidden = true
        //MARK: -- Reusable Cells
        collectionView.register(SearchItemViewCell.self, forCellWithReuseIdentifier: "searchItemViewCell")
        searchHistoryView.register(UITableViewCell.self, forCellReuseIdentifier: "TableCell")
        
        
        setupLayout()
        
    }
    
    //MARK: - Reusable cell
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // in case of disabled query result count limit
        limitResult && searchItems.count > 30 ? 30 : searchItems.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "searchItemViewCell", for: indexPath) as! SearchItemViewCell
        
        if searchItems[indexPath[1]].downloadedPoster != nil {
            posterDownloadController.download(searchURL: searchItems[indexPath[1]].poster!) { result in
                switch result {
                case .success(let success):
                    DispatchQueue.main.async {
                        cell.previewImage.image = UIImage(data: success!)
                    }
                case .failure(_):
                    cell.previewImage.image = UIImage(systemName: "person.slash.fill")
                }
            }
        } else {
            cell.previewImage.image = UIImage(systemName: "person.slash.fill")
        }
        
        if searchItems[indexPath[1]].name == nil {
            cell.previewLabel.text = searchItems[indexPath[1]].backUpName
        } else {
            cell.previewLabel.text = searchItems[indexPath[1]].name
        }
        
        if let contentType = ContentTypes(rawValue: searchItems[indexPath[1]].kind ?? "unknown") {
            
            /* Was trying to do proper enums. Failed. Work in progress. Want to replace with single line of code*/
            
            switch contentType {
                
            case .book:
                cell.previewType.image = UIImage(systemName: "book.circle")
            case .album:
                cell.previewType.image = UIImage(systemName: "photo.circle.fill")
            case .coachedAudio:
                cell.previewType.image = UIImage(systemName: "waveform.circle.fill")
            case .featureMovie:
                cell.previewType.image = UIImage(systemName: "movieclapper.fill")
            case .interactiveBooklet:
                cell.previewType.image = UIImage(systemName: "book.pages.fill")
            case .musicVideo:
                cell.previewType.image = UIImage(systemName: "video.circle")
            case .pdfPodcast:
                cell.previewType.image = UIImage(systemName: "music.mic.circle.fill")
            case .podcastEpisode:
                cell.previewType.image = UIImage(systemName: "music.mic.circle.fill")
            case .softwarePackage:
                cell.previewType.image = UIImage(systemName: "gearshape.fill")
            case .song:
                cell.previewType.image = UIImage(systemName: "music.quarternote.3")
            case .tvEpisode:
                cell.previewType.image = UIImage(systemName: "tv.fill")
            case .artist:
                cell.previewType.image = UIImage(systemName: "person.fill")
            case .unknown:
                cell.previewType.image = UIImage(systemName: "questionmark.app.fill")
            }
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "resultViewControllerSegue" {
            if let indexPath = self.collectionView.indexPathsForSelectedItems {
                let destination = segue.destination as! ResultViewController
                destination.resultItem = searchItems[indexPath[0][1]]
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
            self.performSegue(withIdentifier: "resultViewControllerSegue", sender: cell)
            searchHistoryView.isHidden = true
            filterView.isHidden = true
        }
    }
}

    
//MARK: -- Extensions
//MARK: - SearchBar

extension SearchViewController : UISearchBarDelegate {
    

    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        filterView.isHidden = true
        
        guard let searchText = searchBar.text else { return }
        
        let historySavingController = HistorySavingController()
        if searchBar.text != "" {
            historySavingController.saveData(searchBar.text!)
        }

        let fetchItemsModel = FetchItems()
        fetchItemsModel.fetchItem(searchText) { result in
            switch result {
            case .success(let success):
                self.searchItems = success
                if self.searchItems.count != 0 {
                    self.collectionView.reloadData()
                } else {
                    searchBar.text = ""
                    searchBar.placeholder = "Nothing was found. Try again..."
                }
                
            case .failure(_):
                searchBar.placeholder = "Nothing was found. Try again..."
            }
        }
        searchHistoryView.isHidden = true
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filterView.isHidden = true
        
        if searchText == "" {
            searchItems.removeAll()
            searchHistoryView.isHidden = true
            self.collectionView.reloadData()
        } else {
            searchHistoryView.isHidden = false
            filteredQuery = searchText.isEmpty ? searchHistory : searchHistory.filter { (item: String) -> Bool in
                return item.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
            }
        }

        self.collectionView.reloadData()
        searchHistoryView.reloadData()
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        filterView.isHidden = false
    }
}

//MARK: - Search History

extension SearchViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredQuery.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = filteredQuery[indexPath.row]
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        filterView.isHidden = true
        searchBar.text = filteredQuery[indexPath.row]
        searchBar.delegate?.searchBarSearchButtonClicked?(searchBar)
    }
    
    
    
}

//MARK: - Setup Layout
extension SearchViewController {
    
    //Was trying to add filter button with filter properties. Not enough time. Work in progress.
    
//    @objc func showFilter() {
//        
//        filterView.isHidden = !filterView.isHidden
//        filterView.frame.size.width = view.frame.size.width
//        filterView.frame.size.width = 150
//        filterView.backgroundColor = UIColor(red: 55/255, green: 120/255, blue: 250/255, alpha: 1)
//        let queryCount = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 15))
//        queryCount.font = .systemFont(ofSize: 10)
//        queryCount.textColor = .white
//        queryCount.backgroundColor = UIColor(red: 55/255, green: 120/255, blue: 250/255, alpha: 1)
//        let limitSwitch = UISwitch(frame: CGRect(x: 50, y: 50, width: 40, height: 40))
//        limitSwitch.backgroundColor = .red
//        let titleSwitch = UILabel(frame: CGRect(x: 0, y: 50, width: 40, height: 40))
//        if searchItems.isEmpty {
//            queryCount.text = "Query Limit is 30"
//        } else {
//            queryCount.text = "Found \(searchItems.count) results. Query Limit is 30"
//        }
//        
//        titleSwitch.text = "Show More"
//        limitSwitch.isOn = false
//        filterView.addSubview(queryCount)
//        filterView.addSubview(limitSwitch)
//        filterView.addSubview(titleSwitch)
//        limitSwitch.addTarget(self, action: #selector(switchValueDidChanged(_:)), for: .valueChanged)
//        
//        
//    }
    
//    @objc func switchValueDidChanged(_ sender: UISwitch) {
//        queryLimit = sender.isOn
//    }
    
    func setupLayout() {
        
        searchHistoryView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 300)
        collectionView.collectionViewLayout = columnLayout
        collectionView.contentInsetAdjustmentBehavior = .always
        searchBar.delegate = self

        let appearance = UINavigationBarAppearance()
        
        configureLayout()
        
        func configureLayout() {
            
            let searchText = searchBar.value(forKey: "searchField") as? UITextField
            
            collectionView.backgroundColor = .white
            
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor(red: 55/255, green: 120/255, blue: 250/255, alpha: 1)
            appearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
            
            navigationItem.titleView = searchBar
            searchBar.sizeToFit()
            searchText?.textColor = .white
            searchBar.placeholder = "Type something to search"
            searchBar.setImage(UIImage(systemName: "x.circle.fill"), for: .clear, state: .normal)
            
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationItem.title = "iTunes Search App"
            navigationController?.navigationBar.isTranslucent = false
            navigationController?.navigationBar.barStyle = .black
            navigationController?.navigationBar.tintColor = .white
            _ = UIImage(named: "filter")
            navigationItem.hidesSearchBarWhenScrolling = false
            
            // navigation bar button for filter
//            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal.decrease.circle.fill"), style: .plain, target: self, action: #selector(showFilter))
        }
    }
}

//TODO: - Add Filters


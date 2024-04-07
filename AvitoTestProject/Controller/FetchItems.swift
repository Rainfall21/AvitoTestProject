//
//  SearchModel.swift
//  AvitoTestProject
//
//  Created by Alibek Ismagulov on 08.04.2024.
//

import Foundation
import UIKit



class FetchItems : ObservableObject {
    
    var posterDownloadController = PosterDownloadController()
    let url = "https://itunes.apple.com/search?term="
    let lookUpUrl = "https://itunes.apple.com/lookup?id="
    
    //MARK: - Fetch Data from default query
    
    func fetchItem(_ searchText : String, completion: @escaping (Result<[SearchItems], Error>) -> Void) {
        let urlString = url + modifyText(searchText)
        let url = URL(string: urlString)
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            DispatchQueue.main.async { [self] in
                if let data {
                    do {
                        let searchItems = try JSONDecoder().decode(SearchResultsModel.self, from: data).results
                        completion(.success(searchItems))
                    } catch {
                        completion(.failure(error))
                    }
                }
            }
        }
        task.resume()
    }
    
    //MARK: - Fetch Data from lookup query
    
    func fetchAuthor(_ id : Int, completion: @escaping (Result<Author, Error>) -> Void) {
        let urlString = lookUpUrl + String(id)
        let url = URL(string: urlString)
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            DispatchQueue.main.async { [self] in
                if let data {
                    do {
                        let authorSearch = try JSONDecoder().decode(AuthorResultsModel.self, from: data).results
                        completion(.success(authorSearch.first!))
                    } catch {
                        completion(.failure(error))
                    }
                }
            }
        }
        task.resume()
    }
    
    //MARK: - Modify search text
    // Modify search text in order to replace blanks
    
    func modifyText( _ searchText : String) -> String {

        return searchText.lowercased().replacingOccurrences(of: " ", with: "+")
    }
}

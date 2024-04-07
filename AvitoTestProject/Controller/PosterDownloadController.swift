//
//  PosterDownloadController.swift
//  AvitoTestProject
//
//  Created by Alibek Ismagulov on 13.04.2024.
//

import Foundation
import UIKit

//MARK: - Poster Download
//Query to download poster

class PosterDownloadController {
    
    func download(searchURL: String, completion: @escaping (Result<Data?, Error>) -> Void) {
        
        let url = URL(string: modifyURL(url: searchURL))!
        
        DispatchQueue.global().async {
            do {
                guard let data =  try? Data(contentsOf: url) else { return }
                completion(.success(data))
            } catch {
                completion(.failure(error))
            }
        }
    }
    //Modify url to download image of better quality
    func modifyURL(url : String) -> String {
        return url.replacingOccurrences(of: "100x100bb.jpg", with: "1000x1000bb.jpg")
    }
}

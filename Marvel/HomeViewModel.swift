//
//  HomeViewModel.swift
//  Marvel
//
//  Created by Abhishek on 09/10/23.
//

import Foundation
class HomeViewModel: NSObject{
    
    var limit = 20
    var offset = 0
    var marvelCharacters: MarvelCharacterData?
    
    func characters(parameters: [String: Any], completion: @escaping((_ success: Bool, _ message: String) -> Void)){
        let url = AppUrl.baseURL.rawValue+AppUrl.characters.rawValue
        NetworkManager.shared.getRequest(param: parameters, url: url) {[weak self] (data, response, error) in
            if error == nil{
                if let response = response as? HTTPURLResponse{
                    switch response.statusCode{
                    case 200:
                        guard let data = data else {
                            completion(false, "Something went wrong")
                            return
                        }
                        if let data = try? JSONDecoder().decode(MarvelCharacterData.self, from: data){
                            if self?.marvelCharacters == nil{
                                self?.marvelCharacters = data
                            }else{
                                self?.marvelCharacters?.data.results.append(contentsOf: data.data.results)
                            }
                        }
                        completion(true, "SUCCESS")
                    default:
                        if let data = try? JSONDecoder().decode(ErrorCode.self, from: data ?? Data.init()){
                            completion(false, data.message ?? "Something went wrong")
                        }
                    }
                }
            }
        }
    }
}

//
//  ComicsViewModel.swift
//  Marvel
//
//  Created by Abhishek on 10/10/23.
//

import Foundation
class ComicsViewModel: NSObject{
    var limit = 20
    var offset = 0
    var comic: ComicData?
    var dateDescriptor: String?
    
    func characters(parameters: [String: Any], completion: @escaping((_ success: Bool, _ message: String) -> Void)){
        let url = AppUrl.baseURL.rawValue+AppUrl.comics.rawValue
        NetworkManager.shared.getRequest(param: parameters, url: url) {[weak self](data, response, error) in
            if error == nil{
                if let response = response as? HTTPURLResponse{
                    switch response.statusCode{
                    case 200:
                        guard let data = data else {
                            completion(false, "Something went wrong")
                            return
                        }
                        if let data = try? JSONDecoder().decode(ComicData.self, from: data){
                            if self?.comic == nil{
                                self?.comic = data
                            }else{
                                if let result = data.data?.results{
                                    self?.comic?.data?.results?.append(contentsOf: result)
                                }
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

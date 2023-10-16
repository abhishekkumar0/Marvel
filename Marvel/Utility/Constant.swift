//
//  Constant.swift
//  Marvel
//
//  Created by Abhishek on 08/10/23.
//

import UIKit
import CryptoKit
let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height
let appDelegate = UIApplication.shared.delegate as? AppDelegate
let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
let UDID = UIDevice.current.identifierForVendor?.description
let appVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String

var userTappedOnSearch: (() -> Void)?
//var userSelectingSearchedResult: ((_ search: String) -> Void)?
//MARK: - In real world applications we do not use project to save key we use backend services to keep them secure
let publicKey = "91ae6eade6ef6783f1de2869cd624fb9"
let privateKey = "ba899c6da5ac75f77eb90d77efd4978104c7b093"

func MD5(data: Data) -> String {
    let hash = Insecure.MD5.hash(data: data)
    return hash.map { String(format: "%02hhx", $0) }.joined()
}

func getTimeStampAndHash() -> (timeStamp: String, hash: String){
    let timestamp = "\(Date().timeIntervalSince1970)"
    let dataToHash = "\(timestamp)\(privateKey)\(publicKey)".data(using: .utf8)!
    return (timestamp, MD5(data: dataToHash))
}

enum RequestType: String {
  case GET
  case POST
}

struct ErrorCode: Codable{
    let code: String?
    let message: String?
}

enum SENDDATA: String{
    case DISMISSVIEW
    case FILTERSELECTED
}

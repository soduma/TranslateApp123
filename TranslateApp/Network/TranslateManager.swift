//
//  TranslateManager.swift
//  TranslateApp
//
//  Created by 장기화 on 2022/01/16.
//

import Foundation
import Alamofire

struct TranslateManager {
    var sourceLanguage: Language = .ko
    var targetLanguage: Language = .en
    
    func translate(from text: String, completionHandler: @escaping (String) -> Void) {
        guard let url = URL(string: "https://openapi.naver.com/v1/papago/n2mt") else { return }
        
        let request = RequestModel(source: sourceLanguage.rawValue, target: targetLanguage.rawValue, text: text)
        
        let headers: HTTPHeaders = [
            "X-Naver-Client-Id": "0j4tqjOaPpsCz1pEj4CJ",
            "X-Naver-Client-Secret": "Vgn33JMhM5"
        ]
        
        AF
            .request(url, method: .post, parameters: request, headers: headers)
            .responseDecodable(of: Papago.self) { response in
                switch response.result {
                case .success(let result):
                    completionHandler(result.translatedText)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            .resume()
    }
}

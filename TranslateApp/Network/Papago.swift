//
//  Papago.swift
//  TranslateApp
//
//  Created by 장기화 on 2022/01/16.
//

import Foundation

struct Papago: Codable {
    private let message: Message
    
    var translatedText: String { message.result.translatedText }
}

struct Message: Codable {
    let result: Result
}

struct Result: Codable {
    let translatedText: String
}

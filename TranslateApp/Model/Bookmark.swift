//
//  Bookmark.swift
//  TranslateApp
//
//  Created by 장기화 on 2022/01/14.
//

import Foundation

struct Bookmark: Codable {
    let sourceLanguage: Language
    let translatedLanguage: Language
    
    let sourceText: String
    let translatedText: String
}

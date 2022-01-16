//
//  Language.swift
//  TranslateApp
//
//  Created by 장기화 on 2022/01/14.
//

import Foundation

enum Language: String, CaseIterable, Codable { //enum에서 코더블 사용할땐 꼭 스트링도 같이 해줘야함
    case ko
    case en
    case ja
    case ch
    
    var title: String {
        switch self {
        case .ko: return "한국어"
        case .en: return "영어"
        case .ja: return "일본어"
        case .ch: return "중국어"
        }
    }
}

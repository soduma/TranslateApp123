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
    case ch = "zh-CN"
    
    var title: String {
        switch self {
        case .ko: return NSLocalizedString("Korean", comment: "")
        case .en: return NSLocalizedString("English", comment: "")
        case .ja: return NSLocalizedString("Japanese", comment: "")
        case .ch: return NSLocalizedString("Chinese", comment: "")
        }
    }
    
    var languageCode: String {
        self.rawValue
    }
}

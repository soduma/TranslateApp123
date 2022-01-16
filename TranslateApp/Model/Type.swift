//
//  Type.swift
//  TranslateApp
//
//  Created by 장기화 on 2022/01/16.
//

import UIKit

enum `Type` {
    case source
    case target
    
    var color: UIColor {
        switch self {
        case .source: return .label
        case .target: return .mainTintColor
        }
    }
}

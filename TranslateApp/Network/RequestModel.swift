//
//  RequestModel.swift
//  TranslateApp
//
//  Created by 장기화 on 2022/01/16.
//

import Foundation

struct RequestModel: Codable {
    let source: String
    let target: String
    let text: String
}

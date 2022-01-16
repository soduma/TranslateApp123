//
//  BookmarkCollectionViewCell.swift
//  TranslateApp
//
//  Created by 장기화 on 2022/01/14.
//

import UIKit
import SnapKit

class BookmarkCollectionViewCell: UICollectionViewCell {
    static let identifier = "BookmarkCollectionViewCell"
    
    private var sourceBookmarkStackView = BookmarkTextStackView(language: .ko, text: "안녕하세요", type: Type.source)
    
    private var targetBookmarkStackView = BookmarkTextStackView(language: .en, text: "Hello", type: Type.target)
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 16
        
        stackView.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    func setUp(from bookmark: Bookmark) {
        backgroundColor = .systemBackground
        layer.cornerRadius = 12
        
        sourceBookmarkStackView = BookmarkTextStackView(language: bookmark.sourceLanguage, text: bookmark.sourceText, type: .source)
        
        targetBookmarkStackView = BookmarkTextStackView(language: bookmark.translatedLanguage, text: bookmark.translatedText, type: .target)
        
        //북마크 리스트 꼬임방지를 위해 전체 삭제
        stackView.subviews.forEach { $0.removeFromSuperview() }
        //그리고 추가
        [sourceBookmarkStackView, targetBookmarkStackView]
            .forEach { stackView.addArrangedSubview($0) }
        
        addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(UIScreen.main.bounds.width - 32)
        }
        
        layoutIfNeeded()
    }
}


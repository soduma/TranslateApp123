//
//  TranslateViewController.swift
//  TranslateApp
//
//  Created by 장기화 on 2022/01/14.
//

import UIKit
import SnapKit

class TranslateViewController: UIViewController {
    private lazy var languageButton: UIButton = {
        let button = UIButton()
        button.setTitle("한국어", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .systemBackground
        button.layer.cornerRadius = 9
        return button
    }()
    
    private lazy var targetButton: UIButton = {
        let button = UIButton()
        button.setTitle("영어", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .systemBackground
        button.layer.cornerRadius = 9
        return button
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        [languageButton, targetButton]
            .forEach { stackView.addArrangedSubview($0) }
        return stackView
    }()
    
    private lazy var resultView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        return view
    }()
    
    private lazy var resultLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .mainTintColor
        label.text = "달이 익어가니 서둘러 젊은 피야 민들레 한 송이 들고 사랑이 어지러이 떠다니는 밤이야 날아가 사뿐히 이루렴 팽팽한 어둠 사이로 떠오르는 기분 이 거대한 무중력에 혹 휘청해도 두렵진 않을 거야 푸르른 우리 위로 커다란 strawberry moon 한 스쿱"
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var bookmarkButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "bookmark"), for: .normal)
        return button
    }()
    
    private lazy var copyButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "doc.on.doc"), for: .normal)
        return button
    }()
    
    private lazy var sourceView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        return view
    }()
    
    private lazy var sourceLabel: UILabel = {
        let label = UILabel()
//        label.font = .systemFont(ofSize: 23, weight: .bold)
        label.textColor = .tertiaryLabel
        label.text = "텍스트 입력"
//        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .secondarySystemBackground
        setUpView()
    }
}

extension TranslateViewController {
    func setUpView() {
        [buttonStackView, resultView, resultLabel, bookmarkButton, copyButton, sourceView, sourceLabel]
            .forEach { view.addSubview($0) }
        
        let defaultSpacing: CGFloat = 20
        
        buttonStackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(defaultSpacing)
            $0.leading.trailing.equalToSuperview().inset(defaultSpacing)
            $0.height.equalTo(50)
        }
        
        resultView.snp.makeConstraints {
            $0.top.equalTo(buttonStackView.snp.bottom).offset(defaultSpacing)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(resultLabel).offset(100)
        }
        
        resultLabel.snp.makeConstraints {
            $0.top.equalTo(resultView).inset(defaultSpacing)
            $0.leading.trailing.equalTo(resultView).inset(defaultSpacing)
        }
        
        bookmarkButton.snp.makeConstraints {
            $0.leading.equalTo(resultView).inset(defaultSpacing)
            $0.bottom.equalTo(resultView).inset(defaultSpacing)
            $0.width.height.equalTo(40)
        }
        
        copyButton.snp.makeConstraints {
            $0.top.bottom.equalTo(bookmarkButton)
            $0.leading.equalTo(bookmarkButton.snp.trailing).offset(10)
        }
        
        sourceView.snp.makeConstraints {
            $0.top.equalTo(resultView.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
        
        sourceLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(sourceView).inset(defaultSpacing)
        }
    }
}

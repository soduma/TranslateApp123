//
//  TranslateViewController.swift
//  TranslateApp
//
//  Created by 장기화 on 2022/01/14.
//

import UIKit
import SnapKit

class TranslateViewController: UIViewController {
    private var translateManager = TranslateManager()
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    private lazy var languageButton: UIButton = {
        let button = UIButton()
        button.setTitle(translateManager.sourceLanguage.title, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .systemBackground
        button.layer.cornerRadius = 9
        
        button.addTarget(self, action: #selector(tapSourceLanguageButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var targetButton: UIButton = {
        let button = UIButton()
        button.setTitle(translateManager.targetLanguage.title, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .systemBackground
        button.layer.cornerRadius = 9
        
        button.addTarget(self, action: #selector(tapTargetLanguageButton), for: .touchUpInside)
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
        label.text = "😎"
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var bookmarkButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "bookmark"), for: .normal)
        button.addTarget(self, action: #selector(tapBookmarkButton), for: .touchUpInside)
        return button
    }()
    
    @objc func tapBookmarkButton() {
        guard let translatedText = resultLabel.text,
              let sourceText = sourceLabel.text,
              bookmarkButton.imageView?.image == UIImage(systemName: "bookmark") else { return }
        
        bookmarkButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        
        let currentBookmarks: [Bookmark] = UserDefaults.standard.bookmarks
        let newBookmark = Bookmark(sourceLanguage: translateManager.sourceLanguage, translatedLanguage: translateManager.targetLanguage, sourceText: sourceText, translatedText: translatedText)
        
        UserDefaults.standard.bookmarks = [newBookmark] + currentBookmarks
        print(UserDefaults.standard.bookmarks)
    }
    
    private lazy var copyButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "doc.on.doc"), for: .normal)
        button.addTarget(self, action: #selector(tapCopyButton), for: .touchUpInside)
        return button
    }()
    
    @objc func tapCopyButton() {
        UIPasteboard.general.string = resultLabel.text
    }
    
    private lazy var sourceView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapSourceView))
        view.addGestureRecognizer(gesture)
        return view
    }()
    
    @objc func tapSourceView() {
        present(SourceTextViewController(delegate: self), animated: true, completion: nil)
    }
    
    private lazy var sourceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .tertiaryLabel
        label.text = NSLocalizedString("Enter Text", comment: "")
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .secondarySystemBackground
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.top.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.edges.width.equalToSuperview()
        }
        
        setUpView()
    }
}

extension TranslateViewController {
    func setUpView() {
        [buttonStackView, resultView, resultLabel, bookmarkButton, copyButton, sourceView, sourceLabel]
            .forEach { contentView.addSubview($0) }
        
        let defaultSpacing: CGFloat = 20
        
        buttonStackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(defaultSpacing)
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
            $0.bottom.equalToSuperview().inset(10)
            $0.height.equalTo(100)
            $0.height.equalTo(sourceLabel).offset(20)
        }
        
        sourceLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(sourceView).inset(defaultSpacing)
        }
    }
    
    @objc func tapSourceLanguageButton() {
        tapLanguageButton(type: .source)
    }
    
    @objc func tapTargetLanguageButton() {
        tapLanguageButton(type: .target)
    }
    
    func tapLanguageButton(type: Type) { //enum은 @objc에 넣을 수 없음
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        Language.allCases.forEach { language in
            let action = UIAlertAction(title: language.title, style: .default) { _ in
                switch type {
                case .source:
                    self.translateManager.sourceLanguage = language
                    self.languageButton.setTitle(language.title, for: .normal)
                case .target:
                    self.translateManager.targetLanguage = language
                    self.targetButton.setTitle(language.title, for: .normal)
                }
            }
            alertController.addAction(action)
        }
        
        let cancel = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: nil)
        alertController.addAction(cancel)
        present(alertController, animated: true, completion: nil)
    }
}

extension TranslateViewController: SourceTextViewControllerDelegate {
    func didEnter(_ sourceText: String) {
        if sourceText == "" { return }
        
        sourceLabel.text = sourceText
        sourceLabel.textColor = .label
        bookmarkButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
        
        translateManager.translate(from: sourceText) { [weak self] translatedText in
            self?.resultLabel.text = translatedText
        }
    }
}

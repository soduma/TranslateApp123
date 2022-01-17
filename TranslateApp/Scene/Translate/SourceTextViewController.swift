//
//  SourceTextViewController.swift
//  TranslateApp
//
//  Created by 장기화 on 2022/01/14.
//

import UIKit
import SnapKit

protocol SourceTextViewControllerDelegate: AnyObject {
    func didEnter(_ sourceText: String)
}

class SourceTextViewController: UIViewController {
    private let placeholderText = "텍스트입력"
    
    private weak var delegate: SourceTextViewControllerDelegate?
    
    private lazy var sourceTextView: UITextView = {
        let textView = UITextView()
        textView.text = placeholderText
        textView.textColor = .tertiaryLabel
        textView.font = .systemFont(ofSize: 18, weight: .semibold)
        textView.returnKeyType = .done
        textView.delegate = self
        return textView
    }()
    
    init(delegate: SourceTextViewControllerDelegate?) {
        super.init(nibName: nil, bundle: nil)
        
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        view.addSubview(sourceTextView)
        
        sourceTextView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        sourceTextView.becomeFirstResponder()
    }
}

extension SourceTextViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        guard textView.textColor == .tertiaryLabel else { return }
        textView.text = nil
        textView.textColor = .label
    }
    
    //done 눌렀을때 디스미스
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard text == "\n" else { return true }
        
        delegate?.didEnter(textView.text)
        dismiss(animated: true, completion: nil)
        return true
    }
}

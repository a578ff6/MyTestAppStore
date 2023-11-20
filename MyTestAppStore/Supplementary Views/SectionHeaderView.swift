//
//  SectionHeaderView.swift
//  MyTestAppStore
//
//  Created by 曹家瑋 on 2023/11/19.
//

import UIKit

class SectionHeaderView: UICollectionReusableView {
        
    /// 重用的標識符
    static let reuseIdentifier = "SectionHeaderView"
    
    // 水平堆疊視圖，包含標籤和按鈕
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        
        return stackView
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .label
        
        return label
    }()
    
    let seeAllButton: UIButton = {
        let button = UIButton()
        button.setTitle("See All", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        button.setContentHuggingPriority(.required, for: .horizontal)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
        ])
        
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(seeAllButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 設定標題
    func setTitle(_ title: String) {
        label.text = title
    }
}



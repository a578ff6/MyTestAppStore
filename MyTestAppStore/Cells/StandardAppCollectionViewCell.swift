//
//  StandardAppCollectionViewCell.swift
//  MyTestAppStore
//
//  Created by 曹家瑋 on 2023/11/18.
//

import UIKit

/// 用於展示標準的App資訊
class StandardAppCollectionViewCell: UICollectionViewCell {
    
    /// 重用的標識符
    static let reuseIdentifier = "StandardAppCollectionViewCell"
    
    // 水平的stackView，用於組織內部元件
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 8
        
        return stackView
    }()
    
    // App圖片視圖
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 15
        imageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .secondaryLabel
        
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .secondaryLabel
        
        return label
    }()
    
    // 用於標題和副標題的垂直stackView
    let labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.distribution = .equalSpacing
        
        return stackView
    }()
    
    let installButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        button.layer.cornerRadius = 12
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        button.setTitleColor(.systemBlue, for: .normal)
        button.setContentHuggingPriority(.required, for: .horizontal)
        button.widthAnchor.constraint(equalToConstant: 65).isActive = true
        
        return button
    }()
    
    // 分隔線視圖
    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 配置視圖和約束
        stackView.addArrangedSubview(imageView)
        labelStackView.addArrangedSubview(titleLabel)
        labelStackView.addArrangedSubview(subtitleLabel)
        stackView.addArrangedSubview(labelStackView)
        stackView.addArrangedSubview(installButton)
        
        addSubview(stackView)
        addSubview(lineView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        lineView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            lineView.heightAnchor.constraint(equalToConstant: 1 / UIScreen.main.scale),
            lineView.leadingAnchor.constraint(equalTo: labelStackView.leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: installButton.trailingAnchor),
            lineView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 配置cell顯示的內容
    func configureCell(_ app: App, hideBottomLine: Bool) {
        titleLabel.text = app.title
        subtitleLabel.text = app.subtitle
        imageView.backgroundColor = app.color
        installButton.setTitle(app.formattedPrice, for: .normal)
        lineView.isHidden = hideBottomLine
    }
    
}


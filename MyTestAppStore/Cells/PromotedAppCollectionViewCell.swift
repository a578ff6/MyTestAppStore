//
//  PromotedAppCollectionViewCell.swift
//  MyTestAppStore
//
//  Created by 曹家瑋 on 2023/11/18.
//

import UIKit

/// 展示推廣的App
class PromotedAppCollectionViewCell: UICollectionViewCell {
    
    /// 重用的標識符
    static let reuseIdentifier = "PromotedAppCollectionViewCell"
    
    /// 使用 UIStackView 來管理內部元素的布局
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.distribution = .fill
        stackView.alignment = .fill
        
        return stackView
    }()
    
    let headlineLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = UIColor.systemBlue
        label.setContentHuggingPriority(.required, for: .vertical)
        
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25, weight: .regular)
        label.textColor = UIColor.label
        label.setContentHuggingPriority(.required, for: .vertical)
        
        return label
    }()
    
    let subTitleLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .regular)
        label.textColor = UIColor.secondaryLabel
        label.setContentHuggingPriority(.required, for: .vertical)
        
        return label
    }()
    
    let imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.layer.cornerRadius = 5.0
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 將Label和ImageView加入到 stackView 中
        stackView.addArrangedSubview(headlineLabel)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subTitleLabel)
        stackView.setCustomSpacing(10, after: subTitleLabel)
        stackView.addArrangedSubview(imageView)
        addSubview(stackView)
        
        // 啟用 Auto Layout 約束
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 配置cell顯示的內容
    func configureCell(_ app: App) {
        headlineLabel.text = app.promotedHeadline?.uppercased()
        titleLabel.text = app.title
        subTitleLabel.text = app.subtitle
        imageView.backgroundColor = app.color
    }
    
}

//
//  LineView.swift
//  MyTestAppStore
//
//  Created by 曹家瑋 on 2023/11/19.
//

import UIKit

class LineView: UICollectionReusableView {
    
    /// 重用的標識符
    static let reuseIdentifier = "LineView"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .lightGray    // 預設背景色設為淺灰色
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 設定背景顏色，可用於改變線的顏色
    func setColor(_ color: UIColor) {
        backgroundColor = color
    }
}


//
//  App.swift
//  MyTestAppStore
//
//  Created by 曹家瑋 on 2023/11/18.
//

import Foundation
import UIKit

/// 用於存儲與 App 相關的資訊
struct App: Hashable {
    
    /// 用於推廣的標題
    let promotedHeadline: String?
    
    // App 的標題、副標題和價格
    let title: String
    let subtitle: String
    let price: Double?
    
    /// 負責將價格格式化為「當地貨幣格式」或在「免費的情況」下顯示 "GET"。
    var formattedPrice: String {
        if let price = price {
            // 如果有設定價格，則格式化為當地貨幣格式
            guard let localCurrencyCode = Locale.autoupdatingCurrent.currencyCode else {
                return String(price)
            }
            return price.formatted(.currency(code: localCurrencyCode))
        } else {
            // 如果沒有設定價格，則顯示 "GET"
            return "GET"
        }
    }
    
    /// 為每個 App 實例隨機生成一個顏色
    let color = UIColor.random
}

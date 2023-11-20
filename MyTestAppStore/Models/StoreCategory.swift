//
//  StoreCategory.swift
//  MyTestAppStore
//
//  Created by 曹家瑋 on 2023/11/18.
//

import Foundation
import UIKit

/// 用於儲存商店類別的資訊。
struct StoreCategory: Hashable {
    let name: String
    /// 為每個 App 實例隨機生成一個顏色
    let color = UIColor.random
}

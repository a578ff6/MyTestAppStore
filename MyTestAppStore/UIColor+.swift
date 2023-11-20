//
//  UIColor+.swift
//  MyTestAppStore
//
//  Created by 曹家瑋 on 2023/11/18.
//

import Foundation
import UIKit

extension UIColor {
    /// 擴展 UIColor 新增 random 生成隨機顏色
    static var random: UIColor {
        UIColor(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 1.0)
    }
}

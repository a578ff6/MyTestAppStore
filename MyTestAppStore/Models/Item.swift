//
//  Item.swift
//  MyTestAppStore
//
//  Created by 曹家瑋 on 2023/11/18.
//

import Foundation

/// 兩種不同的項目類型：app 和 category
enum Item: Hashable {
    case app(App)
    case category(StoreCategory)
    
    /// 如果此項目是 App，則返回相應的 App 實例，否則返回 nil
    var app: App? {
        if case .app(let app) = self {
            return app
        } else {
            return nil
        }
    }
    
    /// 如果此項目是一個 StoreCategory，則返回相應的 StoreCategory 實例，否則返回 nil
    var category: StoreCategory? {
        if case .category(let category) = self {
            return category
        } else {
            return nil
        }
    }
    
    /// 定義一系列推廣的App
    static let promotedApps: [Item] = [
        .app(App(promotedHeadline: "Now Trending", title: "Game Title", subtitle: "Game Description", price: 3.99)),
        .app(App(promotedHeadline: "Limited Time", title: "Game Title", subtitle: "Game Description", price: nil)),
        .app(App(promotedHeadline: "New Update", title: "Game Title", subtitle: "Game Description", price: nil)),
        .app(App(promotedHeadline: "Just Released", title: "Game Title", subtitle: "Game Description", price: nil))
    ]
    
    /// 定義一系列受歡迎的App
    static let popularApps: [Item] = [
        .app(App(promotedHeadline: nil, title: "Game Title", subtitle: "Game Description", price: nil)),
        .app(App(promotedHeadline: nil, title: "Game Title", subtitle: "Game Description", price: 2.99)),
        .app(App(promotedHeadline: nil, title: "Game Title", subtitle: "Game Description", price: nil)),
        .app(App(promotedHeadline: nil, title: "Game Title", subtitle: "Game Description", price: 9.99)),
        .app(App(promotedHeadline: nil, title: "Game Title", subtitle: "Game Description", price: nil)),
        .app(App(promotedHeadline: nil, title: "Game Title", subtitle: "Game Description", price: nil)),
        .app(App(promotedHeadline: nil, title: "Game Title", subtitle: "Game Description", price: 6.99)),
        .app(App(promotedHeadline: nil, title: "Game Title", subtitle: "Game Description", price: nil)),
    ]
    
    /// 定義一系列必備的App
    static let essentialApps: [Item] = [
        .app(App(promotedHeadline: nil, title: "Game Title", subtitle: "Game Description", price: 0.99)),
        .app(App(promotedHeadline: nil, title: "Game Title", subtitle: "Game Description", price: nil)),
        .app(App(promotedHeadline: nil, title: "Game Title", subtitle: "Game Description", price: 3.99)),
        .app(App(promotedHeadline: nil, title: "Game Title", subtitle: "Game Description", price: 0.99)),
        .app(App(promotedHeadline: nil, title: "Game Title", subtitle: "Game Description", price: 4.99)),
        .app(App(promotedHeadline: nil, title: "Game Title", subtitle: "Game Description", price: 0.99)),
        .app(App(promotedHeadline: nil, title: "Game Title", subtitle: "Game Description", price: 0.99)),
    ]
    
    /// 定義一系列App類別
    static let categories: [Item] = [
        .category(StoreCategory(name: "AR Games")),
        .category(StoreCategory(name: "Indie")),
        .category(StoreCategory(name: "Strategy")),
        .category(StoreCategory(name: "Racing")),
        .category(StoreCategory(name: "Puzzle")),
        .category(StoreCategory(name: "Board")),
        .category(StoreCategory(name: "Family")),
    ]
}

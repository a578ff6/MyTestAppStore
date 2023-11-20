//
//  ViewController.swift
//  MyTestAppStore
//
//  Created by 曹家瑋 on 2023/11/18.
//

import UIKit

class ViewController: UIViewController {
    
    /// collectionView
    @IBOutlet weak var collectionView: UICollectionView!
    
    /// 用來表示不同的 collectionView Section
    enum Section: Hashable {
        case promoted
        case standard(String)
        case categories
    }
    
    /// 輔助視圖種類
    enum SupplementaryViewKind {
        static let header = "header"
        static let topLine = "topLine"
        static let bottomLine = "bottomLine"
    }
    
    /// collectionView 的 DataSource
    var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    /// 存儲所有 Section 的陣列
    var sections = [Section]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - Collection View Setup
        // 註冊自訂的 cell 類型
        collectionView.register(PromotedAppCollectionViewCell.self, forCellWithReuseIdentifier: PromotedAppCollectionViewCell.reuseIdentifier)
        collectionView.register(StandardAppCollectionViewCell.self, forCellWithReuseIdentifier: StandardAppCollectionViewCell.reuseIdentifier)
        collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.reuseIdentifier)
        
        // 註冊輔助視圖類型
        collectionView.register(SectionHeaderView.self, forSupplementaryViewOfKind: SupplementaryViewKind.header, withReuseIdentifier: SectionHeaderView.reuseIdentifier)
        collectionView.register(LineView.self, forSupplementaryViewOfKind: SupplementaryViewKind.topLine, withReuseIdentifier: LineView.reuseIdentifier)
        collectionView.register(LineView.self, forSupplementaryViewOfKind: SupplementaryViewKind.bottomLine, withReuseIdentifier: LineView.reuseIdentifier)
        
        // 創建並設定 collectionView 的布局
        collectionView.collectionViewLayout = createLayout()
        
        // 配置 collectionView 的資料源
        configureDataSource()
    }

    /// 創建 collectionView 的布局
    func createLayout() -> UICollectionViewLayout {
        /// 使用 UICollectionViewCompositionalLayout 建立集合視圖的靈活布局。此布局允許針對不同的 section 設計獨特的佈局。
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            
            /// 創建標題項目，此處設定其佈局大小和對齊方式
            let headerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.92), heightDimension: .estimated(44)), elementKind: SupplementaryViewKind.header, alignment: .top)
            
            // 設定標題項目的內邊距，影響「標題視圖」在佈局中的位置
            // headerItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 4)
            
            /// 設定分隔線項目的高度，並根據螢幕解析度調整以避免模糊。分隔線的寬度與標題項目相同，高度為 1 pixel。
            let lineItemHeight = 1 / layoutEnvironment.traitCollection.displayScale
            let lineItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.92), heightDimension: .absolute(lineItemHeight))
            
            // 頂部邊界補充項目，用於顯示頂部線條
            let topLineItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: lineItemSize, elementKind: SupplementaryViewKind.topLine, alignment: .top)
            // 底部邊界補充項目，用於顯示底部線條
            let bottomLineItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: lineItemSize, elementKind: SupplementaryViewKind.bottomLine, alignment: .bottom)
            
            /// 設定「輔助項目的內邊距」，保持整體佈局的一致性。
            let supplementaryItemContentInsets = NSDirectionalEdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 4)
            headerItem.contentInsets = supplementaryItemContentInsets
            topLineItem.contentInsets = supplementaryItemContentInsets
            bottomLineItem.contentInsets = supplementaryItemContentInsets
            
            /// 根據 sectionIndex ，取得對應的section
            let section = self.sections[sectionIndex]
        
            switch section {
            // MARK: - Promoted Section Layout
            case .promoted:
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),heightDimension: .fractionalWidth(1.0)))
                
                // 設定項目的內邊距
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 4)

                let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.92),heightDimension: .estimated(300)),subitems: [item])
                
                /// 建立一個 section ，並將其滾動行為設定為「中心對齊的分頁」
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPagingCentered
                
                /// 為 section 添加上下分隔線，並設定 section 的內邊距，以達到更佳的視覺效果。
                section.boundarySupplementaryItems = [topLineItem, bottomLineItem]
                section.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 0, bottom: 20, trailing: 0)
                
                return section
            // MARK: - Standard Section Layout
            case .standard:
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(1/3)))
                
                // 設定項目的內邊距
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 4)
                
                ///「垂直群組」，設定其尺寸和子項目數量
                let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.92), heightDimension: .estimated(250)), subitem: item, count: 3)
                
                /// 建立一個 section ，並將其滾動行為設定為「中心對齊的分頁」
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPagingCentered
                
                /// 為 section 添加標題、下分隔線，並設定 section 的內邊距，以達到更佳的視覺效果。
                section.boundarySupplementaryItems = [headerItem, bottomLineItem]
                section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 0, bottom: 25, trailing: 0)
                
                return section
            // MARK: - Categories Section Layout
            case .categories:
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
                
                let availableLayoutWidth = layoutEnvironment.container.effectiveContentSize.width       // 獲取當前佈局環境中容器的有效內容寬度。
                let groupWidth = availableLayoutWidth * 0.92                                            // 計算 group 的寬度為容器寬度的92%。
                let remainingWidth = availableLayoutWidth - groupWidth                                  // 計算剩餘的寬度。
                let halfOfRemainingWidth = remainingWidth / 2.0                                         // 將剩餘寬度平分。
                let nonCategorySectionItemInset = CGFloat(4)                                            // 為非「categories」區塊的項目設置內邊距。
                let itemLeadingAndTrailingInset = halfOfRemainingWidth + nonCategorySectionItemInset    // 計算項目的左右內邊距。
                
                // 設置集合佈局項目的內容內邊距。
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: itemLeadingAndTrailingInset, bottom: 0, trailing: itemLeadingAndTrailingInset)
                
                let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44)), subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                
                /// 為 section 添加標題。
                section.boundarySupplementaryItems = [headerItem]
                
                return section
            }
            
        }
        return layout
    }
    
    /// 配置 collectionView 的資料源
    func configureDataSource() {
        
        // 初始化資料源，並提供一個 cellProvider
        dataSource = .init(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            // 根據 indexPath 的 section 取得對應的section
            let section = self.sections[indexPath.section]
            switch section {
            // MARK: - 如果是「promoted」section，則嘗試取得並配置對應的 cell
            case .promoted:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PromotedAppCollectionViewCell.reuseIdentifier, for: indexPath) as? PromotedAppCollectionViewCell else {
                    fatalError("Unable to dequeue PromotedAppCollectionViewCell")
                }
                cell.configureCell(item.app!)
                
                return cell
            // MARK: - 如果是「standard」section，則嘗試取得並配置對應的 cell
            case .standard:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StandardAppCollectionViewCell.reuseIdentifier, for: indexPath) as? StandardAppCollectionViewCell else {
                    fatalError("Unable to dequeue StandardAppCollectionViewCell")
                }
                /// 檢查該 cell 是否是每行的第三個元素
                let isThirdItem = (indexPath.row + 1).isMultiple(of: 3)
                /// 根據獲取的 item 設置 cell，如果是每行的第三個元素則隱藏底部線條
                cell.configureCell(item.app!, hideBottomLine: isThirdItem)
                
                return cell
            // MARK: - 如果是「categories」section，則嘗試取得並配置對應的 cell
            case .categories:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.reuseIdentifier, for: indexPath) as? CategoryCollectionViewCell else {
                    fatalError("Unable to dequeue CategoryCollectionViewCell")
                }
                
                /// 判斷當前 cell 是否為該區塊的最後一個元素。(通過比較該區塊的總項目數與當前 cell 的 indexPath.row 來實現的。)
                let isLastItem = collectionView.numberOfItems(inSection: indexPath.section) == indexPath.row + 1
                cell.configureCell(item.category!, hideBottomLine: isLastItem)

                return cell
            }
        })
        
        // MARK: - Supplementary View Provider
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath -> UICollectionReusableView? in
            
            switch kind {
            // 標題視圖
            case SupplementaryViewKind.header:
                
                // 根據 indexPath 的 section 決定顯示哪一個 section 的資訊
                let section = self.sections[indexPath.section]
                let sectionName: String
                // 針對不同的 section 類型來設定標題
                switch section {
                case .promoted:
                    return nil                                  // 如果是 promoted 類型，目前不顯示標題
                case .standard(let name):
                    sectionName = name                          // 如果是 standard 類型，使用其提供的名稱
                case .categories:
                    sectionName = "Top Categories"              // 如果是 categories 類型，固定標題 "Top Categories"
                }
                
                guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: SupplementaryViewKind.header, withReuseIdentifier: SectionHeaderView.reuseIdentifier, for: indexPath) as? SectionHeaderView else {
                    fatalError("Unable to dequeue SectionHeaderView")
                }
                // 設定標題視圖的標題
                headerView.setTitle(sectionName)
                return headerView
            
            // 分隔線視圖 topLine、bottomLine
            case SupplementaryViewKind.topLine, SupplementaryViewKind.bottomLine:
                guard let lineView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: LineView.reuseIdentifier, for: indexPath) as? LineView else {
                    fatalError("Unable to dequeue LineView")
                }
                // 回傳取得的分隔線視圖
                return lineView
            
            // 若非上述任何一種SupplementaryView類型，則回傳 nil
            default:
                return nil
            }
        }
        
        // MARK: - 快照定義
        /// 創建並配置 DiffableDataSourceSnapshot
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        
        // 為 promoted section 添加區塊、項目
        snapshot.appendSections([.promoted])
        snapshot.appendItems(Item.promotedApps, toSection: .promoted)
        
        // 創建「popularSection」和「essentialSection」兩個 standard section
        let popularSection = Section.standard("Popular this week")
        let essentialSection = Section.standard("Essential picks")
         
        // 這裡為 categories 部分添加到快照中，並將相關項目加入
        let categoriesSection = Section.categories

        // 分別將這兩個 section 添加到 snapshot 中
        snapshot.appendSections([popularSection, essentialSection, categoriesSection])
        // 在「popularSection」section、「essentialSection」section 中添加項目
        snapshot.appendItems(Item.popularApps, toSection: popularSection)
        snapshot.appendItems(Item.essentialApps, toSection: essentialSection)
        snapshot.appendItems(Item.categories, toSection: categoriesSection)
        
        /// 更新 sections 資料，將目前的 section 標識符保存起來
        sections = snapshot.sectionIdentifiers
        
        // 將 snapshot 應用到 dataSource，這會更新 collectionView 的展示內容
        dataSource.apply(snapshot)
    }

}




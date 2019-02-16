//
//  WWCollectionFlowLayout.swift
//  swift_WaterfallFlow
//
//  Created by wuwei on 16/5/12.
//  Copyright © 2016年 wuwei. All rights reserved.
//

import UIKit

class ZJCollectionFlowLayout: UICollectionViewFlowLayout {

    var columnCount:Int = 0
    var thirdApps = [ThirdAppsModel]()
    fileprivate var layoutAttributesArray = [UICollectionViewLayoutAttributes]()
    
    override func prepare() {
        let marginX:CGFloat = 8
        self.minimumLineSpacing = marginX
        self.minimumInteritemSpacing = marginX
        self.sectionInset.left = marginX
        self.sectionInset.right = marginX
        let contentWidth:CGFloat = (self.collectionView?.bounds.size.width)! - self.sectionInset.left - self.sectionInset.right
        let itemWidth = (contentWidth - marginX * (CGFloat(columnCount) - 1.0)) / CGFloat.init(self.columnCount)
        self.computeAttributesWithItemWidth(CGFloat(itemWidth))
    }
    
    /**
     *  根据itemWidth计算布局属性
     */
    func computeAttributesWithItemWidth(_ itemWidth:CGFloat){
        // 定义一个列高数组 记录每一列的总高度
        var columnHeight = [Int](repeating: Int(self.sectionInset.top), count: self.columnCount)
        // 定义一个记录每一列的总item个数的数组
        var columnItemCount = [Int](repeating: 0, count: self.columnCount)
        var attributesArray = [UICollectionViewLayoutAttributes]()
        
        var index = 0
        for thirdApp in self.thirdApps {
//        for i in 0...29{
            let indexPath = IndexPath.init(item: index, section: 0)
            let attributes = UICollectionViewLayoutAttributes.init(forCellWith: indexPath)
            // 找出最短列号
            let minHeight:Int = columnHeight.sorted().first!
            let column = columnHeight.index(of: minHeight)
            // 数据追加在最短列
            columnItemCount[column!] += 1
            let itemX = (itemWidth + self.minimumInteritemSpacing) * CGFloat(column!) + self.sectionInset.left
            let itemY = minHeight
            // 计算item的高度
            let size = CGSize(width: itemWidth - 16, height: 1000)
            let attribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)]
            var descriptionH = 0
            if let text = thirdApp.RegisterAppDescription{
                let estimatedFrame = NSString(string: text).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attribute, context: nil)
//                descriptionH = (Int(estimatedFrame.height) > 150 ? Int(estimatedFrame.height/2) : Int(estimatedFrame.height))
                if Int(estimatedFrame.height) < 150{
                    descriptionH = Int(estimatedFrame.height) + 10
                }else if Int(estimatedFrame.height) < 250{
                    descriptionH = 150 + Int(estimatedFrame.height/2 - 75)
                }else{
                    descriptionH = 250
                }
                
            }
            let itemH = 61 + Int(itemWidth) - 16 + descriptionH
            attributes.frame = CGRect(x: itemX, y: CGFloat(itemY), width: itemWidth, height: CGFloat(itemH))
            attributesArray.append(attributes)
            // 累加列高
            columnHeight[column!] += itemH + Int(self.minimumLineSpacing)
            index += 1
        }
        
        // 找出最高列列号
        let maxHeight:Int = columnHeight.sorted().last!
        let column = columnHeight.index(of: maxHeight)
        // 根据最高列设置itemSize 使用总高度的平均值
        let itemH = (maxHeight - Int(self.minimumLineSpacing) * columnItemCount[column!]) / columnItemCount[column!]
        self.itemSize = CGSize(width: itemWidth, height: CGFloat(itemH))
        // 添加页脚属性
        let footerIndexPath:IndexPath = IndexPath.init(item: 0, section: 0)
        let footerAttr:UICollectionViewLayoutAttributes = UICollectionViewLayoutAttributes.init(forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, with: footerIndexPath)
        footerAttr.frame = CGRect(x: 0, y: CGFloat(maxHeight), width: self.collectionView!.bounds.size.width, height: 50)
        attributesArray.append(footerAttr)
        // 给属性数组设置数值
        self.layoutAttributesArray = attributesArray
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return self.layoutAttributesArray
    }
}

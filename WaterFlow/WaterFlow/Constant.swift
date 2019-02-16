//
//  Constant.swift
//  WaterFlow
//
//  Created by zijia on 2/16/19.
//  Copyright © 2019 zijia. All rights reserved.
//

import UIKit

let zjScreenWidth = UIScreen.main.bounds.size.width
let zjScreenHeight = UIScreen.main.bounds.size.height

// 判断是否为 iPhone X
let isIphoneX = zjScreenHeight >= 812 ? true : false
// 状态栏高度
let zjStatusHeight : CGFloat = isIphoneX ? 44 : 20
// 导航栏高度
let zjNavigationBarHeight :CGFloat = 44
// TabBar高度
let zjTabBarHeight : CGFloat = isIphoneX ? 49 + 34 : 49

func ZJPrint<T>(message : T, file : String = #file, lineNumber : Int = #line) {
    #if DEBUG
    let fileName = (file as NSString).lastPathComponent
    print("\(NSDate())----\(fileName) line:\(lineNumber)- \(message)")
    #endif
}

extension UIColor{
    class var background: UIColor {
        return UIColor(displayP3Red: 242/255, green: 242/255, blue: 242/255, alpha: 1.0)
    }
}

extension UIColor {
    convenience init(r : CGFloat, g : CGFloat, b : CGFloat) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)
    }
    
    class func randomColor() -> UIColor {
        return UIColor(r: CGFloat(arc4random_uniform(256)), g: CGFloat(arc4random_uniform(256)), b: CGFloat(arc4random_uniform(256)))
    }
}

class PaddingLabel: UILabel {
    
    @IBInspectable var topInset: CGFloat = 5.0
    @IBInspectable var bottomInset: CGFloat = 5.0
    @IBInspectable var leftInset: CGFloat = 5.0
    @IBInspectable var rightInset: CGFloat = 5.0
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        get {
            var contentSize = super.intrinsicContentSize
            contentSize.height += topInset + bottomInset
            contentSize.width += leftInset + rightInset
            return contentSize
        }
    }
}

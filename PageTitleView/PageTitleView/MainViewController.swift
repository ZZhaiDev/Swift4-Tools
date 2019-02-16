//
//  ViewController.swift
//  PageTitleView
//
//  Created by zijia on 2/16/19.
//  Copyright © 2019 zijia. All rights reserved.
//

import UIKit

private let ZJTitleViewH : CGFloat = 40
private let titles = ["Business", "Entertainment", "Health", "Science", "Sports", "Technology"]

class MainViewController: UIViewController {
    
    var childVcs = [UIViewController]()
    
    fileprivate lazy var pageTitleView : PageTitleView = {[weak self] in
        let titleFrame = CGRect(x: 0, y: zjStatusHeight + zjNavigationBarHeight, width: zjScreenWidth, height: ZJTitleViewH)
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        titleView.delegate = self
        return titleView
    }()
    
    fileprivate lazy var pageContentView : PageContentView = {[weak self] in
        let y = zjStatusHeight + zjNavigationBarHeight + ZJTitleViewH
        let contentH = zjScreenHeight - zjStatusHeight - zjNavigationBarHeight - ZJTitleViewH - zjTabBarHeight
        let contentFrame = CGRect(x: 0, y: y, width: zjScreenWidth, height: contentH)
        for title in titles{
            addControllers(title: title)
        }
        
        let contentView = PageContentView(frame: contentFrame, childVcs: childVcs, parentViewController: self)
        contentView.delegate = self
        return contentView
    }()
    
    fileprivate func addControllers(title: String){
        let vc = SubViewController(title: title)
        childVcs.append(vc)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.addSubview(pageTitleView)
        view.addSubview(pageContentView)
    }


}



// MARK:- 遵守PageTitleViewDelegate协议
extension MainViewController : PageTitleViewDelegate {
    func pageTitleView(_ titleView: PageTitleView, selectedIndex index: Int) {
        pageContentView.setCurrentIndex(index)
    }
}


// MARK:- 遵守PageContentViewDelegate协议
extension MainViewController : PageContentViewDelegate {
    func pageContentView(_ contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProgress(progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}


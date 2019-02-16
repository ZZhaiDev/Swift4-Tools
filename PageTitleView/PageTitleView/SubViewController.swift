//
//  SubViewController.swift
//  PageTitleView
//
//  Created by zijia on 2/16/19.
//  Copyright © 2019 zijia. All rights reserved.
//

import UIKit

class SubViewController: UIViewController {
    
    
    fileprivate var titleText = ""
    
    required public init(title: String){
        self.titleText = title
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var label: UILabel = { [weak self] in
       let label = UILabel(frame: CGRect(x: 0, y: 200, width: zjScreenWidth, height: 300))
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 50)
        label.text = self!.titleText + "  Page"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(label)
    }

}

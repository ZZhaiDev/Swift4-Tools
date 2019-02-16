//
//  ViewController.swift
//  WaterFlow
//
//  Created by zijia on 2/16/19.
//  Copyright © 2019 zijia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    fileprivate lazy var thirdAppsModel = ThirdAppsViewModel()

    @IBAction func buttonClicked(_ sender: Any) {
        let vc = SearchViewController()
        vc.viewModel = thirdAppsModel.viewModel
        self.navigationController?.pushViewController(vc, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    fileprivate func loadData(){
        thirdAppsModel.loadApprovedIOSInfo {
        }
    }


}


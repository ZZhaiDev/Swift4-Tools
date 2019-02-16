//
//  ThirdAppsViewModel.swift
//  Carloudy
//
//  Created by Zijia Zhai on 12/18/18.
//  Copyright © 2018 Cognitive AI Technologies. All rights reserved.
//

import UIKit

class ThirdAppsViewModel{
    lazy var viewModel = [ThirdAppsModel]()
}

extension ThirdAppsViewModel{
    func loadApprovedIOSInfo(finish: @escaping () -> ()){
        let urlStr = "http://betastore.carloudy.com/approved?os=ios"
        NetworkTools.shareInstance.request(methodType: .GET, urlString: urlStr, parameter: [:]) { (result, error) in
            if error != nil{
                ZJPrint(message: error)
                return
            }
            guard let dict = result else { return }
            guard let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: []) else { return }
            do{
                let data =  try JSONDecoder().decode([ThirdAppsModel].self, from: jsonData)
                self.viewModel = data
            }catch{
                
            }
            
            finish()
        }
    }
}

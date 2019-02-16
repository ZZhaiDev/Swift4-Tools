//
//  SearchViewController.swift
//  WaterFlow
//
//  Created by zijia on 2/16/19.
//  Copyright © 2019 zijia. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    lazy var viewModel = [ThirdAppsModel]()
    fileprivate lazy var updateViewModel = [ThirdAppsModel]()
    fileprivate var currentSearchText = ""
    
    fileprivate lazy var searchController : UISearchController = { [unowned self] in
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search Mini Programs"
        searchController.searchBar.delegate = self
        
        return searchController
        }()
    
    fileprivate lazy var collectionView: UICollectionView = { [weak self] in
        let flowlayout = ZJCollectionFlowLayout()
        flowlayout.thirdApps = self!.updateViewModel
        flowlayout.columnCount = 2
        let h = zjStatusHeight + zjNavigationBarHeight
        let cv = UICollectionView(frame: self!.view.bounds, collectionViewLayout: flowlayout)
        cv.register(UINib(nibName: "ThirdAppSearchCell", bundle: nil), forCellWithReuseIdentifier: "cellId")
        cv.dataSource = self!
        cv.delegate = self
        cv.backgroundColor = UIColor.white
        cv.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
        return cv
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
}


extension SearchViewController{
    fileprivate func setupUI(){
        updateViewModel = viewModel
        self.view.addSubview(collectionView)
        self.title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Show All", style: .plain, target: self, action: #selector(showAllApps))
        self.navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    @objc fileprivate func showAllApps(){
        if updateViewModel.count == viewModel.count { return }
        updateViewModel = viewModel
        let layout = collectionView.collectionViewLayout as! ZJCollectionFlowLayout
        layout.thirdApps = updateViewModel
        collectionView.reloadData()
    }
}



extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        ZJPrint(message: updateViewModel.count)
        return updateViewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! ThirdAppSearchCell
        cell.thirdAppSearchCellData = updateViewModel[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}




extension SearchViewController: UISearchBarDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        updateViewModel.removeAll()
        currentSearchText = searchText
        if searchText == ""{
            updateViewModel = viewModel
        }else{
            for model in viewModel{
                if model.RegisterAppDescription != nil{
                    if model.RegisterAppName!.lowercased().contains(searchText.lowercased()){
                        updateViewModel.append(model)
                    }
                }
                
            }
        }
        
        if updateViewModel.count == 0{
            return
        }
        
        let layout = collectionView.collectionViewLayout as! ZJCollectionFlowLayout
        layout.thirdApps = updateViewModel
        collectionView.reloadData()
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
}

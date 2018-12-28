//
//  ViewController.swift
//  StretchHeader
//
//  Created by Zijia Zhai on 12/28/18.
//  Copyright © 2018 cognitiveAI. All rights reserved.
//

import UIKit


fileprivate let contenInsetTop = 64
fileprivate let cellId = "cellId"
fileprivate let headerId = "headerId"
fileprivate let padding: CGFloat = 16

class StretchyHeaderController: UICollectionViewController  {
    
    var headerView: HeaderView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}


// MARK:- UIsetUp
extension StretchyHeaderController{
    fileprivate func setupUI(){
        self.title = "Stretch Header"
        setupCollectionViewLayout()
        setupCollectionView()
        collectionView.contentInset = UIEdgeInsets(top: CGFloat(contenInsetTop), left: 0, bottom: 0, right: 0)
    }
    
    fileprivate func setupCollectionViewLayout() {
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionInset = .init(top: padding, left: padding, bottom: padding, right: padding)
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    fileprivate func setupCollectionView() {
        collectionView.backgroundColor = .white
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
    }
}


// MARK:- delegate, datasource
extension StretchyHeaderController: UICollectionViewDelegateFlowLayout{
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetY = scrollView.contentOffset.y + CGFloat(contenInsetTop)
        print(contentOffsetY)
        
        if contentOffsetY > 0 && contentOffsetY < 100{
            let colorAlpha = abs(contentOffsetY - 100)/100
            navigationController?.navigationBar.alpha = colorAlpha
        }else if contentOffsetY > 100{
            navigationController?.navigationBar.alpha = 0
        }else if contentOffsetY <= 0{
            navigationController?.navigationBar.alpha = 1
        }
        
        if contentOffsetY > 0 {
            headerView?.animator.fractionComplete = 0
            return
        }
        headerView?.animator.fractionComplete = abs(contentOffsetY) / 100
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as? HeaderView
        return headerView!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: 250)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 18
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        cell.backgroundColor = .black
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 2 * padding, height: 50)
    }
}

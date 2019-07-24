//
//  ViewController.swift
//  GradientView
//
//  Created by zijia on 7/23/19.
//  Copyright © 2019 zijia. All rights reserved.
//

import UIKit

extension UIColor {
    static let primaryDark = UIColor(named: "PrimaryDark")!
    static let primaryLight = UIColor(named: "PrimaryLight")!
    static let gradientTop = UIColor(named: "GradientTop")!
    static let gradientBottom = UIColor(named: "GradientBottom")!
}


class GradientView: UIView {
    var gradientLayer: CAGradientLayer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    private func setupUI() {
        gradientLayer = CAGradientLayer()
        let colorTop = UIColor.gradientTop.cgColor
        let colorBottom = UIColor.gradientBottom.cgColor
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = frame
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        gradientLayer.frame = frame
    }
}

class ViewController: UIViewController {
    
    let gradientView = GradientView(frame: .zero)
    
    override func loadView() {
        super.loadView()
        view = gradientView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}



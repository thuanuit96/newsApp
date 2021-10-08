//
//  MyNavigationBar.swift
//  NewsApp
//
//  Created by VN01-MAC-0006 on 25/09/2021.
//


import UIKit
class CustomNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.barTintColor = UIColor.red
        self.navigationBar.barStyle = .default
    }
}

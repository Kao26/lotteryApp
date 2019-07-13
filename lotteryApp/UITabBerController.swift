//
//  UITabBerController.swift
//  lotteryApp
//
//  Created by Kaoru Tsugane on 2019/07/13.
//  Copyright © 2019 津金薫. All rights reserved.
//

import UIKit

class UITabBerController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //デザイン
        // アイコンの色
        UITabBar.appearance().tintColor = UIColor(red: 255/255, green: 233/255, blue: 51/255, alpha: 1.0) // yellow
        // 背景色
        UITabBar.appearance().barTintColor = UIColor(red: 66/255, green: 74/255, blue: 93/255, alpha: 1.0) // grey black
    }

}

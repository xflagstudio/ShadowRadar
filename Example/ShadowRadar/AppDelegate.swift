//
//  AppDelegate.swift
//  ShadowRadar
//
//  Created by Meng Li on 02/18/2019.
//  Copyright (c) 2019 XFLAG. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        window?.rootViewController = ViewController(viewModel: .init())
        window?.makeKeyAndVisible()
        return true
    }

}


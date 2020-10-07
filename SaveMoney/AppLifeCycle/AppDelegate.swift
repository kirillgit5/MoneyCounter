//
//  AppDelegate.swift
//  SaveMoney
//
//  Created by Кирилл Крамар on 24.06.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import UIKit
import RealmSwift
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let config = Realm.Configuration(
            schemaVersion: 8,
            migrationBlock: { migration, oldSchemaVersion in
                if (oldSchemaVersion < 8) {
                }
            })
        Realm.Configuration.defaultConfiguration = config
        loadDefaultData()
        return true
    }
    
    // MARK: Private Methods
    private func loadDefaultData() {
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        if !launchedBefore {
            StorageManager.shared.createStandartDataMoneyCategory()
            StorageManager.shared.createStandartDataPurchasesCategory()
            UserDefaults.standard.set(true, forKey: "launchedBefore")
        }
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        
    }


}


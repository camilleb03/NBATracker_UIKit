//
//  AppDelegate.swift
//  NBATracker
//
//  Created by Camille Bourbonnais on 2021-05-03.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application( _ application: UIApplication, didFinishLaunchingWithOptions launchOptions:
                        [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        
        // Declaring VC for each tab item
        let teamsTableVC = TeamsTableViewController()
        let liveScoresVC = LiveScoresViewController()
        
        // Embed each VC in a NavController
        let teamsTableNC = makeNavigationController(rootViewController: teamsTableVC)
        let liveScoresNC = makeNavigationController(rootViewController: liveScoresVC)
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [teamsTableNC, liveScoresNC]
        
        // Specify which ViewController to launch at the start of the app
        window?.rootViewController = tabBarController
        
        return true
    }
    
    func makeNavigationController(rootViewController: UIViewController) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: rootViewController)
        
        // Setting up navigation bar title
        navigationController.navigationBar.prefersLargeTitles = true
        let attrs = [
            NSAttributedString.Key.foregroundColor: UIColor.label,
            NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .title1).bold()
        ]
        navigationController.navigationBar.largeTitleTextAttributes = attrs
        
        return navigationController
    }
}


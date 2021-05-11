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
        
        // Call to NBA today.json to retrieve currentDate
        let semaphore = DispatchSemaphore(value: 0)
        var didFetch = false
        let url = Endpoint.today.nbaUrl
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            do {
                let response = try JSONDecoder().decode(NBAToday.self, from: data!)
                didFetch = true
                NBATodayService.nbaToday = NBAToday.init(currentDateUrlCode: response.currentDateUrlCode, seasonScheduleYear: response.seasonScheduleYear)
            } catch {
                print(error)
            }
            semaphore.signal();
        }
        task.resume()
        let _ = semaphore.wait(timeout: DispatchTime.distantFuture)
        
        if didFetch == false {
            return false
        }
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        
        // Declaring VC for each tab item
        let teamsTableVC = TeamsViewController()
        let liveScoresVC = LiveScoresViewController()
        let standingsVC = StandingsViewController()
        
        // Embed each VC in a NavController
        let teamsTableNC = makeNavigationController(rootViewController: teamsTableVC)
        let liveScoresNC = makeNavigationController(rootViewController: liveScoresVC)
        let standingsNC = makeNavigationController(rootViewController: standingsVC)
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [standingsNC, liveScoresNC, teamsTableNC]
        // Select livescore TabBarItem on launch
        tabBarController.selectedIndex = 0
        
        // Specify which ViewController to launch at the start of the app
        window?.rootViewController = tabBarController
        
        return true
    }
    
    func makeNavigationController(rootViewController: UIViewController) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: rootViewController)
        
        // Setting up navigation bar title
//        navigationController.navigationBar.prefersLargeTitles = true
//        let attrs = [
//            NSAttributedString.Key.foregroundColor: UIColor.label,
//            NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .title1).bold()
//        ]
//
//        navigationController.navigationBar.largeTitleTextAttributes = attrs
        
        return navigationController
    }
}


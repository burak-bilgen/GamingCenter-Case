//
//  AppDelegate.swift
//  Gaming Center
//
//  Created by Burak Bilgen on 11.02.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        NetworkConfig.setupNetworkConfig()
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        window.rootViewController = createTabBarController()
        window.makeKeyAndVisible()
        
        self.window = window
        
        return true
    }
    
    private func createGamesNavigationController(preferLargeTitle: Bool = false) -> UINavigationController {
        
        let gamesVC = UIStoryboard(name: Headlines.games, bundle: nil).instantiateViewController(withIdentifier: ViewController.gamesVC) as! GamesVC
        
        let viewModel = GamesViewModel(view: gamesVC)
        gamesVC.viewModel = viewModel
        
        let sectionTitle = Headlines.games
        
        gamesVC.title = sectionTitle
        
        gamesVC.tabBarItem = UITabBarItem(title: sectionTitle, image: Icon.controller, tag: 0)
        
        let navigationController = UINavigationController(rootViewController: gamesVC)
        navigationController.navigationBar.prefersLargeTitles = preferLargeTitle
        
        return navigationController
    }
    
    private func createFavoritesNavigationController(preferLargeTitle: Bool = false) -> UINavigationController {
        let favoritesVC = UIStoryboard(name: Headlines.favorites, bundle: nil).instantiateViewController(withIdentifier: ViewController.favoritesVC) as! FavoritesVC
        
        let viewModel = FavoritesViewModel(view: favoritesVC)
        favoritesVC.viewModel = viewModel

        let sectionTitle = Headlines.favorites
        
        favoritesVC.title = sectionTitle
        
        favoritesVC.tabBarItem = UITabBarItem(title: sectionTitle, image: Icon.favorite, tag: 1)
        
        let navigationController = UINavigationController(rootViewController: favoritesVC)
        navigationController.navigationBar.prefersLargeTitles = preferLargeTitle
        
        return navigationController
    }
    
    private func createTabBarController(tintColor: UIColor = .systemBlue) -> CustomTabBarController? {
        let tabBarController = CustomTabBarController()
        
        UITabBar.appearance().tintColor = tintColor
        
        tabBarController.viewControllers = [
            createGamesNavigationController(preferLargeTitle: true),
            createFavoritesNavigationController(preferLargeTitle: true)
        ]
        
        return tabBarController
    }
}

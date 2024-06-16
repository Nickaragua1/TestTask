//
//  TabController.swift
//  TestTaskApp
//
//  Created by Никита Гладышев on 13.06.2024.
//

import UIKit

class TabController: UITabBarController {
    
    //MARK: Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        setupTabBarController()
    }
    
    //MARK: Private methods
    private func setupTabBarController() {
        tabBar.barTintColor = .black
        tabBar.tintColor = R.Color.selectedBarItenColor
        tabBar.unselectedItemTintColor = R.Color.unselectedBarItemColor
    }
    
   private func setupTabs() {
        let mainViewController = createNav(
            with: "Авиабилеты",
            image: R.Image.mainVCBarItemImage,
            vc: MainScreenModuleBuilder().build()
        )
        let hotelsViewController = createNav(
            with: "Отели",
            image: R.Image.hotelsVCBarItemImage,
            vc: HotelsViewController()
        )
        let shortViewController = createNav(
            with: "Короче",
            image: R.Image.geoVCBarItemImage,
            vc: ShortViewController()
        )
        let subscriptionsViewController = createNav(
            with: "Подписки",
            image: R.Image.bellVCBarItemImage,
            vc: SubscriptionViewController()
        )
        let profileViewController = createNav(
            with: "Профиль",
            image: R.Image.profileVCBarItemImage,
            vc: ProfileViewController()
        )
       let vcArray = [mainViewController,
                      hotelsViewController,
                      shortViewController,
                      subscriptionsViewController,
                      profileViewController]
        self.setViewControllers(vcArray, animated: true)
    }
    
    private func createNav(with title: String, image: UIImage?, vc: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        return nav
    }
}

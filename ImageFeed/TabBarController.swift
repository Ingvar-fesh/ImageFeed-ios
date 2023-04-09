import Foundation
import UIKit


final class TabBarController: UITabBarController {
    override func awakeFromNib() {
        super.awakeFromNib()
        let storyboard = UIStoryboard(name: "Main", bundle: .main)

        let imagesListViewController = storyboard.instantiateViewController(withIdentifier: "ImagesListViewController")
        imagesListViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "stack_activate_icon"), selectedImage: nil)

        let profileViewController = ProfileViewController()
        profileViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "profile_activate_icon"), selectedImage: nil)

        self.viewControllers = [imagesListViewController, profileViewController]
    }
}

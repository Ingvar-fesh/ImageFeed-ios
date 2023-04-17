import Foundation
import UIKit


final class TabBarController: UITabBarController {
    override func awakeFromNib() {
        super.awakeFromNib()
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        
        let imagesListViewController = storyboard.instantiateViewController(withIdentifier: "ImagesListViewController") as! ImagesListViewController
        imagesListViewController.configure(ImageListPresenter())

        imagesListViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "stack_activate_icon"), selectedImage: nil)

        let profileViewController = ProfileViewController()
        profileViewController.configure(ProfilePresenter())
        profileViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "profile_activate_icon"), selectedImage: nil)
        profileViewController.updateAvatar()
        profileViewController.updateProfileDetails()

        self.viewControllers = [imagesListViewController, profileViewController]
    }
}

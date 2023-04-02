import Foundation
import UIKit
import ProgressHUD

final class SplashViewController: UIViewController {
    private let oauth2Service = OAuth2Service()
    private let oauth2TokenStorage = OAuth2TokenStorage()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if OAuth2TokenStorage().token != nil {
            switchToTabBarController()
        } else {
            performSegue(withIdentifier: "ShowAuthenticationScreen", sender: nil)
        }
    }
}

extension SplashViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowAuthenticationScreen" {
            guard
                let navigationController = segue.destination as? UINavigationController,
                let viewController = navigationController.viewControllers[0] as? AuthViewController
            else {
                assertionFailure("Failed to prepare for ShowAuthenticationScreen")
                return
            }
            viewController.delegate = self
        } else {
            super.prepare(for: segue, sender: sender)
        }
    }
    
    private func switchToTabBarController() {
        guard let window = UIApplication.shared.windows.first
        else {
            assertionFailure("Invalid Configuration")
            return
        }
        let tabBarController = UIStoryboard(name: "Main", bundle: .main)
        .instantiateViewController(withIdentifier: "TabBarViewController")
        window.rootViewController = tabBarController
    }
}

extension SplashViewController: AuthViewControllerDelegate {
    func authViewController(_ vc: AuthViewController, didAuthenticateWithCode code: String) {
        ProgressHUD.show()
        dismiss(animated: true) { [weak self] in
            guard let self = self else { return }
            self.oauth2Service.fetchAuthToken(code: code) { [weak self] result in
                switch result {
                case.success(let response):
                    self?.oauth2TokenStorage.token = response.accessToken
                    self?.switchToTabBarController()
                    ProgressHUD.dismiss()
                case.failure: assertionFailure()
                    ProgressHUD.dismiss()
                }
            }
        }
    }
}

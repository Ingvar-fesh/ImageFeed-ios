@testable import ImageFeed
import Foundation
import XCTest

final class ProfileUntiTests: XCTestCase {
    func testProfileViewLogoutTokenIsEqualNil() {
        let viewController = ProfileViewController()
        let presenter = ProfilePresenter()
        viewController.configure(presenter)
        
        presenter.logout()
        
        XCTAssertEqual(OAuth2TokenStorage().token, nil)
    }
    
    func testProfilePresenterCallsAvatarURL() {
        let viewController = ProfileViewController()
        let presenter = ProfilePresenterSpy()
        viewController.presenter = presenter
        presenter.view = viewController
        
        viewController.viewDidLoad()
        
        XCTAssertTrue(presenter.avatarURLCalled) //behaviour verification
    }
    
    func testProfilePresenterCallsUpdateProfileDetails() {
        let viewController = ProfileViewController()
        let presenter = ProfilePresenterSpy()
        viewController.presenter = presenter
        presenter.view = viewController
        
        viewController.viewDidLoad()
        
        XCTAssertTrue(presenter.updateProfileDetailsCalled) //behaviour verification
    }
    
    func testProfilePresenterChangedViewControllerAfterLogout() {
        let viewController = ProfileViewController()
        let presenter = ProfilePresenter()
        viewController.presenter = presenter
        presenter.view = viewController
        
        presenter.logout()
        
        guard let window = UIApplication.shared.windows.first else {
            assertionFailure("Invalid Configuration")
            return
        }
        
        XCTAssertTrue(window.rootViewController?.isKind(of: SplashViewController.self) == true) //behaviour verification
    }
}

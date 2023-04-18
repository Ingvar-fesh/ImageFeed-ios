@testable import ImageFeed
import Foundation

final class ProfilePresenterSpy: ProfilePresenterProtocol {
    var view: ImageFeed.ProfileViewControllerProtocol?
    
    var avatarURLCalled: Bool = false
    var updateProfileDetailsCalled: Bool = false
    var cleanServicesDataCalled: Bool = false
    
    func avatarURL() -> URL? {
        avatarURLCalled = true
        return nil
    }
    
    func updateProfileDetails() -> [String]? {
        updateProfileDetailsCalled = true
        return nil
    }
    
    func logout() {
    }
    
    static func clean() {
    }
    
    
}

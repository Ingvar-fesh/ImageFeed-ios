@testable import ImageFeed
import Foundation
import XCTest


final class ImagesListUnitTests: XCTestCase {
    func testDateToString() {
        let viewController = ImagesListViewController()
        let presenter = ImageListPresenter()
        viewController.configure(presenter)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        guard let date = formatter.date(from: "2022/08/31 22:31") else {
            return
        }
        
        let code = presenter.dateString(date)

        XCTAssertEqual(code, "31 августа 2022 г.")
    }
    
    func testInvalidDateToString() {
        let viewController = ImagesListViewController()
        let presenter = ImageListPresenter()
        viewController.configure(presenter)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        guard let date = formatter.date(from: "2022/08/31 22:31") else {
            return
        }
        
        let code = presenter.dateString(date)
        
        XCTAssertFalse(code == "30 августа 2022 г.")
    }
}

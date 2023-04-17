import Foundation

protocol ImageListPresenterProtocol {
    var view: ImageListViewControllerProtocol? { get set }
    func dateString(_ date: Date) -> String
}

final class ImageListPresenter: ImageListPresenterProtocol {
    var view: ImageListViewControllerProtocol?
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    }()
    
    func dateString(_ date: Date) -> String {
        dateFormatter.string(from: date)
    }
}

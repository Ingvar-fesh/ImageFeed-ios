import UIKit
import Kingfisher

protocol ImagesListCellDelegate: AnyObject {
    func imageListCellDidTapLike(_ cell: ImagesListCell)
}

final class ImagesListCell: UITableViewCell {
    static let reuseIdentifier = "ImagesListCell"
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet var imageCell: UIImageView!
    weak var delegate: ImagesListCellDelegate?
    
    
    @IBAction func likeOrDislikeButtonTapped(_ sender: Any) {
        delegate?.imageListCellDidTapLike(self)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageCell.kf.cancelDownloadTask()
    }
    
    func setIsLiked(isLiked: Bool) {
        let isLiked = isLiked ? UIImage(named: "Like_button") : UIImage(named: "Dislike_button")
        likeButton.setImage(isLiked, for: .normal)
    }
}

import Foundation
import UIKit
import Kingfisher
import WebKit

protocol ProfileViewControllerProtocol: AnyObject {
    var presenter: ProfilePresenterProtocol? { get set }
    func switchToSplashViewController()
}

final class ProfileViewController: UIViewController & ProfileViewControllerProtocol {
    var presenter: ProfilePresenterProtocol?
    
    private let profileService = ProfileService.shared
    
    private var profileImageServiceObserver: NSObjectProtocol?
    
    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }
    
    private let avatar: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = label.font.withSize(23)
        label.accessibilityIdentifier = "nameUser"
        return label
    }()
    
    
    private let logoutButton: UIButton = {
        let button = UIButton.systemButton(
            with: UIImage(named: "Log out")!,
            target: self,
            action: #selector(Self.logoutButtonTap)
        )
        button.tintColor = UIColor(named: "YP Red")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.accessibilityIdentifier = "logout"
        return button
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = label.font.withSize(13)
        return label
    }()
    
    private let loginLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.font = label.font.withSize(13)
        label.accessibilityIdentifier = "userName"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConstraints()
        view.backgroundColor = UIColor(named: "YP Black")
        updateAvatar()
        updateProfileDetails()
        
        profileImageServiceObserver = NotificationCenter.default.addObserver(
            forName: ProfileImageService.DidChangeNotification,
            object: nil,
            queue: .main) { [weak self] _ in
            guard let self = self else { return }
            self.updateAvatar()
        }
        
    }
    
    
    private func setConstraints() {
        view.addSubview(avatar)
        avatar.widthAnchor.constraint(equalToConstant: 70).isActive = true
        avatar.heightAnchor.constraint(equalToConstant: 70).isActive = true
        avatar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32).isActive = true
        avatar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        
        
        view.addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: avatar.bottomAnchor, constant: 8).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: avatar.leadingAnchor).isActive = true
        
        
        view.addSubview(logoutButton)
        logoutButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -26).isActive = true
        logoutButton.centerYAnchor.constraint(equalTo: avatar.centerYAnchor).isActive = true
        
        
        view.addSubview(loginLabel)
        loginLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8).isActive = true
        loginLabel.leadingAnchor.constraint(equalTo: avatar.leadingAnchor).isActive = true
        
        
        view.addSubview(descriptionLabel)
        descriptionLabel.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 8).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: avatar.leadingAnchor).isActive = true
        
    }
    
    func configure(_ presenter: ProfilePresenterProtocol) {
        self.presenter = presenter
        self.presenter?.view = self
    }
    
    public func updateProfileDetails() {
        var profileDetails: [String]?
        profileDetails = presenter?.updateProfileDetails()
        nameLabel.text = profileDetails?[0]
        loginLabel.text = profileDetails?[1]
        descriptionLabel.text = profileDetails?[2]
    }
    
    public func updateAvatar() {
        let processor = RoundCornerImageProcessor(cornerRadius: 35, backgroundColor: .clear)
        avatar.kf.indicatorType = .activity
        avatar.kf.setImage(with: presenter?.avatarURL(), placeholder: UIImage(named: "placeholder"), options: [.processor(processor), .cacheSerializer(FormatIndicatedCacheSerializer.png)])
    }
    
    @objc
    func logoutButtonTap() {
        showAlert()
    }
    
    private func showAlert() {
        let alertController = UIAlertController(title: "Пока!",
                                                message: "Уверены, что хотите выйти?",
                                                preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Да", style: .default, handler: { [weak self] action in
            guard let self = self else { return }
            self.presenter?.logout()
        })
        
        alertController.addAction(action)
        action.accessibilityIdentifier = "Yes action"
        alertController.addAction(UIAlertAction(title: "Нет", style: .default, handler: nil))
        alertController.view.accessibilityIdentifier = "Bye"
        present(alertController, animated: true, completion: nil)
    }
    
    
    func switchToSplashViewController() {
        guard let window = UIApplication.shared.windows.first else {
            fatalError("Invalid Configuration")
        }
        window.rootViewController = SplashViewController()
    }
}

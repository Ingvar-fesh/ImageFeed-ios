import Foundation
import UIKit

final class ProfileViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConstraints()
        fetchProfile()
    }
    
    private let avatar: UIImageView = {
        let profileImage = UIImage(named: "Avatar")
        let avatar = UIImageView(image: profileImage)
        avatar.translatesAutoresizingMaskIntoConstraints = false
        return avatar
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = label.font.withSize(23)
        return label
    }()
    
    private let logoutButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Log out"), for: .normal)
        button.tintColor = UIColor(named: "YP Red")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(ProfileViewController.self, action: #selector(logoutButtonTap), for: .touchUpInside)
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
        return label
    }()
    
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
    
    private func fetchProfile() {
         guard let token = OAuth2TokenStorage().token else { return }

         ProfileService().fetchProfile(token) { [weak self] result in
             guard let self = self else { return }
             switch result {
             case .success(let profile):
                 self.nameLabel.text = profile.name
                 self.loginLabel.text = profile.loginName
                 self.descriptionLabel.text = profile.bio
             case .failure(let error):
                 print(error)
             }
         }
     }
    
    @objc
    func logoutButtonTap() {
        print("New tep")
    }
}

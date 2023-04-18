import UIKit

protocol AuthViewDelegate: AnyObject {
    func authViewcontroller (_ vc: AuthViewController, didAuthenticateWithCode code: String)
}

final class AuthViewController: UIViewController {
    
    weak var delegate: AuthViewControllerDelegate?
    

    @IBAction func webViewShow(_ sender: Any) {
        let webViewController = WebViewController()
        webViewController.modalPresentationStyle = .fullScreen
        let authHelper = AuthHelper()
        let webViewPresenter = WebViewPresenter(authHelper: authHelper)
        webViewController.presenter = webViewPresenter
        webViewPresenter.view = webViewController
        webViewController.delegate = self
        present(webViewController, animated: true)
    }
}

extension AuthViewController: WebViewControllerDelegate {
    func webViewViewController(_ vc: WebViewController, didAuthenticateWithCode code: String) {
        delegate?.authViewController(self, didAuthenticateWithCode: code)
    }

    func webViewViewControllerDidCancel(_ vc: WebViewController) {
        dismiss(animated: true)
    }
}

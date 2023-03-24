import Foundation
import UIKit

class AuthViewController: UIViewController, WebViewControllerDelegate {
    func webViewViewController(_ vc: WebViewController, didAuthenticateWithCode code: String) {
        
    }
    
    func webViewViewControllerDidCancel(_ vc: WebViewController) {
        vc.dismiss(animated: true)
    }
    
    
}

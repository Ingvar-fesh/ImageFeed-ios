import Foundation

enum SplashParam {
    static let accessKey = "8auT6vOG2IJruCPkobFlYuQgDpRw-EkkB8Jws1xTDmc"
    static let secretKey = "bJIv096q-IhW388jxZ79V94cBaoASHihppVFjXIBStg"
    static let redirectURI = "urn:ietf:wg:oauth:2.0:oob"
    static let defaultBaseURL = URL(string: "https://api.unsplash.com")!
    static let accessScope = "public+read_user+write_likes"
    static let unsplashAuthorizeURLString = "https://unsplash.com/oauth/authorize"
}

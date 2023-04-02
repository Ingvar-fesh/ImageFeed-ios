import Foundation

enum CustomError: Error {
    case responseError
    case decodeError(error: String)
}

final class OAuth2Service {
    
    static let shared = OAuth2Service()
    
    private let urlSession = URLSession.shared
    
    
    func fetchAuthToken(code: String, completion: @escaping (Result<OAuthTokenResponseBody, Error>) -> Void) {
        let completionInMainThread: (Result<OAuthTokenResponseBody, Error>) -> Void = { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "unsplash.com"
        urlComponents.path = "/oauth/token"
        urlComponents.queryItems = [
            .init(name: "client_id", value: SplashParam.accessKey),
            .init(name: "client_secret", value: SplashParam.secretKey),
            .init(name: "redirect_uri", value: SplashParam.redirectURI),
            .init(name: "code", value: code),
            .init(name: "grant_type", value: "authorization_code")
        ]
        guard let url = urlComponents.url else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        urlSession.dataTask(with: request, completionHandler: { data, response, error in
            guard
                let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode > 200 || response.statusCode <= 300 else {
                completion(.failure(CustomError.responseError))
                return
                
            }
            do {
                let responseBody = try decoder.decode(OAuthTokenResponseBody.self, from: data)
                completionInMainThread(.success(responseBody))
            } catch {
                completionInMainThread(.failure(error))
            }
        }).resume()
    }
}

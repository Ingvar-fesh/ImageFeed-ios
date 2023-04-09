import Foundation

enum CustomError: Error {
    case responseError
    case decodeError(error: String)
}

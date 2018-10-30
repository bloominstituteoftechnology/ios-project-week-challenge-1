import UIKit

enum SplashScreen {
    // MARK: Use cases
    enum Manager {
        struct Request { }
        struct Response {
            var result: Result<Bool>
        }
        struct ViewModel {
            var result: Result<Any>
        }
    }
}

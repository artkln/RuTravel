//
//  
//

import UIKit
import FirebaseCore
import FirebaseAuth

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - Properties

    var window: UIWindow?

    // MARK: - Internal methods

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions
                     launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()

        let mainTabBarScreen = TabBarModuleConfigurator.configure()

        let frame = UIScreen.main.bounds
        window = UIWindow(frame: frame)
        window?.rootViewController = mainTabBarScreen
        window?.makeKeyAndVisible()

        return true
    }

}

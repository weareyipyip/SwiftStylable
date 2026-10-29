//
//  SceneDelegate.swift
//  SwiftStylableExample
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // The window and root view controller are created from Main.storyboard (UISceneStoryboardFile in Info.plist).
        guard scene is UIWindowScene else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system. Release any resources associated with this scene that can be re-created the next time the scene connects.
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Restart any tasks that were paused (or not yet started) while the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state, e.g. due to a temporary interruption (incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground; undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Use this method to save data, release shared resources, and store enough scene-specific state information to restore the scene back to its current state.
    }


}

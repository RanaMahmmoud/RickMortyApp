//
//  RickMortyAppApp.swift
//  RickMortyApp
//
//  Created by Rana Mahmoud on 04/12/2024.
//

import SwiftUI

@main
struct RickMortyAppApp: App {
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
    var body: some Scene {
        WindowGroup {
            LaunchView()
        }
    }

}
class AppDelegate: NSObject, UIApplicationDelegate ,ObservableObject{
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        UITableView.appearance().separatorStyle = .none
        return true
    }
}

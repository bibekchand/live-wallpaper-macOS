//
//  ManagerUserDefaults.swift
//  wallpaper
//
//  Created by Bibek Chand on 18/03/2026.
//

import Foundation

class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    private init () {}
    func retrieveUserDefault() {
        print("Retreiving URL...")
        if let videoURLData = UserDefaults.standard.data(forKey: "wallpaperURL") {
            var isStale: Bool = false
            if let url = try? URL(resolvingBookmarkData: videoURLData, options: .withSecurityScope, bookmarkDataIsStale: &isStale) {
                if url.startAccessingSecurityScopedResource() {
                    WallPaperViewController.shared.createWallPaper(url: url)
                }
            }
        }
    }
    func saveURL(url: URL) {
        do {
            let data = try url.bookmarkData(options: .withSecurityScope )
            UserDefaults.standard.set(data, forKey: "wallpaperURL")
        }
        catch {
            print("Error in saving the the url", error.localizedDescription)
        }
    }
}
